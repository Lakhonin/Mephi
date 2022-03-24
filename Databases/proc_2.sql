-- Процедура 2
-- Передаем id издания, количество издания, тип операции, id сотрудника
-- тип операции:
-- 1. прием ( акт приема, заказ). При поступлении выбираем заказы с минимальным количеством изданий в заказе среди остальных
-- 2. списание (акт списания)

CREATE PROCEDURE proc2 
@p_id_publication integer, @p_count_publication integer, @p_type integer, @p_id_employee integer AS
BEGIN /*proc */
if not exists (select e3.id_publication from Издание_E3 e3 where e3.id_publication = @p_id_publication)
	begin
		raiserror ('Проверьте правильность введенного id издания.', 16, 1 );
	end
else begin /*state 1*/
if not exists (select id_publication from Заявки_в_заказе_E14 where id_publication = @p_id_publication)
	begin
		raiserror ('Проверьте правильность введенного id издания. Указанное издание не заказывали', 16, 2 );
	end
/*else begin /*state 2*/
if not exists ((select SUM(count_publication) from Заявки_в_заказе_E14 where id_publication = @p_id_publication) < (select SUM(count_publication) + @p_id_publication from Заказ_в_акте_приема_E15 where id_publication = @p_id_publication))
	begin
		raiserror ('Проверьте правильность введенного id издания. Общее количество поставляемого издания превышает общее количество заказанного', 16, 3 );
	end
else begin /*state 3*/
if not exists ((select e3.count from Издание_E3 e3 where e3.id_publication = @p_id_publication) < @p_count_publication)
	begin
		raiserror ('Проверьте правильность введенного id издания. Общее количество введеного издания превышает общее количество издания на складе', 16, 4 );
	end*/
else begin /*state OK*/
DECLARE @p_id_act_debiting integer
DECLARE @p_id_act_reception integer
DECLARE @p_date date
DECLARE @p_reason varchar(20)
DECLARE @p_id_purchase_order integer

	IF (@p_type = 1)  
		BEGIN
			INSERT INTO Акт_приема_E5
			VALUES (@p_id_act_reception,@p_id_employee,@p_date);
			set @p_id_act_reception = (select MAX(id_act_reception) + 1 from Акт_приема_E5)
			set @p_date = GETDATE ()
			print 'E5: Запись <Акт приема> вставлена. Error code = 0'

			INSERT INTO Заказ_в_акте_приема_E15
			VALUES (@p_id_publication,@p_id_act_reception,@p_count_publication,@p_date)
			SET @p_id_purchase_order = (select distinct MAX(id_purchase_order) from Заявки_в_заказе_E14 where id_publication = @p_id_publication)
			set @p_date = GETDATE ()
			print 'E15: Запись <Заказ в акте приема> вставлена. Error code = 0'
			UPDATE Издание_E3
			SET count = (select e3.count from Издание_E3 e3 where e3.id_publication = @p_id_publication) + @p_count_publication
			print 'E3: Запись <Издание> обновлена. Error code = 0'
		END
	ELSE IF (@p_type = 2) 
		BEGIN
			INSERT INTO Акт_списания_E6
			VALUES (@p_id_act_debiting,@p_id_employee,@p_date,@p_reason)
			set @p_id_act_debiting = (select MAX(id_act_debiting) + 1 from Акт_списания_E6)
			set @p_date = GETDATE ()
			SET @p_reason = 'Списан'
			print 'E6: Запись <Акт списания> вставлена. Error code = 0'
			UPDATE Издание_E3
			SET count = (select e3.count from Издание_E3 e3 where e3.id_publication = @p_id_publication) - @p_count_publication
			print 'E3: Запись <Издание> обновлена. Error code = 0'
		END
	ELSE BEGIN
			raiserror ('Проверьте правильность типа операции.', 16, 5 );
	    END
END /*state OK */
--END /*state 3*/
--END /*state 2*/
END /*state 1*/
END /*proc*/
