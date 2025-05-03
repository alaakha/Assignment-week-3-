create table Employees (
    Emp_id int primary key,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	salary DECIMAL(8,2),
	department_id INT,
    FOREIGN KEY (department_id) REFERENCES [Sales].[Departments](department_id)
);
drop table [Sales].[Employees]
alter table Employees 
add hire_date DATE
alter schema Sales
transfer dbo.Employees
--use sequence for Emp_id
CREATE SEQUENCE CountById
    AS INT
START WITH 1
INCREMENT BY 1;
	
--Select all columns from the "employees" table.
	select * 
	from Sales.Employees

--Retrieve only the "first_name" and "last_name" columns from the "employees" table.
	select first_name , last_name 
	from Sales.Employees
--Retrieve "full name" as a one column from "first_name" and "last_name" columns from the "employees" table.
select first_name + ' '+ last_name As 'full name' 
	from Sales.Employees
--Show the average salary of all employees. (Use AVG() function)
select avg(salary)
from Sales.Employees

--Select employees whose salary is greater than 50000.
--Show the average salary of all employees. (Use AVG() function)
select first_name + ' '+ last_name As 'full name'  , salary 
from Sales.Employees
where salary > 50000
--Retrieve employees hired in the year 2024.
select first_name + ' '+ last_name As 'full name'  , hire_date 
from Sales.Employees
WHERE hire_date BETWEEN '2024-01-01' AND '2024-12-31';
--List employees whose last names start with 'S'
select first_name + ' '+ last_name As 'full name' 
from Sales.Employees
WHERE last_name like '%s' ;
--Display the top 10 highest-paid employees.
select top (10) first_name + ' '+ last_name As 'full name' , salary
from Sales.Employees
order by salary desc;
--Find employees with salaries between 40000 and 60000.
select first_name  , salary
from Sales.Employees
where salary between 40000 and 60000;
--Show employees with names containing the substring 'man'.
select last_name 
from Sales.Employees
WHERE last_name  like '%man%' ;
--Display employees with a NULL value in the "hire_date" column
select hire_date 
from Sales.Employees
WHERE hire_date is null;
--Select employees with a salary in the set (40000, 45000, 50000).
select first_name  , salary
from Sales.Employees
where salary IN (40000 , 45000 , 60000);
--Retrieve employees hired between '2024-01-01' and '2025-01-01'
select first_name + ' '+ last_name As 'full name'  , hire_date 
from Sales.Employees
WHERE hire_date BETWEEN '2024-01-01' AND '2025-01-01';
--List employees with salaries in descending order.
select first_name  , salary
from Sales.Employees
order by salary desc;
--Show the first 5 employees ordered by "last_name" in ascending order
select top(5) last_name  
from Sales.Employees
order by last_name desc;
--Display employees with a salary greater than 55000 and hired in 2020.
select first_name  , salary
from Sales.Employees
where salary > 55000 and hire_date BETWEEN '2024-01-01' AND '2024-12-31'

--Select employees whose first name is 'John' or 'Jane'.
select first_name  
from Sales.Employees
where first_name like '%John%' or first_name like '%Jane%'
--List employees with a salary ≤ 55000 and a hire date after '2025-01-01'.
select first_name  , salary
from Sales.Employees
where salary <= 55000 and hire_date BETWEEN '2025-01-01' AND '2025-12-31'
--retrieve employees with a salary greater than the average salary. (use chatGpt)
select first_name , salary  
from Sales.Employees
where  salary > (select avg(salary) from Sales.Employees)
--Display the 3rd to 7th highest-paid employees
select * 
from Sales.Employees
order by salary desc
offset 2 rows
fetch next 5 rows only
--List employees hired after '2021-01-01' in alphabetical order.
select * 
from Sales.Employees
where  hire_date BETWEEN '2024-01-01' AND '2025-12-31'
order by first_name 
--Retrieve employees with a salary > 50000 and last name not starting with 'A'.
select * 
from Sales.Employees
where  salary > 50000 and last_name not like 'A%'

--Display employees with a salary that is not NULL.
select * 
from Sales.Employees
where  salary is not null

--Show employees with names containing 'e' or 'i' and a salary > 45000.
select * 
from Sales.Employees
where  salary > 50000 and first_name like  ('%e%') or first_name like  ('%i%')
--add column Manger id
alter table [Sales].[Employees]
add ManagerId  int

ALTER TABLE [Sales].[Employees]
ADD  PRIMARY KEY(Emp_id)
--Create Table Department
create table Departments (
   department_id int primary key  identity(1 , 1),
   department_name varchar(50),
   ManagerId int ,
);
alter table [Sales].[Employees]
drop column ManagerId


alter table[Sales].[Employees]
add ManagerId INT
FOREIGN KEY (ManagerId) REFERENCES [Sales].[Employees](ManagerId);




--transfer departement table into sales schema
alter schema Sales
transfer dbo.Departments
--Assign each employee to a department by creating a "department_id" column in "employees" 
--and making it a foreign key referencing "departments".department_id.
alter table[Sales].[Employees]
add department_id INT,
FOREIGN KEY (department_id) REFERENCES [Sales].[Departments](department_id);

--Retrieve all employees with their department names (Use INNER JOIN).
select * 
from [Sales].[Employees] e inner join [Sales].[Departments] d
on e.department_id = d.department_id
--Retrieve employees who don’t belong to any department (Use LEFT JOIN and check for NULL).
select * 
from [Sales].[Employees] e left join [Sales].[Departments] d
on e.department_id = d.department_id
where d.department_id is null
--Show all departments and their employee count (Use JOIN and GROUP BY).
select d.department_name , count (Employees.first_name)
from [Sales].[Employees] e left join [Sales].[Departments] d
on e.department_id = d.department_id
group by d.department_name
--Retrieve the highest-paid employee in each department (Use JOIN and MAX(salary)).
select e.Emp_id, e.first_name, e.salary, d.department_name
from [Sales].[Employees] e inner JOIN [Sales].[Departments] d 
on e.department_id = d.department_id
where e.salary = (
    select MAX(salary)
    from [Sales].[Employees]
    where department_id = e.department_id
);
 












