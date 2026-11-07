use employees;

-- 1. All info of all
select * from employees;

-- 2. All info of all departments
select * from departments join dept_emp using (dept_no) join dept_manager using (dept_no);

-- 3. Full names of all employees
select concat(first_name, ' ', last_name) as full_name from employees;

-- 4. Names of all departments
select dept_name from departments;

-- 5. Full names of employees working in "Sales" department
select concat(first_name, ' ', last_name) as full_name from employees join dept_emp using (emp_no) join departments using (dept_no) where dept_name = "Sales";

-- 6. Full names of male employees working in “Finance” department
select concat(first_name, ' ', last_name) as full_name from employees join dept_emp using (emp_no) join departments using (dept_no) where dept_name = "Finance" and gender = "M";

-- 7. Salaries of female employees working in “Marketing” department
select salary from salaries join employees using (emp_no) join dept_emp using (emp_no) join departments using (dept_no) where dept_name = "Marketing" and gender = "F";

-- 8. Full names of employees who have the same last name as their manager
select concat(e.first_name, ' ', e.last_name) as full_name from employees as e join dept_emp as de on e.emp_no = de.emp_no join dept_manager as ma on de.dept_no = ma.dept_no join employees as m on ma.emp_no = m.emp_no where e.last_name = m.last_name;

-- 9. Full names of managers who have been doing the job at least twice
SELECT DISTINCT CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM dept_manager AS a
JOIN dept_manager AS b ON a.emp_no = b.emp_no AND a.dept_no <> b.dept_no
JOIN employees AS e ON a.emp_no = e.emp_no;

-- 10. Full names of employees who was paid more than $100000
select distinct concat(first_name, ' ', last_name) as full_name from salaries join employees using (emp_no) where salary > 100000;

-- 11. Names of all departments that have employees paid more than $100000
select distinct dept_name from departments join dept_emp using (dept_no) join employees using (emp_no) join salaries using (emp_no) where salary > 100000;
