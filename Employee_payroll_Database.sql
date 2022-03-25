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
(103,'Charlie',300000.00,'2020-05-21');

--UC-4
select * from employee_payroll;

--UC-5
select salary from employee_payroll where name='Billi';
select * from employee_payroll where start_date between CAST('2018-01-01' as date) AND CAST('2020-01-01' as date);

--UC-6
alter table employee_payroll add gender char(1);
update employee_payroll  set gender ='M' where name = 'Billi' or name = 'Charlie';
update employee_payroll  set gender ='F' where name = 'Terisa';

--UC-7
select SUM(salary) from employee_payroll group by gender;
select AVG(salary) from employee_payroll group by gender;
select MIN(salary) from employee_payroll group by gender;
select MAX(salary) from employee_payroll group by gender;
select COUNT(salary) from employee_payroll group by gender;

--UC8 Start
--Ability to extend employee_payroll data to store employee information like employee phone, address and department

alter table employee_payroll add phonenumber varchar(50),address varchar(200) not null default 'Maharashtra',department varchar(50);

update employee_payroll set phonenumber='8556985643', department='Sales' where name='John';
update employee_payroll set phonenumber='7056923643', department='Marketing' where name='Rachel';
update employee_payroll set phonenumber='7756985643', department='Sales' where name='Terissa';
update employee_payroll set phonenumber='8956985643', department='HR' where name='Bill';
update employee_payroll set phonenumber='8156985643', department='Marketing' where name='Charlie';

select * from employee_payroll;

