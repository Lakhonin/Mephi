-- Триггер 2
-- При создании заявки в отдел продаж проверяет, не превышает ли количество запрашиваемых изданий количества изданий в плане издательств за текущий год
-- выдает ошибки/оповещения 
-- обязательное использование курсора (планы)
-- в E13 добавить атрибут "дата"

create trigger triger2
on Заказы_у_отдела_продаж_E17
instead of insert as
begin
	declare @id_publication int, @id_plans_publishing int, @count_publication int, @date date
	declare @data_now date = '2022'
	declare e13_crsr CURSOR
	for select id_publication, id_plans_publishing,count_publication, date from Издаваемая_литература_E13
	open e13_crsr
	FETCH NEXT FROM e13_crsr into @id_publication, @id_plans_publishing,@count_publication,@date
	WHILE(@@FETCH_STATUS=0)
	begin
		if(@id_publication != inserted.id_publication)
		begin
			print '1'
		end
		else if(@data_now != @date)
		begin
			print '2'
		end
		else if(@count_publication < inserted.count_publication)
		begin
			print 'Количество издания превышает количества выпущенного издания в текущем году'
		end	
		else
		begin
			print 'Количество издания не превышает количества выпущенного издания в текущем году'	
		end
		FETCH NEXT FROM e13_crsr into @id_publication, @id_plans_publishing,@count_publication,@date
	end
	ClOSE e13_crsr
	DEALLOCATE e13_crsr
end
