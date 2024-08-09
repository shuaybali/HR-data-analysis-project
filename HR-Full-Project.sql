-- Human Rescource Full project ---
USE HR1;
SELECT * FROM attendance;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM leavee;
SELECT * FROM payroll;

-- Total number of employees in each department:

SELECT d.name, COUNT(e.employee_id) as ` Total number of employee`
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.name;

-- Average salary by department:

SELECT * FROM PAYROLL;
SELECT * FROM DEPARTMENTS;
SELECT * FROM employees;

SELECT d.name , AVG(p.salary) as `Average salary by deparments`
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN payroll p ON e.employee_id = p.employee_id
GROUP BY d.name;


-- Employees with the highest attendance:
SELECT * FROM attendance;
SELECT * FROM employees;

SELECT e.first_name,e.last_name, COUNT(a.attendance_id) AS `Highest attendance`
FROM employees e 
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.status = 'Present'
GROUP BY e.employee_id
ORDER BY e.first_name;


-- Total payroll cost per month:
SELECT * FROM PAYROLL;
-- Check data types 
DESCRIBE PAYROLL;

SELECT date_format(pay_date, '%Y-%m') AS MONTHS,
SUM(salary + bonus + deductions) as `Cost per months`
FROM PAYROLL
GROUP BY MONTHS;

-- Department with the highest average bonus:
SELECT * FROM DEPARTMENTS;
SELECT * FROM PAYROLL;
SELECT * FROM employees;

SELECT d.name,
	   AVG(p.bonus) AS `highest average bonus`
FROM DEPARTMENTS d 
JOIN employees e ON d.department_id = e.department_id
JOIN payroll p ON e.employee_id = p.employee_id
GROUP BY d.name
ORDER BY `highest average bonus`
LIMIT 10;
 
 
-- Employees who have never taken leave:
SELECT * FROM employees;
SELECT * FROM LEAVEE;

SELECT e.first_name , e.last_name
FROM employees e
JOIN LEAVEE l ON e.employee_id = l.employee_id
WHERE leave_id IS NULL;


-- Total number of leaves taken by each employee:
SELECT * FROM LEAVEE;
SELECT * FROM employees;

SELECT  e.first_name, e.last_name,
		COUNT(l.leave_id) as `Total number of leaves`
FROM employees e
JOIN leavee l ON e.employee_id = l.employee_id
GROUP BY e.employee_id;


-- Employees with the highest deductions:
SELECT * FROM employees;
SELECT * FROM PAYROLL;

SELECT e.first_name, e.last_name,
       MAX(p.deductions) as `Highest deduction`
FROM employees e 
JOIN payroll p ON e.employee_id = p.employee_id
GROUP BY e.employee_id
ORDER BY `Highest deduction` DESC;


-- Average check-in time by department:
SELECT * FROM departments;
SELECT * FROM attendance;
SELECT * FROM employees;

SELECT d.name, AVG(TIME_TO_SEC(a.check_in_time)) as `Check in second`
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN attendance a ON e.employee_id = a.employee_id
GROUP BY d.name
ORDER BY `Check in second` DESC;

-- Employees with the longest tenure:
SELECT e.first_name,e.last_name, DATEDIFF(CURDATE(), e.hire_date) as `Longest tenure`
FROM employees e
ORDER BY `Longest tenure` DESC
lIMIT 10;


-- Total bonuses paid by department:

SELECT * FROM PAYROLL;
SELECT * FROM departments;

SELECT d.name, SUM(p.bonus) as `Total bonus paid`
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN payroll p ON e.employee_id = p.employee_id
GROUP BY d.name;


-- Employees with the most approved leaves:

SELECT * FROM LEAVEE;
SELECT * FROM employees;

SELECT e.first_name, last_name
FROM employees e
JOIN leavee l ON e.employee_id = l.employee_id
WHERE l.status ='Approved'
ORDER BY e.first_name;

SELECT e.first_name, last_name, COUNT(l.leave_id) As `Most leaves`
FROM employees e
JOIN leavee l ON e.employee_id = l.employee_id
GROUP BY l.leave_id
ORDER BY `Most leaves`;

-- How many male and female --
SELECT * FROM employees;

SELECT gender, COUNT(gender) as `Number male and female`
FROM employees
GROUP BY gender;

-- Total Working Hours by Employee:

SELECT e.first_name, e.last_name,
	   SUM(TIMESTAMPDIFF(HOUR, a.check_in_time, a.check_out_time)) as `Total hours`
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
GROUP BY e.employee_id;

-- Employees with highest salaries
SELECT e.first_name, e.last_name,d.name AS Department,
	   MAX(salary) AS `Highest salareies`
FROM employees e
JOIN PAYROLL p ON e.employee_id = p.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY e.employee_id
ORDER BY `Highest salareies` DESC
LIMIT 10;

-- Employees with the most late late check in
SELECT * FROM attendance;

SELECT e.first_name , COUNT(a.attendance_id) AS `Late check in`
FROM employees e 
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.check_in_time > '09:00:00'
GROUP BY e.employee_id
ORDER BY `Late check in`
LIMIT 10;

SELECT * FROM attendance
WHERE check_in_time > '09:00:00';

SELECT e.first_name ,d.name AS Department, a.check_in_time
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE check_in_time > '09:00:00';

-- Employee came on time
SELECT e.first_name ,d.name AS Department, a.check_in_time
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE check_in_time <= '09:00:00'

