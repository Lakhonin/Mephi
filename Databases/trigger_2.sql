-- Триггер 2
-- При создании заявки в отдел продаж проверяет, не превышает ли количество запрашиваемых изданий количества изданий в плане издательств за текущий год
-- выдает ошибки/оповещения 
-- обязательное использование курсора (планы)
-- в E13 добавить атрибут "дата"

CREATE TRIGGER 

/*
CREATE TRIGGER e17_insert
ON Заказы_у_отдела_продаж_E17
AFTER INSERT AS
BEGIN
DECLARE @id_postavka int = 0, @numpersonal int = 0
DECLARE Personal_crsr CURSOR
FOR SELECT NumOfPersonal,id_postavka FROM inserted
OPEN Personal_crsr
FETCH NEXT FROM Personal_crsr INTO @numpersonal, @id_postavka
WHILE(@@FETCH_STATUS=0)
BEGIN
	IF (@numpersonal = 0)
		BEGIN
		UPDATE Договор_о_поставках_E4
		SET NumOfPersonal = (select NumOfPersonal from (select TOP(1)NumOfPersonal, Count(*) as col from Договор_о_поставках_E4 where NumOfPersonal > 0 GROUP BY NumOfPersonal ORDER BY col) as t)
		WHERE id_postavka = @id_postavka
		END
	FETCH NEXT FROM Personal_crsr INTO @numpersonal, @id_postavka
END	
ClOSE Personal_crsr
DEALLOCATE Personal_crsr
END
*/
