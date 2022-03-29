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



--Normalization

create table employee_payroll_table
(
id int primary key identity(1,1),
name varchar(100),
startdate Date,
gender varchar(10),
phonenumber varchar(20),
address varchar(200)
);

select * from employee_payroll_table;

insert into employee_payroll_table(name,startdate,gender,phonenumber,address)
values('John','2022-01-01','M','6876543456','MP'),
('Rachel','2022-03-03','F','7890876556','Mumbai'),
('Terissa','2022-02-01','F','8890987667','Karnataka'),
('Bill','2021-05-01','M','7878654567','Pune'),
('Charlie','2021-07-01','M','9987654545','Delhi');

insert into employee_payroll_table(name,startdate,gender,phonenumber,address)
values('Terissa','2021-05-01','F','8890987667','Karnataka');



create table departmentdeatils(
DeptId int primary key identity(1,1),
DepartmentName Varchar(100),
id int FOREIGN KEY REFERENCES employee_payroll_table(id)
);

select * from departmentdeatils;

insert into departmentdeatils(DepartmentName,id)
values('Marketing',1);

insert into departmentdeatils(DepartmentName,id)
values('HR',2);

insert into departmentdeatils(DepartmentName,id)
values('Sales',3);

insert into departmentdeatils(DepartmentName,id)
values('Quality Analysis',4);

insert into departmentdeatils(DepartmentName,id)
values('HR',5);

insert into departmentdeatils(DepartmentName,id)
values('Marketing',6);

select name,startdate,gender,phonenumber,address,DepartmentName from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id;




create table SalaryDetails(
SalaryId int primary key identity(1,1),
BasicPay decimal,
Deductions decimal,
TaxablePay decimal,
IncomeTax decimal,
NetPay decimal,
id int FOREIGN KEY REFERENCES employee_payroll_table(id)
);

insert into SalaryDetails(BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,id)
values(50000,2000,200,500,48000,1);

insert into SalaryDetails(BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,id)
values(50000,500,200,500,49500,2);

insert into SalaryDetails(BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,id)
values(80000,3000,200,500,77000,3);

insert into SalaryDetails(BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,id)
values(50000,1000,200,500,49000,4);

insert into SalaryDetails(BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,id)
values(60000,500,200,500,59500,5);

insert into SalaryDetails(BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,id)
values(55000,1000,200,500,54000,6);


select employee_payroll_table.id,name,phonenumber,address,DepartmentName,gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,startdate from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id;

select * from SalaryDetails;




--UC11
--Implement the ER Diagram into Payroll Service DB

select sum(BasicPay) as Sum, gender from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id group by gender;

select avg(BasicPay) as AveragePay, gender from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id group by gender;

select max(BasicPay) as MaxPay, gender from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id group by gender;

select min(BasicPay) as MinPay, gender from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id group by gender;

select count(BasicPay) as Count, gender from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id group by gender;



--UC12 
--Ensure all retrieve queries done especially in UC 4, UC 5 and UC 7 are working with new table structure

--UC4
select employee_payroll_table.id,name,phonenumber,address,DepartmentName,gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,startdate from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id;

--UC5
select BasicPay,name from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id where name='Bill';

select employee_payroll_table.id,name,phonenumber,address,DepartmentName,gender,BasicPay,Deductions,TaxablePay,IncomeTax,NetPay,startdate from employee_payroll_table inner join departmentdeatils on employee_payroll_table.id=departmentdeatils.id inner join SalaryDetails on employee_payroll_table.id=SalaryDetails.id where startdate between cast('2022-02-01' as date) AND cast(SYSDATETIME() as date);

