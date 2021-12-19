Create database LibConfDep
GO
use LibConfDep
GO

CREATE TABLE Издательство_E1
(
id_publishing integer NOT NULL PRIMARY KEY,
title varchar(50) UNIQUE NOT NULL,
city varchar(50) NOT NULL,
description text NULL
);
CREATE TABLE Автор_E2
(
id_author integer NOT NULL PRIMARY KEY,
surname varchar(50) NOT NULL,
name varchar(50) NOT NULL,
middlename varchar(50) NOT NULL,
biography text NULL,
UNIQUE (surname,name,middlename)
);
CREATE TABLE Издание_E3
(
id_publication integer NOT NULL PRIMARY KEY,
id_author integer NOT NULL,
title varchar(50) NOT NULL,
id_publishing integer NOT NULL,
number_pages integer NOT NULL CHECK (number_pages LIKE '[0-9][0-9][0-9][0-9]'),
year_publication date NOT NULL CHECK (year_publication LIKE '[0-9][0-9][0-9][0-9]'),
annotation text NULL, 
count integer NULL CHECK (count >=0)
);
CREATE TABLE Сотрудник_E10
(
id_employee integer NOT NULL PRIMARY KEY,
surname varchar(50) NOT NULL,
name varchar(50) NOT NULL,
middlename varchar(50) NOT NULL,
passport integer UNIQUE NOT NULL CHECK (passport LIKE '[0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9]'),
jobTitle varchar(20) NOT NULL
);
CREATE TABLE Заказ_на_приобретение_литературы_E4
(
id_purchase_order integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES Сотрудник_E10(id_employee) ON DELETE NO ACTION,
date_registration date NOT NULL,
date_transfer date NOT NULL

);
CREATE TABLE Отдел_продаж_E9
(
id_sales_departament integer NOT NULL PRIMARY KEY,
title varchar(50) NOT NULL,
organization_number integer UNIQUE NOT NULL,
address text NOT NULL,
telephone integer NOT NULL CHECK (telephone LIKE '[0-9]_[0-9][0-9][0-9]_[0-9][0-9]_[0-9][0-9]'),
surname_contact varchar(50) NOT NULL,
name_contact varchar(50) NOT NULL,
middlename_contact varchar(50) NOT NULL
);
CREATE TABLE Акт_приема_E5
(
id_act_reception integer NOT NULL PRIMARY KEY,
id_sales_departament integer NOT NULL FOREIGN KEY REFERENCES Отдел_продаж_E9(id_sales_departament) ON DELETE NO ACTION,
id_employee integer NOT NULL,
date date NOT NULL
);
CREATE TABLE Акт_списания_E6
(
id_act_debiting integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES Сотрудник_E10(id_employee) ON DELETE NO ACTION,
date date NOT NULL,
reason text NOT NULL
);
CREATE TABLE Кафедра_E7
(
id_chair integer NOT NULL PRIMARY KEY,
title varchar(50) UNIQUE NOT NULL,
specialization varchar(50) NOT NULL,
surname_head varchar(50) NOT NULL,
name_head varchar(50) NOT NULL,
middlename_head varchar(50) NOT NULL,
surname_supervisor varchar(50) NOT NULL,
name_supervisor varchar(50) NOT NULL,
middlename_supervisor varchar(50) NOT NULL
);
CREATE TABLE Заявка_E8
(
id_task integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL,
id_chair integer NOT NULL,
date date NOT NULL
);
CREATE TABLE Планы_издательств_E11
(
id_plans_publishing integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES Сотрудник_E10(id_employee) ON DELETE NO ACTION,
id_publishing integer NOT NULL FOREIGN KEY REFERENCES Издательство_E1(id_publishing) ON DELETE NO ACTION,
date date NOT NULL
);
CREATE TABLE Издаваемая_литература_E12
(
id_plans_publishing integer NOT NULL,
id_publication integer NOT NULL,
count integer NULL CHECK (count >=0),
PRIMARY KEY(id_plans_publishing)
);
CREATE TABLE Издаваемая_литература_E13
(
id_task integer NOT NULL FOREIGN KEY REFERENCES Заявка_E8(id_task) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_task ,id_publication)
);
CREATE TABLE Переиздание_E14
(
id_author integer NOT NULL FOREIGN KEY REFERENCES Автор_E2(id_author) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION,
specialization varchar(50) NOT NULL,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_author,id_publication)
);
CREATE TABLE Списанная_литература_E15
(
id_act_debiting integer NOT NULL FOREIGN KEY REFERENCES Акт_списания_E6(id_act_debiting) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_act_debiting,id_publication)
);
CREATE TABLE Заказанная_лиетратура_E16
(
id_purchase_order integer NOT NULL FOREIGN KEY REFERENCES Заказ_на_приобретение_литературы_E4(id_purchase_order) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_purchase_order,id_publication)
);
CREATE TABLE Полученная_литература_E17
(
id_act_reception integer NOT NULL FOREIGN KEY REFERENCES Акт_приема_E5(id_act_reception) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_act_reception,id_publication)
);
CREATE TABLE Обработанные_заявки_E18
(
id_purchase_order integer NOT NULL FOREIGN KEY REFERENCES Заказ_на_приобретение_литературы_E4(id_purchase_order) ON DELETE NO ACTION,
id_task integer NOT NULL FOREIGN KEY REFERENCES Заявка_E8(id_task) ON DELETE NO ACTION,
date date NOT NULL,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_purchase_order,id_task)
);
CREATE TABLE Обработанные_заказы_E19
(
id_sales_departament integer NOT NULL FOREIGN KEY REFERENCES Отдел_продаж_E9(id_sales_departament) ON DELETE NO ACTION,
id_purchase_order integer NOT NULL FOREIGN KEY REFERENCES Заказ_на_приобретение_литературы_E4(id_purchase_order) ON DELETE NO ACTION,
date date NOT NULL,
count integer NULL CHECK (count >=0)
PRIMARY KEY (id_sales_departament,id_purchase_order)
);
CREATE TABLE Заказы_в_акте_приема_E20
(
id_act_reception integer NOT NULL FOREIGN KEY REFERENCES Акт_приема_E5(id_act_reception) ON DELETE NO ACTION,
id_purchase_order integer NOT NULL FOREIGN KEY REFERENCES Заказ_на_приобретение_литературы_E4(id_purchase_order) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_act_reception,id_purchase_order)
);
CREATE TABLE Книжный_магазин_E21
(
id_sales_departament integer NOT NULL FOREIGN KEY REFERENCES Отдел_продаж_E9(id_sales_departament) ON DELETE NO ACTION,
id_publishing integer NOT NULL FOREIGN KEY REFERENCES Издательство_E1(id_publishing) ON DELETE NO ACTION,
specialization varchar(50) NOT NULL,
PRIMARY KEY (id_sales_departament,id_publishing)
);