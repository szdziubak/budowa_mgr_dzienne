--opisanie struktury tabeli
DESCRIBE employees

--Konkatencja - łączenie ciągów znaków
SELECT department_id || department_name FROM departments;
SELECT department_id ||' '||department_name FROM departments;

--Aliasy kolumn
SELECT department_id ||' '|| department_name AS " Department Info " FROM departments;
SELECT first_name ||' '|| last_name AS "Employee Name" FROM employees;
SELECT last_name || ' has a monthly salary of ' || salary || ' dollars.' AS Pay FROM employees;
SELECT last_name ||' has a '|| 1 ||' year salary of '|| salary*12 || ' dollars.' AS Pay FROM employees;

--Distinct do eliminacji duplikatów
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;

--Polecenie select
--SELECT*|{[DISTINCT] column | expression alias]..} FROM table [WHERE condition(s)];
SELECT employee_id, first_name, last_name FROM employees;
SELECT employee_id, first_name, last_name FROM employees WHERE employee_id = 101;

--where: możemy używać opeatorów porównania: =, >, >=, <, <=, <> / != / ^=
SELECT employee_id, last_name, department_id FROM employees WHERE department_id = 90;
SELECT first_name, last_name FROM employees WHERE last_name = 'Taylor';
/*WHERE hire_date < '01-Jan-2000'
WHERE salary >= 6000
WHERE job_id = 'IT_PROG'*/

--between
SELECT last_name, salary FROM employees WHERE salary BETWEEN 9000 AND 11000; 
jest to to samo co: WHERE salary >= 9000 AND salary <=11000;

--in
SELECT city, state_province, country_id FROM locations WHERE country_id IN('UK', 'CA');
--jest to to samo co: WHERE country_id = 'UK' OR country_id = 'CA';

--like
-- % - dowolny ciąg znaków
-- _ - jeden znak
SELECT last_name FROM employees WHERE last_name LIKE '_o%';

-- escape character - oznacza, że użyjemy % lub _ jako znaku a nie wildcard
SELECT last_name, job_id FROM EMPLOYEES WHERE job_id LIKE '%\_R%' ESCAPE '\';
SELECT last_name, job_id FROM EMPLOYEES WHERE job_id LIKE '%_R%'

--NULL / NOT NULL
SELECT last_name, manager_id FROM employees WHERE manager_id IS NULL;
SELECT last_name, commission_pct FROM employees WHERE commission_pct IS NOT NULL;


Do domu:
SQL-wstep (1 osoba)
