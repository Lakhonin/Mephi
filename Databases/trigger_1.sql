-- Триггер 1 
-- при создании заявки  E15, изменяется количество издания в E3

CREATE TRIGGER E15_INSERT_UPDATE
ON Заказ_в_акте_приема_E15
WITH EXECUTE AS CALLER
AFTER INSERT
AS
BEGIN
UPDATE Издание_E3
SET count = count + (SELECT SUM(count_publication) FROM inserted I where I.id_publication = Издание_E3.id_publication)
END
