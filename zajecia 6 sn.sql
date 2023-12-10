--Podzapytania - zapytanie wewnętrzne wykorzystywane przez zapytanie główne
--podzapytania umieszczamy w nawiasach
--nie może zawierać ORDER BY

/*
Typy podzapytań:
- jednowierszowe - zwracają jeden wiersz, użyjemy >, =, <, <>, <=
- wielowierszowe - zwracają wiele wierszy, użyjemy IN, ANY, ALL
*/
SELECT first_name, last_name, hire_date
FROM employees WHERE hire_date > (SELECT hire_date
FROM employees WHERE last_name = 'Vargas');

SELECT last_name FROM employees
WHERE department_id = (SELECT department_id
FROM employees WHERE last_name = 'Grant'); --podzapytanie zwraca NULL

SELECT last_name, job_id, department_id
FROM employees
WHERE department_id = 
(SELECT department_id --nie wiemy który department_id ma marketing więc tworzymy podzapytanie
FROM departments
WHERE department_name = 'Marketing')
ORDER BY job_id;


SELECT last_name, job_id, salary, department_id
FROM employees
WHERE job_id = 
(SELECT job_id
FROM employees 
WHERE employee_id = 141) --jeden warunek
AND department_id = 
(SELECT department_id
FROM departments 
WHERE location_id = 1500); --drugi warunek

--z funkcjami grupującymi
SELECT last_name, salary
FROM employees
WHERE salary < 
(SELECT AVG(salary) --pracownicy zarabiający poniżej średniej
FROM employees);

--departamenty z pensją wyższą niż minimalna dla departamentów
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
(SELECT MIN(salary)
FROM employees
WHERE department_id = 50);


--podzapytania wielowierszowe
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90); --lata zatrudnienia wśród lat zatrudnienia ludzi z departamentu 90

--ANY - co najmniej jedna wartość
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY --rok musi być mniejszy niż co najmneij jeden rok spośród pracowników z departamentu 90
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);


--ALL - wszystkie wartości
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ALL --rok musi być mniejszy niż wszystkie wartości
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

--Dla ANY i IN jeżeli w podzapytaniu mamy NULL to zapytanie główne zwróci wiersze które będą pasowały do nienullowych wartości
--Dla ALL jeżeli w podzapytaniu mamy NULL to podzapytanie nie zwróci nic więc zapytanie główne również nic nie zwróci
SELECT last_name, employee_id
FROM employees
WHERE employee_id IN
(SELECT manager_id
FROM employees);

SELECT last_name, employee_id
FROM employees
WHERE employee_id <= ALL
(SELECT manager_id
FROM employees);

--podzapytania wielowierszowe z funkcją grupującą
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
(SELECT salary
FROM employees
WHERE department_id IN (10,20))
ORDER BY department_id;

--podzapytania z mieloma kolumnami
--SELECT employee_id, manager_id, department_id
--FROM employees
--WHERE(manager_id,department_id) IN
--(SELECT manager_id,department_id
--FROM employees
--WHERE employee_id IN (149,174))
--AND employee_id NOT IN (149,174)

--odpowiednik tego wyżej:
--SELECT employee_id,
--manager_id, 
--department_id
--FROM employees
--WHERE manager_id IN 
--(SELECT manager_id
--FROM employees
--WHERE employee_id IN 
--(149,174))
--AND department_id IN 
--(SELECT department_id
--FROM employees
--WHERE employee_id IN 
--(149,174))
--AND employee_id NOT IN(149,174);

--Exists/NOT Exists - zwraca TRUE jeżeli podzapytanie zwraca jakiekolwiek wiersze
--select * from employees emp
--WHERE EXISTS 
--(select 1 from departments d --zwraca tylko te wiersze, które mają niepsute department_id
--WHERE d.department_id = emp.department_id)

--SELECT last_name
--FROM employees emp
--WHERE NOT EXISTS 
--(SELECT * FROM employees mgr --zwraca tylko tych pracowników, któzy mają niepuste manager_id
--WHERE mgr.manager_id = emp.employee_id);


Do domu:
6. podzapytania (3 osoby: 4+3+3)
7. subquery2 (2 osoby: 4+3)