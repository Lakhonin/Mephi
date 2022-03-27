-- Процедура 1
-- Передаем id сотрудника, id кафедры, неограниченое количество {id издания,количество издания}
-- создаем заявки, создаем E14 и E8, заказ выбираем которые не выполнены 

create procedure proc1
@p_id_employee integer, @p_id_chair integer, @values varchar(max) as
begin /*proc */
if not exists (select e10.id_employee from Сотрудник_E10 e10 where e10.id_employee = @p_id_employee)
	begin
		raiserror ('Проверьте правильность введенного id сотрудника.', 16, 1 );
	end
else begin /*state 1*/
if not exists (select e7.id_chair from Кафедра_E7 e7 where e7.id_chair = @p_id_chair)
	begin
		raiserror ('Проверьте правильность введенного id кафедры.', 16, 2 );
	end
else begin /*state OK*/
	set @values = @values + ' '
	declare @delimeter nvarchar(1) = ' '
	declare @pos int = charindex(@delimeter,@values)
	declare @id_publication int
	declare @count_publication int
	declare @id_task int
	declare @id_purchase_order int
	declare @date_now date = (select getdate())
	declare @msg varchar(100) = 'Ошибка: Издание с таким ИД в БД отсутсвует. Error code = 1'
	while (@pos != 0)
		begin
			set @id_publication = SUBSTRING(@values, 1, @pos-1)
			set @values = SUBSTRING(@values, @pos+1, LEN(@values))
			set @pos = charindex(@delimeter,@values)
			set @count_publication = SUBSTRING(@values, 1, @pos-1)
			set @values = SUBSTRING(@values, @pos+1, LEN(@values))
			set @pos = charindex(@delimeter,@values)
			if exists (select e3.id_publication from Издание_E3 e3 where e3.id_publication = @id_publication)
				begin
					if(@count_publication !=0)
						begin
							set @id_task = (select max(id_task) + 1 from Заявка_E8)
							insert into Заявка_E8(id_chair,id_employee,id_task,date_task)
							values (@p_id_chair,@p_id_employee,@id_task,@date_now);
							print 'E8: Запись <Заявка> вставлена. Error code = 0'

							/*set @id_purchase_order = (select c.id_purchase_order from (
							select top 1 a.count_publication - b.count_publication ost_count_pub, a.id_purchase_order from (select e14.count_publication, e14.id_publication,e14.id_purchase_order from Заявки_в_заказе_E14 e14)a
							left join (select e15.count_publication ,e15.id_publication,e15.id_purchase_order from Заказ_в_акте_приема_E15 e15) b on b.id_purchase_order = a.id_purchase_order
							order by ost_count_pub desc) c)*/
							set @id_purchase_order = (select top 1 e4.id_purchase_order from Заказы_у_отдела_продаж_E17 e17 right join Заказ_на_приобретение_литературы_E4 e4 on e4.id_purchase_order = e17.id_purchase_order where e17.id_purchase_order is null)
							insert into Заявки_в_заказе_E14(id_task,id_purchase_order,id_publication,count_publication)
							values (@id_task,@id_purchase_order,@id_publication,@count_publication)
							print 'E14: Запись <Заявки в заказе> вставлена. Error code = 0'
						end
					else
						begin
							print 'Ошибка: Нулевое количество издания. Error code = 1'
						end
				end
			else
				begin
					print @msg
				end
		end
	end /*state OK*/
end /*state 1*/
end /*proc */

exec proc1 2,3,'2 3 25 54 6 7 2 5 4 7 5 3'
exec proc1 2,3,'2 4 4'
					
/*declare @count_publication int = 7
select top 1 a.count_publication - b.count_publication ost_count_pub, a.id_purchase_order from (select e14.count_publication, e14.id_publication,e14.id_purchase_order from Заявки_в_заказе_E14 e14)a
left join (select e15.count_publication ,e15.id_publication,e15.id_purchase_order from Заказ_в_акте_приема_E15 e15) b on b.id_purchase_order = a.id_purchase_order
order by ost_count_pub desc


(1 row(s) affected)
E8: Запись <Заявка> вставлена. Error code = 0

(1 row(s) affected)
E14: Запись <Заявки в заказе> вставлена. Error code = 0
Издание с таким ИД в БД отсутсвует. Error code = 1

(1 row(s) affected)
E8: Запись <Заявка> вставлена. Error code = 0

(1 row(s) affected)
E14: Запись <Заявки в заказе> вставлена. Error code = 0

(1 row(s) affected)
E8: Запись <Заявка> вставлена. Error code = 0

(1 row(s) affected)
E14: Запись <Заявки в заказе> вставлена. Error code = 0

(1 row(s) affected)
E8: Запись <Заявка> вставлена. Error code = 0

(1 row(s) affected)
E14: Запись <Заявки в заказе> вставлена. Error code = 0

(1 row(s) affected)
E8: Запись <Заявка> вставлена. Error code = 0

(1 row(s) affected)
E14: Запись <Заявки в заказе> вставлена. Error code = 0

