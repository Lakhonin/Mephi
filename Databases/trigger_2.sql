-- Триггер 2
-- При создании заказа в отдел продаж проверяет, не превышает ли количество запрашиваемых изданий количества изданий в плане издательств за текущий год
-- выдает ошибки/оповещения 
-- обязательное использование курсора (планы)

--drop trigger triger2
create trigger triger2
on Заказы_у_отдела_продаж_E17
instead of insert
as
begin
	declare @i int
	declare @year_now int = (select year(getdate()))
	declare @t int
	declare @id_publication int, @id_plans_publishing int, @count_publication int, @date_plans date
	declare @tr_id_sales_department int, @tr_id_publication int ,@tr_id_task int,@tr_id_purchase_order int, @tr_count_publication int
	declare tr2_crsr cursor for select id_publication, id_plans_publishing,count_publication, date_plans from Издаваемая_литература_E13
	set @i = (select max(a.t) from (select row_number() over(order by i.id_publication) t, * from inserted i) a) 
	while (@i != 0)
		begin
			set @tr_id_publication = (select a.id_publication from (select row_number() over(order by i.id_publication) t, * from inserted i) a where a.t = @i)
			set @tr_count_publication =(select a.count_publication from (select row_number() over(order by i.id_publication) t, * from inserted i) a where a.t = @i)
			open tr2_crsr
			fetch next from tr2_crsr into @id_publication, @id_plans_publishing,@count_publication,@date_plans
			while(@@FETCH_STATUS=0)
			begin
				if(@tr_id_publication = @id_publication)
				begin
					set @t = year(@date_plans)
					if(@t = @year_now)
					begin
						if(@tr_count_publication < @count_publication)
						begin
							set @tr_id_sales_department = (select a.id_sales_department from (select row_number() over(order by i.id_publication) t, * from inserted i) a where a.t = @i)
							set @tr_id_purchase_order = (select a.id_purchase_order from (select row_number() over(order by i.id_publication) t, * from inserted i) a where a.t = @i)
							set @tr_id_task = (select a.id_task from (select row_number() over(order by i.id_publication) t, * from inserted i) a where a.t = @i)
							insert into Заказы_у_отдела_продаж_E17(id_sales_department,id_task,id_purchase_order,id_publication,count_publication)
							values (@tr_id_sales_department,@tr_id_task,@tr_id_purchase_order,@tr_id_publication,@tr_count_publication)
							print 'E17: <Заказы_у_отдела_продаж> вставлена.'
						end
						else
						begin
							print 'Ошибка: Количество изданий в планах издательства меньше чем заказаное число изданий.'
						end
					end
					else
					begin
						print 'Ошибка: Указанное издание издательство в текущем году не издает.'	
					end
				end
			fetch next from tr2_crsr into @id_publication, @id_plans_publishing,@count_publication,@date_plans		
			end
		close tr2_crsr
		set @i = @i -1
		end
	deallocate tr2_crsr
end

insert into Заказы_у_отдела_продаж_E17(id_sales_department,id_task,id_purchase_order,id_publication,count_publication)
values('2','16','4','8','50'),
('3','16','4','4','452'),
('4','16','4','5','200'),


select * from Заявки_в_заказе_E14
select * from Издаваемая_литература_E13
select * from Заказы_у_отдела_продаж_E17
select * from dbo.Заявка_E8
select * from Отдел_продаж_E9

insert into Заявки_в_заказе_E14(id_purchase_order,id_task,id_publication,count_publication)
values ('4','16','8','50'),
('4','16','4','452') ,
('4','16','5','200')
