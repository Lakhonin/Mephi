-- Триггер 1 
-- при создании заявки  E15, изменяется количество издания в E3
create trigger triger1
on Заказ_в_акте_приема_E15
after insert
as
begin
	declare @i int
	set @i = (select max(a.t) from (select row_number() over(order by i.id_act_reception) t, * from inserted i) a) 
	while (@i != 0)
		begin
			update Издание_E3
			set count_publication = count_publication + (select a.count_publication from (select row_number() over(order by i.id_act_reception) t, * from inserted i) a where a.t = @i)
			where id_publication = (select a.id_publication from (select row_number() over(order by i.id_act_reception) t, * from inserted i) a where a.t = @i)
			set @i = @i -1
		end
end
