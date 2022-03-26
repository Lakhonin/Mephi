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

select * from Акт_списания_E6 e6
left join Списанная_литература_E12 e12 on e12.id_act_debiting = e6.id_act_debiting
