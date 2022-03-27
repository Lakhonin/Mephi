-- Запрос 2
-- Вывести статистику за 12 месяцев предыдущего года. 
-- 12 месяцев ->  12 строк. Каждая строка:
-- 1. название месяца
-- 2. количество заявок в месяц
-- 3. количество принятых изданий в месяц
-- 4. количество списанных изданий в месяц
-- 5. ФИО сотрудника оформившего больше документов в месяц

select e8.id_task, datepart(month, e8.date_task) month_date, year(e8.date_task) year_date, e8.id_employee from Заявка_E8 e8

select e5.id_employee, datepart(month, e5.date_reception) month_date, year(e5.date_reception) year_date, e15.count_publication from Акт_приема_E5 e5
left join Заказ_в_акте_приема_E15 e15 on e15.id_act_reception = e5.id_act_reception

select e6.id_employee, datepart(month, e6.date_debiting) month_date,year(e6.date_debiting) year_date,e12.count_publication from Акт_списания_E6 e6
left join Списанная_литература_E12 e12 on e12.id_act_debiting = e6.id_act_debiting


select *,
coalesce(count(a.id_employee) over (partition by a.id_employee,a.month_date,a.year_date order by a.month_date
			rows between unbounded preceding and current row), 0) sum_id_employee
from (
select e4.id_employee, datepart(month, e4.date_registration) month_date,year(e4.date_registration) year_date from Заказ_на_приобретение_литературы_E4 e4
union
select e8.id_employee, datepart(month, e8.date_task) month_date, year(e8.date_task) year_date from Заявка_E8 e8
union
(select e5.id_employee, datepart(month, e5.date_reception) month_date, year(e5.date_reception) year_date from Акт_приема_E5 e5
left join Заказ_в_акте_приема_E15 e15 on e15.id_act_reception = e5.id_act_reception)
union
(select e6.id_employee, datepart(month, e6.date_debiting) month_date,year(e6.date_debiting) year_date from Акт_списания_E6 e6
left join Списанная_литература_E12 e12 on e12.id_act_debiting = e6.id_act_debiting)
)a
order by a.month_date

select * from Заказ_на_приобретение_литературы_E4
insert into Заказ_на_приобретение_литературы_E4(id_purchase_order,id_employee,date_registration,date_transfer)
values (21,2,'01.03.2021',null)
