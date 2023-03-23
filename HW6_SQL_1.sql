-- Зайдите в базу данных “MyJoinsDB”, под созданным в предыдущем уроке пользователем. 
-- Проанализируйте, какие типы индексов заданы на созданных в предыдущем домашнем задании таблицах. 
-- Задайте свои индексы на таблицах, созданных в предыдущем домашнем задании и обоснуйте их необходимость. 

CREATE INDEX ind_empl_name ON Employees (NameEmployee); -- прискорює запити повʼязані з основними категоріями пошуку інформації, в даному випадку це по імені працівника.
CREATE INDEX ind_pers_status ON Personal (MaritalStatus); -- прискорює запити повʼязані з такою категорією запиту, як сімейний стан працівника.
CREATE INDEX ind_pers_birth ON Personal (BirthDay); -- прискорює запити повʼязані з такою категорією запиту, як дата народження працівника.
CREATE INDEX ind_pos_pos ON Positions (PositionEmployee); -- прискорює запити повʼязані з такою категорією запиту, як посада.
CREATE INDEX ind_pos_sal ON Positions (SalaryEmployee); -- прискорює запити повʼязані з такою категорією запиту, як зарплата.

-- Создайте представления для таких заданий: 
-- 1. Необходимо узнать контактные данные сотрудников (номера телефонов, место жительства). 
-- 2. Необходимо узнать информацию о дате рождения всех не женатых сотрудников и номера телефонов этих сотрудников. 
-- 3. Необходимо узнать информацию о дате рождения всех сотрудников с должностью менеджер и номера телефонов этих 
-- сотрудников. 

CREATE VIEW Emp1 AS SELECT NameEmployee, PhoneEmployee, Adress
FROM Employees
JOIN Personal ON Employees.EmployeesID = Personal.EmployeesID; 

CREATE VIEW Emp2 AS SELECT NameEmployee, MaritalStatus, PhoneEmployee, BirthDay
FROM Employees
JOIN Personal ON Employees.EmployeesID = Personal.EmployeesID
WHERE Personal.MaritalStatus = 'unmarried';

DROP VIEW Emp2;

CREATE VIEW Emp3 AS SELECT NameEmployee, PositionEmployee, PhoneEmployee, BirthDay
FROM Employees
JOIN Personal ON Employees.EmployeesID = Personal.EmployeesID
JOIN Positions ON Employees.EmployeesID = Positions.EmployeesID
WHERE Positions.PositionEmployee = 'manager';

-- Используя базу данных ShopDB и страницу Customers 
-- (удалите таблицу, если есть и создайте заново первый раз без первичного ключа затем – с первичным) 
-- и затем добавьте индексы и проанализируйте выборку данных.

DROP TABLE Customers;

CREATE TABLE Customers (
  CustomerNo 	int 		NOT NULL,
  LName 		varchar(15) NOT NULL,
  FName 		varchar(15) NOT NULL,
  MName 		varchar(15) DEFAULT NULL,
  Address1 		varchar(50) NOT NULL,
  Address2 		varchar(50) DEFAULT NULL,
  City 			char(10) 	NOT NULL,
  Phone 		char(12) 	NOT NULL,
  DateInSystem 	date 		DEFAULT NULL,
  OrderID 		int 		DEFAULT NULL
  )
  ;
  -- 0,042 sec
 
 CREATE TABLE Customers (
  CustomerNo 	int 		NOT NULL AUTO_INCREMENT,
  LName 		varchar(15) NOT NULL,
  FName 		varchar(15) NOT NULL,
  MName 		varchar(15) DEFAULT NULL,
  Address1 		varchar(50) NOT NULL,
  Address2 		varchar(50) DEFAULT NULL,
  City 			char(10) 	NOT NULL,
  Phone 		char(12) 	NOT NULL,
  DateInSystem 	date 		NOT NULL,
  OrderID 		int 		DEFAULT NULL,
  PRIMARY KEY (CustomerNo)
  )
  ;
  -- 0,014 sec
  
  INSERT Customers (LName, FName, MName, Address1, Address2, City, Phone, DateInSystem, OrderID)
  VALUES 
  ('Katanova', 'Lesia', 'Olexandrivna', 'KYIV', NULL,'KYIV', '0664380410', '2023-03-22',NULL),
  ('Kalishenko', 'Mykola', 'Olexandrovych', 'KYIV', NULL,'KYIV', '0664380420', '2023-03-22', NULL),
  ('Scalozub', 'Stas', 'Mykolayovych', 'KYIV', NULL,'KYIV', '0664380411', '2023-03-22', NULL),
  ('Dzhambova', 'Olga', 'Viktorivna', 'KYIV', NULL,'KYIV', '0664380415', '2023-03-22', NULL),
  ('Borodina', 'Margo', 'Sergiivna', 'KYIV', NULL,'KYIV', '0664380416', '2023-03-22', NULL);
 
 -- 0,012 sec
 
SELECT * FROM Customers;
 
 -- 0.0071 sec

CREATE INDEX ind_cust_name_adress_data_index ON Customers (LName, FName, MName, Address1, Address2, City, Phone, DateInSystem);

SELECT * FROM Customers;

-- 0,00052 sec














