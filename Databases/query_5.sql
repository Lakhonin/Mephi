-- Запрос 5
-- Вывести топ 5 кафедр заказывающие больше самых популярных изданий
-- популярность = E14
-- сортировка по количеству заказанных изданий (уменьшение)
-- 1. id кафедры
-- 2. title кафедры
-- 3. количество заказаных популярных изданий
-- 4. количество заявок, в которых находятся заказанные популярные издания
-- 5. дата последней заявки

select 
top 5 e7.id_chair 'Иден-тор кафедры', 
e7.title 'Название кафедры',
c.full_count_publication 'Общее кол-во заказ поп изданий',
c.count_task 'Кол-во заявок (заказ поп издания)',
c.date_last_task 'Дата последней заявки'
from Кафедра_E7 e7
full join (
select e8.id_chair, max(e8.date_task) date_last_task, count(e8.id_task) count_task, sum(e14.count_publication) full_count_publication from Заявка_E8 e8
left join Заявки_в_заказе_E14 e14 on e14.id_task = e8.id_task
left join (select count(e14.id_publication) top_publication, e14.id_publication from Заявки_в_заказе_E14 e14
		group by e14.id_publication) a on a.id_publication = e14.id_publication
where a.top_publication in (select max(b.top_publication) max_top_publication from (select count(e14.id_publication) top_publication, e14.id_publication from Заявки_в_заказе_E14 e14
														group by e14.id_publication) as b)
group by e8.id_chair) c on c.id_chair = e7.id_chair
where c.count_task is not null
order by c.count_task desc
