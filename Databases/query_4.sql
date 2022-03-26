-- Запрос 4
-- для каждой пары "издателство/издание" вывести статистику с наполнением
-- 1. название издательства
-- 2. название издания
-- 3. количества издания на складе (E3)
-- 4. изменение количества
-- 5. тип изменения ("+" или "-")
-- 6. дата изменения


	select e3.id_publication, e1.title, e3.title, e3.count_publication
	from Издательство_E1 e1
	left join Планы_издательств_E11 e11 on e11.id_publishing = e1.id_publishing
	left join Издаваемая_литература_E13 e13 on e13.id_plans_publishing = e11.id_plans_publishing
	left join Издание_E3 e3 on e3.id_publication = e11.id_publishing
	where e1.id_publishing is not null and e3.id_publication is not null

	select e15.id_publication, e15.count_publication,e15.id_act_reception,e5.date_reception from Заказ_в_акте_приема_E15 e15
	left join Акт_приема_E5 e5 on e15.id_act_reception = e5.id_act_reception
	order by e5.date_reception

	select e12.id_publication, e12.count_publication, e6.date_debiting, e6.id_act_debiting from Списанная_литература_E12 e12 
	left join Акт_списания_E6 e6 on e6.id_act_debiting = e12.id_act_debiting
	order by e6.date_debiting
