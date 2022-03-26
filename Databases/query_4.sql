-- Запрос 4
-- для каждой пары "издателство/издание" вывести статистику с наполнением
-- 1. название издательства
-- 2. название издания
-- 3. количества издания на складе (E3)
-- 4. изменение количества
-- 5. тип изменения ("+" или "-")
-- 6. дата изменения

select 
case when (a.id_publishing = LAG(a.id_publishing) OVER(ORDER BY a.id_publishing,a.id_publication,b.date_operation) and a.id_publication = LAG(a.id_publication) OVER(ORDER BY a.id_publishing,a.id_publication,b.date_operation)
) then '0' else '1' end first,
*
from (
		select e3.id_publication, e3.title title_publication, e1.title title_publishing, e3.count_publication,e13.date_plans, e1.id_publishing
		from Издательство_E1 e1
		full join Планы_издательств_E11 e11 on e11.id_publishing = e1.id_publishing
		full join Издаваемая_литература_E13 e13 on e13.id_plans_publishing = e11.id_plans_publishing
		full join Издание_E3 e3 on e3.id_publication = e13.id_publication
		) a
	full join (select e12.id_publication, e6.date_debiting date_operation,e12.count_publication, '-' as type_operation 
			from Списанная_литература_E12 e12 
			left join Акт_списания_E6 e6 on e6.id_act_debiting = e12.id_act_debiting
		union
			select e15.id_publication,e5.date_reception date_operation,e15.count_publication, '+' as type_operation
			from Заказ_в_акте_приема_E15 e15
			left join Акт_приема_E5 e5 on e15.id_act_reception = e5.id_act_reception) b on b.id_publication = a.id_publication
	where a.id_publishing is not null and a.id_publication is not null
	order by a.id_publishing,a.id_publication,b.date_operation
