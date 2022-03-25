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

--UC8 
--Ability to extend employee_payroll data to store employee information like employee phone, address and department

alter table employee_payroll add phonenumber varchar(50),address varchar(200) not null default 'Karnataka',department varchar(50);

update employee_payroll set phonenumber='7056923643', department='Marketing' where name='Rachel';
update employee_payroll set phonenumber='7756985643', department='Sales' where name='Terissa';
update employee_payroll set phonenumber='8956985643', department='HR' where name='Bill';
update employee_payroll set phonenumber='8156985643', department='Marketing' where name='Charlie';
update employee_payroll set phonenumber='8556985643', department='Sales' where name='John';

select * from employee_payroll;

--UC9 
--Ability to extend employee_payroll table to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay

alter table employee_payroll add BasicPay decimal, Deductions decimal, TaxablePay decimal, IncomeTax decimal, NetPay decimal;
 
 update employee_payroll set BasicPay=salary;

 alter table employee_payroll drop column salary;

 update employee_payroll set Deductions=2000 where name='John' or name='Charlie';
 update employee_payroll set Deductions=1500 where name='Rachel' or name='Terissa' or name='Bill';
 
 update employee_payroll set IncomeTax=250;
 update employee_payroll set TaxablePay=500;

 update employee_payroll set NetPay = (BasicPay-Deductions);

select * from employee_payroll;

--UC10 
--Ability to make Terissa as part of Sales and Marketing Department

insert into employee_payroll(id,name,start_date,gender,phonenumber,department,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay)
values('1','Terissa','2021-08-02','F','8687653523','Marketing',50000,2000,500,250,47250);

select * from employee_payroll where name='Terissa';


