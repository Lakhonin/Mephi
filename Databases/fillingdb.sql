-- Наполнение базы данных
INSERT INTO Издательство_E1 (id_publishing,title,city,description)
VALUES ('1','Владос','Катайск','Гуманитарный издательский центр'),
('2','АСТ','Москва','Издательская группа'),
('3','URSS.ru','Дедовск','Издательская группа'),
('4','ГРАНД-ФАИР','Гусев','Издательская группа'),
('5','Интеллект','Вичуга','Издательская группа'),
('6','ИНФРА-М','Волжск','Издательский Дом'),
('7','ОНИКС','Белоусово','Издательский Дом'),
('8','ПИТЕР','Санкт Питербург','Издательский Дом'),
('12','Омега','Артем','Юридическое издательство '),
('13','Просвещение','Адыгея','Издательско-книготорговое объединение');

INSERT INTO Автор_E2 (id_author,name,surname,middlename,biography)
VALUES ('13','Джейн','Остин','Микки','США'),
('2','Луиза','Олкотт','Мей','Великобритания'),
('3','Лев','Толстой','Николаевич','Россия'),
('5','Клайв','Стейл','Льюис','США');

INSERT INTO Автор_E2 (id_author,name,surname,biography)
VALUES ('4','Невил','Шот','Италия'),
('6','Шарлотта','Бронте','США'),
('7','Джозеф','Хеллер','США'),
('8','Себастян','Фолкс','Великобритания');

INSERT INTO Издание_E3(id_publication,id_author,title,number_pages,year_publication,count)
VALUES ('14','4','Краткая история','456','1992','0'),
('7','3','История Руси','734','2010','0'),
('8','6','Математика','523','2019','0'),
('13','8','Астрономия','643','2018','0');

INSERT INTO Издание_E3(id_publication,id_author,title,number_pages,year_publication,annotation,count)
VALUES ('21','3','Будущее разума','456','1992','Анотация 1','0'),
('2','3','Философия','345','1893','Анотация 6','0'),
('23','2','Наука о вкусах','86','1982','Анотация 12','0'),
('4','5','Воля и самоконтроль','574','2001','Анотация 14','0'),
('5','7','Генетика','976','2022','Анотация 13','0'),
('6','4','Истоки морали','675','2001','Анотация 12','0'),
('11','5','Сто языков','756','1994','Анотация 11','0');

INSERT INTO Сотрудник_E10(id_employee,name,surname,middlename,passport,jobTitle )
VALUES ('12','Кирилл','Потапов','Пётрович','4477_186582','Ведущий специалист'),
('2','Антон','Ершов','Максимович','4974_186582','Специалист'),
('3','Венедикт','Пахомов','Антонинович','4725_274626','Ведущий специалист'),
('4','Арсений','Вавилов','Ярославович','4877_210804','Специалист'),
('5','Мечислав','Стечкин','Парфеньевич','4964_784341','Главный специалист');

INSERT INTO Сотрудник_E10(id_employee,name,surname,passport,jobTitle )
VALUES ('6','Ростислав','Лихачёв','4593_729089','Ведущий специалист'),
('7','Олег','Игнатьев','4995_314819','Главный специалист'),
('8','Леонтий','Быков','4542_770736','Ведущий специалист'),
('9','Витольд','Поляков','4840_645426','Главный специалист'),
('11','Оскар','Жуков','4523_723436','Главный специалист');
  
INSERT INTO Отдел_продаж_E9(id_sales_department,title,organization_number,address,telephone,name_contact,surname_contact,middlename_contact)
VALUES ('1','Эковер','63456345','483251, Вологодская область, город Люберцы, наб. Чехова, 29','2_299_860_33_68','Ефим','Сорокин','Степанович'),
('2','Библио','734534','830159, Кировская область, город Дмитров, бульвар Ленина, 56','Виктор','3_456_314_95_82','Зиновий','Чук и Гек'),
('3','Биокей','7345','933595, Архангельская область, город Озёры, спуск Будапештсткая, 63','3_465_304_36_08','Арнольд','Кулаков','Кимович'),
('4','Брейвери','347634','605112, Новосибирская область, город Дмитров, пл. Косиора, 95','3_688_513_83_22','Орест','Сорокин','Парфеньевич'),
('5','Варвар Сейлс','2341345','780949, Астраханская область, город Мытищи, шоссе Ломоносова, 14','5_339_480_61_94','Давид','Князев','Львович'),
('6','Элипс','7345','583158, Владимирская область, город Луховицы, проезд Космонавтов, 18','2_319_745_33_33','Давид','Фролов','Витальевич'),
('7','Книжное золото','956245','056470, Белгородская область, город Мытищи, пл. Космонавтов, 57','5_678_085_42_54','Роман','Наумов','Макарович'),
('8','Лайдия','2365464','238516, Курганская область, город Серебряные Пруды, ул. Гагарина, 06','3_444_875_78_32','Гурий','Брагин','Семёнович');

