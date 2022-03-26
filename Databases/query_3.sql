-- Запрос 3
-- Вывести статистику по кварталам. 
-- 1 квартал ->  1 столбец. Каждая строка:
-- 1. номер квартала
-- 2. количество актов приема
-- 3. количество актов списания
-- 4. количество заказов в этом квартале


select 
d.quarter_year 'Квартал',
sum(d.count_act_reception) 'Кол-во актов приема',
sum(d.count_act_debiting) 'Кол-во актов списания',
sum(d.count_purchase_order) 'Кол-во заказов'		
	from (
	select c.quarter_year, count(c.id_act_debiting) count_act_debiting, 0 count_purchase_order, 0 count_act_reception from
	(select e6.id_act_debiting, datepart(quarter, e6.date_debiting) quarter_year, year(e6.date_debiting) year_date_debiting from Акт_списания_E6 e6) c
		where c.year_date_debiting = year(GETDATE())-1
	group by c.quarter_year
union 
	select b.quarter_year, 0 count_act_debiting, 0 count_purchase_order,count(b.id_act_reception) count_act_reception from 
	(select e5.id_act_reception, datepart(quarter, e5.date_reception) quarter_year, year(e5.date_reception) year_date_reception from Акт_приема_E5 e5) b
		where b.year_date_reception = year(GETDATE())-1
	group by b.quarter_year
union
	select a.quarter_year, 0 count_act_debiting,count(a.id_purchase_order) count_purchase_order, 0 count_act_reception from
	(select e4.id_purchase_order , datepart(quarter, e4.date_registration) quarter_year, year(e4.date_registration) year_date_registration from Заказ_на_приобретение_литературы_E4 e4) a 
		where a.year_date_registration = year(GETDATE())-1
	group by a.quarter_year
	) d
group by d.quarter_year
