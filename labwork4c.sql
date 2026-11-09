/*
- Who have the same name as the managers of the “Finance” department?
- Who in the “Production” department were hired after the promotion of the last manager in that department?
- Find the average salary of each department, from highest to lowest.
- Find the average salary for each type of Engineer, from highest to lowest.
*/

use employees;

-- 1.Who have the same name as the managers of the “Finance” department?
create view FinanceDept as select concat (first_name, ' ', last_name) as full_name, emp_no, dept_name from employees join dept_emp using (emp_no) join departments using (dept_no) where dept_name = "Finance";
select * from FinanceDept;
select e.full_name from FinanceDept as e join FinanceDept as m on e.full_name = m.full_name join dept_emp as de on e.emp_no = de.emp_no join dept_manager as dm on m.emp_no = dm.emp_no;

-- 2.Who in the “Production” department were hired after the promotion of the last manager in that department?
create view ProductionDept as select concat(first_name, ' ', last_name) as full_name, hire_date from employees join dept_emp using (emp_no) join departments using (dept_no) where dept_name = "Production";
select full_name, hire_date from ProductionDept where hire_date > (select max(from_date) from dept_manager join departments using (dept_no) where dept_name = "Production");

-- 3.Find the average salary of each department, from highest to lowest.
create view AverageSalary as select avg(salary) as average_salary, dept_name from salaries join dept_emp using (emp_no) join departments using (dept_no) group by dept_name;
select dept_name, average_salary from AverageSalary order by average_salary desc;

-- 4.Find the average salary for each type of Engineer, from highest to lowest.
create view EngineerSalary as select salary, title from salaries join titles using (emp_no) where title like '%Engineer%';
select avg(salary) as average_salary, title from EngineerSalary group by title order by average_salary desc;