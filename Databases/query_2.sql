-- Запрос 2
-- Вывести статистику за 12 месяцев предыдущего года. 
-- 12 месяцев ->  12 строк. Каждая строка:
-- 1. название месяца
-- 2. количество заявок в месяц
-- 3. количество принятых изданий в месяц
-- 4. количество списанных изданий в месяц
-- 5. ФИО сотрудника оформившего больше документов в месяц



select * from (
				select e8.id_task task, datepart(month, e8.date_task) month_date, year(e8.date_task) year_date, e8.id_employee employee,0 count_pub, 1 ch from Заявка_E8 e8
				
	
	union 
				select 0 task, datepart(month, e5.date_reception) month_date, year(e5.date_reception) year_date, e5.id_employee employee, e15.count_publication count_pub, 2 ch from Акт_приема_E5 e5
				left join Заказ_в_акте_приема_E15 e15 on e15.id_act_reception = e5.id_act_reception
				
	union 
				select 0 task,datepart(month,e4.date_registration) month_date, datepart(year,e4.date_registration) year_date,e4.id_employee employee,0 count_pub,4 ch from Заказ_на_приобретение_литературы_E4 e4
		)a
	where a.year_date = (select year(getdate())-1)
		
				
	union 
							
	

	select 0 task, datepart(month, e6.date_debiting) month_date,year(e6.date_debiting) year_date, e6.id_employee employee, 12.count_publication count_pub, 3 ch from Акт_списания_E6 e6
				left join Списанная_литература_E12 e12 on e12.id_act_debiting = e6.id_act_debiting
