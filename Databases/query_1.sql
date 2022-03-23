-- Запрос 1
-- Вывести для каждой кафедры
-- 1. название кафедры
-- 2. фио заведущего (одним полем)
-- 3. количество заявок
-- 4. общее количество изданий в заявках
-- 5. название издания что чаще заказывают + автор издания (одним полем)
-- 6. количество издания из предыдущего пункта
-- сортировка по дате первой заявки кафедры (возрастание)

select e7.title 'Название кафедры', e7.name_head + ' ' + e7.surname_head + ' ' + e7.middlename_head 'ФИО заведующего кафедры'
case when a.qty is not null then a.qty else '0' end 'Количество заявок',
case when b.qty is not null then b.qty else '0' end 'Общее количество изданий в заявках'
--case when c.qty is not null then c.qty else '0' end 'Название и автор издания чаще заказанного',
--case when d.qty is not null then d.qty else '0' end 'Кол-во издания чаще заказанного'
from Кафедра_E7 e7 full join Заявка_E8 e8 on e8.id_chair = e7.id_chair
left outer join (select Count(e8.id_task) qty, e8.id_chair from Заявка_E8 e8 group by e8.id_chair) a on a.id_chair = e7.id_chair
left outer join (select SUM(e14.count_publication) qty, e14.id_task from Заявки_в_заказе_E14 e14 group by e14.id_task) b on b.id_task = e8.id_task

