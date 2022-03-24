--UC-1
create database payroll_service
--show database 
use payroll_service
select DB_NAME()

--UC-2
create table employee_payroll
(
id int not null,
name varchar(25) not null,
salary money not null,
start_date date not null
);

--UC-3
insert into employee_payroll values
(101,'Billi',100000.00,'2018-01-03'),
(102,'Terisa',200000.00,'2019-11-13'),
(103,'Charlie',300000.00,'2020-05-21')

