-- Процедура 1
-- Передаем id сотрудника, id кафедры, неограниченое количество {id издания,количество издания}
-- создаем заявки, если есть невыполненые заказы, создаем E14 и E17


CREATE PROCEDURE proc1
@p_id_employee integer, @p_id_chair integer, @p_id_publication integer, @p_count_publication integer AS
BEGIN /*proc */
if not exists (select e10.id_employee from Сотрудник_E10 e10 where e10.id_employee = @p_id_employee)
	begin
		raiserror ('Проверьте правильность введенного id сотрудника.', 16, 1 );
	end
else begin /*state 1*/
if not exists (select e7.id_chair from Кафедра_E7 e7 where e7.id_chair = @p_id_chair)
	begin
		raiserror ('Проверьте правильность введенного id кафедры.', 16, 1 );
	end
else begin /*state 2*/
if not exists (select e3.id_publication from Издание_E3 e3 where e3.id_publication = @p_id_publication)
	begin
		raiserror ('Проверьте правильность введенного id издания.', 16, 1 );
	end
else begin /*state OK*/
--1 определяем какие id_task нет в E14
--2 создаем E14 id_publication id_chair count_publication id_purchase_order, id_purchase_order = id_purchase_order (E4 нет) в E15
--3 Создаем E17 id_publication count_publication id_purchase_order id_sales_department, id_sales_department 


end /*state OK*/
end /*state 2*/
end /*state 1*/
END /*proc */

