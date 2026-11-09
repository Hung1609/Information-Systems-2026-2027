/*
- Who have the same name as the managers of the “Finance” department?
- Who in the “Production” department were hired after the promotion of the last manager in that department?
- Find the average salary of each department, from highest to lowest.
- Find the average salary for each type of Engineer, from highest to lowest.
*/

use employees;

-- 1.Who have the same name as the managers of the “Finance” department?
select concat(first_name, ' ', last_name) as total_name from employees join dept_emp using (emp_no) join departments using (dept_no) where concat(first_name, ' ', last_name) in (select concat(first_name, ' ', last_name) as manager_name from dept_manager join employees using (emp_no) join departments using (dept_no) where dept_name = "Finance");

-- 2.Who in the “Production” department were hired after the promotion of the last manager in that department?
select hire_date, concat(first_name, ' ', last_name) as total_name from employees join dept_emp using (emp_no) join departments using (dept_no) where dept_name = "Production" and hire_date > (select max(from_date) from dept_manager join departments using (dept_no) where dept_name = "Production");

-- 3.Find the average salary of each department, from highest to lowest.
-- select dept_name, avg(salary) as average_salary from salaries join dept_emp using (emp_no) join departments using (dept_no) group by dept_name order by (average_salary) desc
select dept_name, avg(salary) as average_salary from salaries join (select emp_no, dept_name from dept_emp join departments using (dept_no)) as employee_department using (emp_no) group by dept_name order by average_salary desc;

-- 4. Find the average salary for each type of Engineer, from highest to lowest.
select avg(salary) as average_salary, title from salaries join (select emp_no, title from titles where title like '%Engineer%') as engineer_title using (emp_no) group by title order by (average_salary) desc;