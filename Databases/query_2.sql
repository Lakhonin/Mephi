-- Запрос 2
-- Вывести статистику за 12 месяцев прошлого года. 
-- 12 месяцев ->  12 строк. Каждая строка:
-- 1. название месяца
-- 2. количество заявок в месяц
-- 3. количество принятых изданий в месяц
-- 4. количество списанных изданий в месяц

with months as(
		select 1 month_id 
		union all
		select month_id + 1 from months where month_id < 12
		)
 select 
 --months.month_id
 case months.month_id when 1 then 'Январь'when 2 then 'Февраль' when 3 then 'Март'when 4 then 'Апрель'when 5 then 'Май' when 6 then 'Июнь' when 7 then 'Июль' when 8 then 'Август' when 9 then 'Сентябрь' when 10 then 'Октябрь' when 11 then 'Ноябрь' when 12 then 'Декабрь' end Месяц,
 case when b.count_task is null then '0' else b.count_task end 'Кол-во заявок',
 case when a.count_pub_reception is not null then a.count_pub_reception else '0' end 'Кол-во принятых изданий',
  case when c.count_pub_debiting is not null then c.count_pub_debiting else '0' end 'Кол-во списанных изданий'
 from months left join (select month_date, sum(c.count_publication) count_pub_reception from(
	select datepart(month, e5.date_reception) month_date, year(e5.date_reception) year_date, e15.count_publication from Акт_приема_E5 e5
	left join Заказ_в_акте_приема_E15 e15 on e15.id_act_reception = e5.id_act_reception) c
	where year_date = (select year(getdate())-1)
	group by month_date) a on a.month_date = months.month_id
left join (select month_date, count(a.task) count_task  
	from (select e8.id_task task, datepart(month, e8.date_task) month_date, year(e8.date_task) year_date from Заявка_E8 e8 where year(e8.date_task)=(select year(getdate())-1) ) a
	group by month_date)b on b.month_date = months.month_id
left join (select month_date,sum(b.count_publication) count_pub_debiting from (
	select datepart(month,e6.date_debiting) month_date, year(e6.date_debiting) year_date, 12.count_publication from Акт_списания_E6 e6 
	left join Списанная_литература_E12 e12 on e12.id_act_debiting = e6.id_act_debiting) b 
	where year_date = (select year(getdate())-1)
	group by month_date) c on c.month_date = months.month_id
