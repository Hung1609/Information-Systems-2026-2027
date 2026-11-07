/*
- What is the average salary of each employee?
- How much was each employee paid in total?
- Minimum, maximum and total salaries of each department?
- Which departments have paid more than 20 billion dollars for their employees?
- Total salaries of male employees in each department?
- Total salaries of department managers for each department, from highest to lowest?
*/
use employees;
select * from employees;

-- 1.What is the average salary of each employee?
select emp_no, avg(salary) from salaries group by emp_no;

-- 2.How much was each employee paid in total?
select emp_no, sum(salary) from salaries group by emp_no;

-- 3.Minimum, maximum and total salaries of each department?
select dept_name, min(salary), max(salary), sum(salary) from departments join dept_emp using (dept_no) join salaries using (emp_no) group by dept_name;

-- 4.Which departments have paid more than 20 billion dollars for their employees?
select dept_name, sum(salary) as total from departments join dept_emp using (dept_no) join salaries using (emp_no) group by dept_name having total > 20000000000;

-- 5.Total salaries of male employees in each department?
select dept_name, gender, sum(salary) from departments join dept_emp using (dept_no) join employees using (emp_no) join salaries using (emp_no) where gender = "M" group by dept_name;

-- 6.Total salaries of department managers for each department, from highest to lowest?
select sum(salary) as total_salary, dept_name from departments join dept_manager using (dept_no) join salaries using (emp_no) group by dept_name order by(total_salary) desc;