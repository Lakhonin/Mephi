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
e7.title 'Название кафедры',
case when e7.middlename_head is not null then e7.surname_head + ' ' + e7.name_head + ' ' + e7.middlename_head  else e7.surname_head + ' ' + e7.name_head end  'ФИО заведующего кафедры',
case when a.count_task is not null then a.count_task else '0' end 'Количество заявок',
case when a.count_publication is not null then a.count_publication else '0' end 'Общее количество изданий в заявках',
case when c.middlename is not null then c.title + ' ' + c.surname + ' ' + c.name + ' ' + c.middlename else c.title + ' ' + c.surname + ' ' + c.name end 'Название и ФИО автора издания чаще заказ-ют' ,
case when c.count_pub_task is not null then c.count_pub_task else '0' end 'Кол-во издания в заявках из пред пункта'
from Кафедра_E7 e7 
left join (select min(e8.date_task) last_task_time,e8.id_chair,count(e8.id_task) count_task,sum(e14.count_publication) count_publication,min(e14.id_publication) min_id_count_publication
			from Заявка_E8 e8 left join Заявки_в_заказе_E14 e14 on e14.id_task = e8.id_task
			group by e8.id_chair) a on a.id_chair = e7.id_chair
left join (select b.id_chair,c.id_publication,d.title,d.name,d.surname,d.middlename,c.count_pub_task from (select max(a.id_count_publication) max_id_count_publication, a.id_chair from
			(select count(e14.id_publication) id_count_publication, e14.id_publication, e8.id_chair
			from Заявка_E8 e8 left join Заявки_в_заказе_E14 e14 on e14.id_task = e8.id_task
			group by e8.id_chair,e14.id_publication) a
			group by a.id_chair) b
left join (select count(e14.id_publication) max_id_count_publication, sum(e14.count_publication) count_pub_task, e8.id_chair, id_publication from Заявка_E8 e8 
			left join Заявки_в_заказе_E14 e14 on e14.id_task = e8.id_task group by e8.id_chair,e14.id_publication)
			c on c.id_chair = b.id_chair and c.max_id_count_publication = b.max_id_count_publication
			left join (select e3.title,e3.id_publication,e2.name,e2.surname,e2.middlename,e3.count_publication from Издание_E3 e3 left join Автор_E2 e2 on e2.id_author = e3.id_author) d on d.id_publication = c.id_publication
			) c on c.id_chair = a.id_chair
order by last_task_time asc
