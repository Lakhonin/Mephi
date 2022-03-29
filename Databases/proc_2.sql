-- Процедура 2
 -- Передаем id издания, количество издания, тип операции, id сотрудника
 -- тип операции:
 -- 1. прием ( акт приема, заказ). При поступлении выбираем заказы с минимальным количеством изданий в заказе среди остальных
 -- 2. списание (акт списания)
--drop procedure proc2 
create procedure proc2 
@p_id_publication integer, @p_count_publication integer, @p_type integer, @p_id_employee integer AS
begin /*proc */
declare @t int
if not exists (select e3.id_publication from Издание_E3 e3 where e3.id_publication = @p_id_publication)
	begin
		raiserror ('Проверьте правильность введенного id издания.', 16, 1 );
	end
else begin /*state 1*/
if not exists (select id_publication from Заявки_в_заказе_E14 where id_publication = @p_id_publication)
	begin
		raiserror ('Проверьте правильность введенного id издания. Указанное издание не заказывали', 16, 2 );
	end
else 
	begin /*state OK*/
declare @p_id_act_debiting integer
declare @p_id_act_reception integer
declare @p_date date = (select getdate())
declare @p_reason varchar(20) = 'По требованию'
declare @p_id_purchase_order integer

	if (@p_type = 1)  
		begin
			set @t = (select  sum(a.count_publication - b.count_publication) ost_count_pub from (select e14.count_publication, e14.id_publication,e14.id_purchase_order from Заявки_в_заказе_E14 e14 where e14.id_publication = @p_id_publication)a
			left join (select e15.count_publication ,e15.id_publication,e15.id_purchase_order from Заказ_в_акте_приема_E15 e15) b on b.id_purchase_order = a.id_purchase_order)
			if(@t > @p_count_publication)
				begin			
					set @p_id_purchase_order = (select c.id_purchase_order from (
					select top 1 a.count_publication - b.count_publication ost_count_pub, a.id_purchase_order from (select e14.count_publication, e14.id_publication,e14.id_purchase_order from Заявки_в_заказе_E14 e14 where e14.id_publication = @p_id_publication)a
					left join (select e15.count_publication ,e15.id_publication,e15.id_purchase_order from Заказ_в_акте_приема_E15 e15) b on b.id_purchase_order = a.id_purchase_order where (a.count_publication - b.count_publication) > @p_count_publication
					order by ost_count_pub) c)
					
					if(@p_id_purchase_order >0)
						begin
							set @p_id_act_reception = (select max(id_act_reception) + 1 from Акт_приема_E5)
							insert into Акт_приема_E5(id_act_reception,id_employee,date_reception)
							values (@p_id_act_reception,@p_id_employee,@p_date);
							print 'E5: Запись <Акт приема> вставлена. Error code = 0'
						
							set @p_id_purchase_order = (select c.id_purchase_order from (
							select top 1 a.count_publication - b.count_publication ost_count_pub, a.id_purchase_order from (select e14.count_publication, e14.id_publication,e14.id_purchase_order from Заявки_в_заказе_E14 e14 where e14.id_publication = @p_id_publication)a
							left join (select e15.count_publication ,e15.id_publication,e15.id_purchase_order from Заказ_в_акте_приема_E15 e15) b on b.id_purchase_order = a.id_purchase_order where (a.count_publication - b.count_publication) > @p_count_publication
							order by ost_count_pub) c)
					
							insert into Заказ_в_акте_приема_E15(id_publication,id_act_reception,count_publication,id_purchase_order)
							values (@p_id_publication,@p_id_act_reception,@p_count_publication,@p_id_purchase_order)
							print 'E15: Запись <Заказ в акте приема> вставлена. Error code = 0'
			
							update Издание_E3
							set count_publication = (select e3.count_publication from Издание_E3 e3 where e3.id_publication = @p_id_publication) + @p_count_publication
							where id_publication = @p_id_publication
							print 'E3: Запись <Издание> обновлена. Error code = 0'
						end
					else
						begin
							raiserror ('Проверьте правильность введенного id издания. Не заказывали издание', 16, 3 );
						end
				end
			else
				begin
					raiserror ('Проверьте правильность введенного id издания. Общее количество поставляемого издания превышает общее количество заказанного', 16, 4 );
				end
		end
	else if (@p_type = 2) 
		begin
			set @t =(select e3.count_publication from Издание_E3 e3 where e3.id_publication = @p_id_publication)
			if(@t > @p_count_publication)
				begin
					set @p_id_act_debiting = (select max(id_act_debiting) + 1 from Акт_списания_E6)
					insert into Акт_списания_E6(id_act_debiting,id_employee,date_debiting,reason)
					values (@p_id_act_debiting,@p_id_employee,@p_date,@p_reason)
					print 'E6: Запись <Акт списания> вставлена. Error code = 0'

					insert into Списанная_литература_E12(id_act_debiting,id_publication,count_publication)
					values (@p_id_act_debiting,@p_id_publication,@p_count_publication)
					print 'E12: Запись <Списанная литература> вставлена. Error code = 0'

					update Издание_E3
					set count_publication = (select e3.count_publication from Издание_E3 e3 where e3.id_publication = @p_id_publication) - @p_count_publication
					where id_publication = @p_id_publication
					print 'E3: Запись <Издание> обновлена. Error code = 0'
				end
			else
				begin
					raiserror ('Проверьте правильность введенного ИД издания или его количества. Общее кол-во издания на складе меньше количества издания под списание', 16, 4 );
				end
		end
	else begin
			raiserror ('Проверьте правильность типа операции.', 16, 5 );
	    end
	end /*state OK */
end /*state 1*/
end /*proc*/

select * from Акт_списания_E6
select * from Списанная_литература_E12
select * from Издание_E3
select * from Сотрудник_E10
select * from Заявки_в_заказе_E14
select * from Акт_приема_E5
select * from Заказ_в_акте_приема_E15
exec proc2 21, 29, 1, 3

/*

declare @p_count_publication int = 29
declare @p_id_publication int = 21
(select c.id_purchase_order from (
select top 1 a.count_publication - b.count_publication ost_count_pub, a.id_purchase_order from (select e14.count_publication, e14.id_publication,e14.id_purchase_order from Заявки_в_заказе_E14 e14 where e14.id_publication = @p_id_publication)a
left join (select e15.count_publication ,e15.id_publication,e15.id_purchase_order from Заказ_в_акте_приема_E15 e15) b on b.id_purchase_order = a.id_purchase_order where (a.count_publication - b.count_publication) > @p_count_publication
order by ost_count_pub) c)
*/