INSERT INTO Кафедра_E7(id_chair,title,specialization,name_head,surname_head,middlename_head,name_supervisor,surname_supervisor,middlename_supervisor)
VALUES ('14','Кафедра 1','Физика','Панкрат','Лаврентьев','Сергеевич','Исак','Исаев','Улебович'),
('21','Кафедра 3','История','Арсений','Соболев','Нинель','Кирилл','Терентьев','Олегович'),
('32','Кафедра 2','ИТ','Севастьян','Евдокимов','Вадимович','Георгий','Воробьёв','Митрофанович'),
('4','Кафедра 54','Химия','Осип','Алексеев','Кириллович','Ростислав','Беляков','Донатович'),
('5','Кафедра 28','Оптика','Касьян','Котов','Ростиславович','Устин','Суханов','Вадимович');

INSERT INTO Кафедра_E7(id_chair,title,specialization,name_head,surname_head,name_supervisor,surname_supervisor)
VALUES ('6','Кафедра 23','Робототехника','Родион','Исаев','Азарий','Гордеев'),
('7','Кафедра 14','Физика','Моисей','Блинов','Мирослав','Громов'),
('8','Кафедра 53','История','Кондратий','Ковалёв','Иван','Лыткин'),
('9','Кафедра 21','Физ Культура','Пестов','Модест','Лавр','Сорокин'),
('11','Кафедра 12','ИТ','Демьян','Титов','Пантелеймон','Степанов');

INSERT INTO Заявка_E8(id_task,id_employee,id_chair,date)
VALUES ('12','1','2','02.12.2021'),
('15','4','2','04.9.2021'),
('16','3','4','03.6.2021'),
('17','2','5','06.8.2021'),
('18','6','3','09.4.2021'),
('19','2','2','06.3.2021'),
('21','1','2','08.03.2021'),
('22','1','32','01.11.2021');

INSERT INTO Заказ_на_приобретение_литературы_E4 (id_purchase_order,id_employee,date_registration,date_transfer)
VALUES ('11','2','08.02.2021','08.03.2021'),
('2','3','06.7.2021','06.8.2021'),
('3','2','09.3.2021','09.4.2021'),
('4','4','02.11.2021','02.12.2021'),
('5','5','02.01.2022','04.01.2022');

INSERT INTO Заказ_на_приобретение_литературы_E4 (id_purchase_order,id_employee,date_registration)
VALUES ('6','5','04.9.2021'),
('8','6','08.03.2021'),
('9','2','08.03.2021'),
('18','2','08.03.2021');

INSERT INTO Акт_приема_E5(id_act_reception,id_employee,data_reception)
VALUES ('1','3','08.03.2022'),
('2','4','05.02.2022'),
('3','5','02.11.2021'),
('4','6','14.08.2021'),
('5','8','07.10.2021'),
('6','7','05.09.2021');

INSERT INTO Акт_списания_E6 (id_act_debiting,id_employee,data_debiting,reason)
VALUES ('1','3','07.11.2021','Обосновние списания 1'),
('3','5','08.11.2021','Обосновние списания 2'),
('6','2','09.11.2021','Обосновние списания 3');

INSERT INTO Планы_издательств_E11(id_plans_publishing,id_employee,id_publishing,date)
VALUES ('1','4','1','2018'),
('2','5','5','2022'),
('3','3','7','2020'),
('4','2','6','2021'),
('5','6','8','2022'),
('6','2','12','2022');

INSERT INTO Издаваемая_литература_E13(id_publication,id_plans_publishing,count_publication,date)
VALUES ('1','2','600','2021'),
('11','5','30','2022'),
('3','2','300','2020'),
('4','3','450','2022'),
('5','4','800','2022'),
('6','6','1000','2021');

INSERT INTO Заявки_в_заказе_E14 (id_publication,id_task,id_purchase_order,count_publication)
VALUES ('1','5','3','50'),
('3','4','1','65'),
('6','15','2','34'),
('5','6','1','45');

INSERT INTO Заказ_в_акте_приема_E15(id_publication,id_act_reception,id_purchase_order,count_publication)
VALUES ('1','1','1','53'),
('3','2','3','23'),
('5','3','1','64'),
('4','4','2','54');
INSERT INTO Списанная_литература_E12 (id_publication,id_act_debiting,count_publication)
VALUES ('2','1','10'),
('5','3','22'),
('6','6','54');

INSERT INTO Заказы_у_отдела_продаж_E17(id_sales_department,id_publication,id_task,id_purchase_order,count_publication)
VALUES ('2','1','5','3','50'),
('1','3','4','1','65'),
('2','6','15','2','34');
INSERT INTO Издательства_отдел_продаж_E16(id_sales_department,id_publishing,title_partner_publishing)
VALUES ('1','5','Поставщик 1'),
('2','4','Поставщик 2'),
('3','1','Поставщик 3'),
('4','2','Поставщик 4'),
('5','1','Поставщик 5');
