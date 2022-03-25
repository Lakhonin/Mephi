Create database LibConfDep
GO
use LibConfDep
GO

CREATE TABLE Издательство_E1
(
id_publishing integer NOT NULL PRIMARY KEY,
title varchar(20) UNIQUE NOT NULL,
city varchar(20) NOT NULL,
description text NULL
);
CREATE TABLE Автор_E2
(
id_author integer NOT NULL PRIMARY KEY,
name varchar(20) NOT NULL,
surname varchar(20) NOT NULL,
middlename varchar(20) NULL,
biography text NULL,
UNIQUE (surname,name,middlename)
);
CREATE TABLE Издание_E3
(
id_publication integer NOT NULL PRIMARY KEY,
id_author integer NOT NULL FOREIGN KEY REFERENCES Автор_E2(id_author) ON DELETE NO ACTION,
title varchar(20) NOT NULL,
number_pages integer NOT NULL CHECK (number_pages >0),
year_publication date NOT NULL CHECK (year_publication LIKE '[0-9][0-9][0-9][0-9]'),
annotation text NULL, 
count_publication integer NULL CHECK (count_publication >=0)
);
CREATE TABLE Сотрудник_E10
(
id_employee integer NOT NULL PRIMARY KEY,
name varchar(20) NOT NULL,
surname varchar(20) NOT NULL,
middlename varchar(20)  NULL,
passport varchar(20) UNIQUE NOT NULL CHECK (passport LIKE '[0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]'),
jobTitle varchar(20) NOT NULL
);
CREATE TABLE Отдел_продаж_E9
(
id_sales_department integer NOT NULL PRIMARY KEY,
title varchar(20) NOT NULL,
organization_number integer UNIQUE NOT NULL,
address text NOT NULL,
telephone varchar(20) NOT NULL CHECK (telephone LIKE '[0-9]_[0-9][0-9][0-9]_[0-9][0-9][0-9]_[0-9][0-9]_[0-9][0-9]'),
name_contact varchar(20) NOT NULL,
surname_contact varchar(20) NOT NULL,
middlename_contact varchar(20) NOT NULL
);
CREATE TABLE Кафедра_E7
(
id_chair integer NOT NULL PRIMARY KEY,
title varchar(20) UNIQUE NOT NULL,
specialization varchar(20) NOT NULL,
name_head varchar(20) NOT NULL,
surname_head varchar(20) NOT NULL,
middlename_head varchar(20)  NULL,
name_supervisor varchar(20) NOT NULL,
surname_supervisor varchar(20) NOT NULL,
middlename_supervisor varchar(20)  NULL
);
CREATE TABLE Заявка_E8
(
id_task integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES Сотрудник_E10(id_employee) ON DELETE NO ACTION,
id_chair integer NOT NULL FOREIGN KEY REFERENCES Кафедра_E7(id_chair) ON DELETE NO ACTION,
date_task date NOT NULL
);
CREATE TABLE Заказ_на_приобретение_литературы_E4
(
id_purchase_order integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES Сотрудник_E10(id_employee) ON DELETE NO ACTION,
date_registration date NOT NULL,
date_transfer date  NULL, 
CHECK (date_transfer > date_registration)
);

CREATE TABLE Акт_приема_E5
(
id_act_reception integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES Сотрудник_E10(id_employee) ON DELETE NO ACTION,
date_reception date NOT NULL
);
CREATE TABLE Акт_списания_E6
(
id_act_debiting integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES Сотрудник_E10(id_employee) ON DELETE NO ACTION,
date_debiting date NOT NULL,
reason text NOT NULL
);
CREATE TABLE Планы_издательств_E11
(
id_plans_publishing integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES Сотрудник_E10(id_employee) ON DELETE NO ACTION,
id_publishing integer NOT NULL FOREIGN KEY REFERENCES Издательство_E1(id_publishing) ON DELETE NO ACTION
);
CREATE TABLE Издаваемая_литература_E13
(
id_publication integer NOT NULL,
id_plans_publishing integer NOT NULL, 
count_publication integer NULL CHECK (count_publication >0),
date_plans date NOT NULL,
PRIMARY KEY(id_publication,id_plans_publishing),
FOREIGN KEY (id_publication) REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION,
FOREIGN KEY (id_plans_publishing) REFERENCES Планы_издательств_E11(id_plans_publishing) ON DELETE NO ACTION
);
CREATE TABLE Заявки_в_заказе_E14
(
id_publication integer NOT NULL,
id_task integer NOT NULL, 
id_purchase_order integer NOT NULL,  
count_publication integer NOT NULL CHECK (count_publication >0),
PRIMARY KEY(id_publication,id_task,id_purchase_order),
FOREIGN KEY (id_task) REFERENCES Заявка_E8(id_task) ON DELETE NO ACTION,
FOREIGN KEY (id_purchase_order) REFERENCES Заказ_на_приобретение_литературы_E4(id_purchase_order) ON DELETE NO ACTION,
FOREIGN KEY (id_publication) REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION
);
CREATE TABLE Заказ_в_акте_приема_E15
(
id_publication integer NOT NULL,
id_act_reception integer NOT NULL,
id_purchase_order integer NOT NULL,
count_publication integer NOT NULL CHECK (count_publication >0),
PRIMARY KEY(id_publication, id_act_reception,id_purchase_order),
FOREIGN KEY (id_publication) REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION,
FOREIGN KEY (id_act_reception) REFERENCES Акт_приема_E5(id_act_reception) ON DELETE NO ACTION,
FOREIGN KEY (id_purchase_order) REFERENCES Заказ_на_приобретение_литературы_E4(id_purchase_order) ON DELETE NO ACTION
);
CREATE TABLE Списанная_литература_E12
(
id_publication integer NOT NULL,
id_act_debiting integer NOT NULL,
count_publication integer NOT NULL CHECK (count_publication >0),
PRIMARY KEY(id_publication, id_act_debiting),
FOREIGN KEY (id_publication) REFERENCES Издание_E3(id_publication) ON DELETE NO ACTION,
FOREIGN KEY (id_act_debiting) REFERENCES Акт_списания_E6(id_act_debiting) ON DELETE NO ACTION
);
CREATE TABLE Заказы_у_отдела_продаж_E17
(
id_sales_department integer NOT NULL,
id_publication integer NOT NULL,
id_task integer NOT NULL, 
id_purchase_order integer NOT NULL,  
count_publication integer NOT NULL CHECK (count_publication >0),
FOREIGN KEY (id_publication,id_task,id_purchase_order) REFERENCES Заявки_в_заказе_E14(id_publication,id_task,id_purchase_order) ON DELETE NO ACTION,
FOREIGN KEY (id_sales_department) REFERENCES Отдел_продаж_E9(id_sales_department) ON DELETE NO ACTION,
PRIMARY KEY(id_publication,id_task,id_purchase_order,id_sales_department)
);
CREATE TABLE Издательства_отдел_продаж_E16
(
id_sales_department integer NOT NULL,
id_publishing integer NOT NULL, 
title_partner_publishing varchar(20) NOT NULL,
PRIMARY KEY(id_sales_department,id_publishing),
FOREIGN KEY (id_sales_department) REFERENCES Отдел_продаж_E9(id_sales_department) ON DELETE NO ACTION,
FOREIGN KEY (id_publishing) REFERENCES Издательство_E1(id_publishing) ON DELETE NO ACTION
);
