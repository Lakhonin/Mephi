Create database LibConfDep
GO
use LibConfDep
GO

CREATE TABLE ������������_E1
(
id_publishing integer NOT NULL PRIMARY KEY,
title varchar(20) UNIQUE NOT NULL,
city varchar(20) NOT NULL,
description text NULL
);
CREATE TABLE �����_E2
(
id_author integer NOT NULL PRIMARY KEY,
name varchar(20) NOT NULL,
surname varchar(20) NOT NULL,
middlename varchar(20) NULL,
biography text NULL,
UNIQUE (surname,name,middlename)
);
CREATE TABLE �������_E3
(
id_publication integer NOT NULL PRIMARY KEY,
id_author integer NOT NULL FOREIGN KEY REFERENCES �����_E2(id_author) ON DELETE NO ACTION,
title varchar(20) NOT NULL,
number_pages integer NOT NULL CHECK (number_pages >0),
year_publication date NOT NULL CHECK (year_publication LIKE '[0-9][0-9][0-9][0-9]'),
annotation text NULL, 
count integer NULL CHECK (count >=0)
);
CREATE TABLE ���������_E10
(
id_employee integer NOT NULL PRIMARY KEY,
name varchar(20) NOT NULL,
surname varchar(20) NOT NULL,
middlename varchar(20)  NULL,
passport varchar(20) UNIQUE NOT NULL CHECK (passport LIKE '[0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9][0-9][0-9]'),
jobTitle varchar(20) NOT NULL
);
CREATE TABLE �����_������_E9
(
id_sales_department integer NOT NULL PRIMARY KEY,
title varchar(20) NOT NULL,
organization_number integer UNIQUE NOT NULL,
address text NOT NULL,
telephone integer NOT NULL CHECK (telephone LIKE '[0-9]_[0-9][0-9][0-9]_[0-9][0-9][0-9]_[0-9][0-9]_[0-9][0-9]'),
name_contact varchar(20) NOT NULL,
surname_contact varchar(20) NOT NULL,
middlename_contact varchar(20) NOT NULL
);
CREATE TABLE �������_E7
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
CREATE TABLE ������_E8
(
id_task integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES ���������_E10(id_employee) ON DELETE NO ACTION,
id_chair integer NOT NULL FOREIGN KEY REFERENCES �������_E7(id_chair) ON DELETE NO ACTION,
date date NOT NULL
);
CREATE TABLE �����_��_������������_����������_E4
(
id_purchase_order integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES ���������_E10(id_employee) ON DELETE NO ACTION,
date_registration date NOT NULL,
date_transfer date  NULL, 
CHECK (date_transfer > date_registration)
);

CREATE TABLE ���_������_E5
(
id_act_reception integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES ���������_E10(id_employee) ON DELETE NO ACTION,
date date NOT NULL
);
CREATE TABLE ���_��������_E6
(
id_act_debiting integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES ���������_E10(id_employee) ON DELETE NO ACTION,
date date NOT NULL,
reason text NOT NULL
);
CREATE TABLE �����_�����������_E11
(
id_plans_publishing integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES ���������_E10(id_employee) ON DELETE NO ACTION,
id_publishing integer NOT NULL FOREIGN KEY REFERENCES ������������_E1(id_publishing) ON DELETE NO ACTION,
date date NOT NULL
);
CREATE TABLE ����������_����������_E13
(
id_publication integer NOT NULL,
id_plans_publishing integer NOT NULL, 
count_publication integer NULL CHECK (count_publication >0),
PRIMARY KEY(id_publication,id_plans_publishing),
FOREIGN KEY (id_publication) REFERENCES �������_E3(id_publication) ON DELETE NO ACTION,
FOREIGN KEY (id_plans_publishing) REFERENCES �����_�����������_E11(id_plans_publishing) ON DELETE NO ACTION
);
CREATE TABLE ������_�_������_E14
(
id_publication integer NOT NULL,
id_task integer NOT NULL, 
id_purchase_order integer NOT NULL,  
count_publication integer NOT NULL CHECK (count_publication >0),
PRIMARY KEY(id_publication,id_task,id_purchase_order),
FOREIGN KEY (id_task) REFERENCES ������_E8(id_task) ON DELETE NO ACTION,
FOREIGN KEY (id_purchase_order) REFERENCES �����_��_������������_����������_E4(id_purchase_order) ON DELETE NO ACTION,
FOREIGN KEY (id_publication) REFERENCES �������_E3(id_publication) ON DELETE NO ACTION
);
CREATE TABLE �����_�_����_������_E15
(
id_publication integer NOT NULL,
id_act_reception integer NOT NULL,
id_purchase_order integer NOT NULL,
count_publication integer NOT NULL CHECK (count_publication >0),
PRIMARY KEY(id_publication, id_act_reception,id_purchase_order),
FOREIGN KEY (id_publication) REFERENCES �������_E3(id_publication) ON DELETE NO ACTION,
FOREIGN KEY (id_act_reception) REFERENCES ���_������_E5(id_act_reception) ON DELETE NO ACTION,
FOREIGN KEY (id_purchase_order) REFERENCES �����_��_������������_����������_E4(id_purchase_order) ON DELETE NO ACTION
);
CREATE TABLE ���������_����������_E12
(
id_publication integer NOT NULL,
id_act_debiting integer NOT NULL,
count_publication integer NOT NULL CHECK (count_publication >0),
PRIMARY KEY(id_publication, id_act_debiting),
FOREIGN KEY (id_publication) REFERENCES �������_E3(id_publication) ON DELETE NO ACTION,
FOREIGN KEY (id_act_debiting) REFERENCES ���_��������_E6(id_act_debiting) ON DELETE NO ACTION
);
CREATE TABLE ������_�_������_������_E17
(
id_sales_department integer NOT NULL,
id_publication integer NOT NULL,
id_task integer NOT NULL, 
id_purchase_order integer NOT NULL,  
count_publication integer NOT NULL CHECK (count_publication >0),
FOREIGN KEY (id_publication,id_task,id_purchase_order) REFERENCES ������_�_������_E14(id_publication,id_task,id_purchase_order) ON DELETE NO ACTION,
FOREIGN KEY (id_sales_department) REFERENCES �����_������_E9(id_sales_department) ON DELETE NO ACTION,
PRIMARY KEY(id_publication,id_task,id_purchase_order,id_sales_department)
);
CREATE TABLE ������������_�����_������_E16
(
id_sales_department integer NOT NULL,
id_publishing integer NOT NULL, 
title_partner_publishing varchar(20) NOT NULL,
PRIMARY KEY(id_sales_department,id_publishing),
FOREIGN KEY (id_sales_department) REFERENCES �����_������_E9(id_sales_department) ON DELETE NO ACTION,
FOREIGN KEY (id_publishing) REFERENCES ������������_E1(id_publishing) ON DELETE NO ACTION
);
