-- Запрос 1
-- Вывести для каждой кафедры
-- 1. название кафедры
-- 2. фио заведущего (одним полем)
-- 3. количество заявок
-- 4. общее количество изданий в заявках
-- 5. название издания что чаще заказывают + автор издания (одним полем)
-- 6. количество издания из предыдущего пункта
-- сортировка по дате первой заявки кафедры (возрастание)

select 
--*,
e7.title 'Название кафедры',
case when e7.middlename_head is not null then e7.surname_head + ' ' + e7.name_head + ' ' + e7.middlename_head  else e7.surname_head + ' ' + e7.name_head end  'ФИО заведующего кафедры',
case when a.count_task is not null then a.count_task else '0' end 'Количество заявок',
case when a.count_publication is not null then a.count_publication else '0' end 'Общее количество изданий в заявках'
--case when c.qty is not null then c.qty else '0' end 'Название и автор чаще заказанного издания',
--case when d.qty is not null then d.qty else '0' end 'Кол-во чаще заказанного издания'
from Кафедра_E7 e7
left join (select max(e8.date_task) last_task_time,e8.id_chair,count(e8.id_task) count_task,sum(e14.count_publication) count_publication
			from Заявка_E8 e8 left join Заявки_в_заказе_E14 e14 on e14.id_task = e8.id_task
			group by e8.id_chair
			) a on a.id_chair = e7.id_chair
order by a.last_task_time asc
