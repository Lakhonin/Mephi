Create database LibConfDep
GO
use LibConfDep
GO

CREATE TABLE ������������_E1
(
id_publishing integer NOT NULL PRIMARY KEY,
title varchar(50) UNIQUE NOT NULL,
city varchar(50) NOT NULL,
description text NULL
);
CREATE TABLE �����_E2
(
id_author integer NOT NULL PRIMARY KEY,
surname varchar(50) NOT NULL,
name varchar(50) NOT NULL,
middlename varchar(50) NOT NULL,
biography text NULL,
UNIQUE (surname,name,middlename)
);
CREATE TABLE �������_E3
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
CREATE TABLE ���������_E10
(
id_employee integer NOT NULL PRIMARY KEY,
surname varchar(50) NOT NULL,
name varchar(50) NOT NULL,
middlename varchar(50) NOT NULL,
passport integer UNIQUE NOT NULL CHECK (passport LIKE '[0-9][0-9][0-9][0-9]_[0-9][0-9][0-9][0-9]'),
jobTitle varchar(20) NOT NULL
);
CREATE TABLE �����_��_������������_����������_E4
(
id_purchase_order integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES ���������_E10(id_employee) ON DELETE NO ACTION,
date_registration date NOT NULL,
date_transfer date NOT NULL

);
CREATE TABLE �����_������_E9
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
CREATE TABLE ���_������_E5
(
id_act_reception integer NOT NULL PRIMARY KEY,
id_sales_departament integer NOT NULL FOREIGN KEY REFERENCES �����_������_E9(id_sales_departament) ON DELETE NO ACTION,
id_employee integer NOT NULL,
date date NOT NULL
);
CREATE TABLE ���_��������_E6
(
id_act_debiting integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES ���������_E10(id_employee) ON DELETE NO ACTION,
date date NOT NULL,
reason text NOT NULL
);
CREATE TABLE �������_E7
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
CREATE TABLE ������_E8
(
id_task integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL,
id_chair integer NOT NULL,
date date NOT NULL
);
CREATE TABLE �����_�����������_E11
(
id_plans_publishing integer NOT NULL PRIMARY KEY,
id_employee integer NOT NULL FOREIGN KEY REFERENCES ���������_E10(id_employee) ON DELETE NO ACTION,
id_publishing integer NOT NULL FOREIGN KEY REFERENCES ������������_E1(id_publishing) ON DELETE NO ACTION,
date date NOT NULL
);
CREATE TABLE ����������_����������_E12
(
id_plans_publishing integer NOT NULL,
id_publication integer NOT NULL,
count integer NULL CHECK (count >=0),
PRIMARY KEY(id_plans_publishing)
);
CREATE TABLE ����������_����������_E13
(
id_task integer NOT NULL FOREIGN KEY REFERENCES ������_E8(id_task) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES �������_E3(id_publication) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_task ,id_publication)
);
CREATE TABLE �����������_E14
(
id_author integer NOT NULL FOREIGN KEY REFERENCES �����_E2(id_author) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES �������_E3(id_publication) ON DELETE NO ACTION,
specialization varchar(50) NOT NULL,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_author,id_publication)
);
CREATE TABLE ���������_����������_E15
(
id_act_debiting integer NOT NULL FOREIGN KEY REFERENCES ���_��������_E6(id_act_debiting) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES �������_E3(id_publication) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_act_debiting,id_publication)
);
CREATE TABLE ����������_����������_E16
(
id_purchase_order integer NOT NULL FOREIGN KEY REFERENCES �����_��_������������_����������_E4(id_purchase_order) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES �������_E3(id_publication) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_purchase_order,id_publication)
);
CREATE TABLE ����������_����������_E17
(
id_act_reception integer NOT NULL FOREIGN KEY REFERENCES ���_������_E5(id_act_reception) ON DELETE NO ACTION,
id_publication integer NOT NULL FOREIGN KEY REFERENCES �������_E3(id_publication) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_act_reception,id_publication)
);
CREATE TABLE ������������_������_E18
(
id_purchase_order integer NOT NULL FOREIGN KEY REFERENCES �����_��_������������_����������_E4(id_purchase_order) ON DELETE NO ACTION,
id_task integer NOT NULL FOREIGN KEY REFERENCES ������_E8(id_task) ON DELETE NO ACTION,
date date NOT NULL,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_purchase_order,id_task)
);
CREATE TABLE ������������_������_E19
(
id_sales_departament integer NOT NULL FOREIGN KEY REFERENCES �����_������_E9(id_sales_departament) ON DELETE NO ACTION,
id_purchase_order integer NOT NULL FOREIGN KEY REFERENCES �����_��_������������_����������_E4(id_purchase_order) ON DELETE NO ACTION,
date date NOT NULL,
count integer NULL CHECK (count >=0)
PRIMARY KEY (id_sales_departament,id_purchase_order)
);
CREATE TABLE ������_�_����_������_E20
(
id_act_reception integer NOT NULL FOREIGN KEY REFERENCES ���_������_E5(id_act_reception) ON DELETE NO ACTION,
id_purchase_order integer NOT NULL FOREIGN KEY REFERENCES �����_��_������������_����������_E4(id_purchase_order) ON DELETE NO ACTION,
count integer NULL CHECK (count >=0),
PRIMARY KEY (id_act_reception,id_purchase_order)
);
CREATE TABLE �������_�������_E21
(
id_sales_departament integer NOT NULL FOREIGN KEY REFERENCES �����_������_E9(id_sales_departament) ON DELETE NO ACTION,
id_publishing integer NOT NULL FOREIGN KEY REFERENCES ������������_E1(id_publishing) ON DELETE NO ACTION,
specialization varchar(50) NOT NULL,
PRIMARY KEY (id_sales_departament,id_publishing)
);