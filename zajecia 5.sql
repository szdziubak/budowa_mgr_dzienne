--do łączenia tabel według klucza będziemy potrzebować poleceń join
--jeżeli dane których potrzebujemy przechowywane są w wielu tabelach to joiny będą niezbędne
--do joinów wykorzystujemy 2 klauzule: zgodne z ANSI i Oraclowe.

--0. Where
select * from departments, locations 
where departments.location_id = locations.location_id;

--1. Natural join - łączy tabele po takich samych nazwach kolumn
SELECT first_name, last_name, job_id, job_title
FROM employees NATURAL JOIN jobs;
SELECT department_name, city
FROM departments NATURAL JOIN locations;
--nie podajemy nazwy kolumn do łączenia

--2. Cross join - łączy każdy wiersz z każdym czyli np. 1 tabela: 20 wierszy, 2 tabela: 20 wierszy, crosss join: 20x20
SELECT last_name, department_name
FROM employees CROSS JOIN departments;
SELECT department_name, city
FROM departments cross JOIN locations;
Select * from departments, locations;

--3. Using - wybieramy kolumne po której będzie robiony join (ale tylko jedną)
SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id);
SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id)
WHERE last_name = 'Higgins';

--4. Join on - pozwala na rozbudowe zapytania
SELECT last_name, job_title
FROM employees e JOIN jobs j --aliasy tabel
ON (e.job_id = j.job_id);

SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.job_id = j.job_id)
WHERE last_name LIKE 'H%';

--operatory nierówności - np. ON ... BETWEEN
SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees JOIN job_grades
ON(salary BETWEEN lowest_sal AND highest_sal);

--łączenie więcej niż 2 tabel
SELECT last_name, department_name AS "Department", city
FROM employees JOIN departments USING (department_id)
JOIN locations USING (location_id);

--INNER JOIN vs OUTER JOIN
--INNER JOIN - to co jest w A i B, czyli łączy tylko niepuste klucze A i B. To co dotychczas poznaliśmy to INNER JOIN (oprócz iloczynu kartezjańskiego)
--LEFT OUTER JOIN - wszystko to co jest w A i niepuste klucze z B
--RIGHT OUTER JOIN - wszystko to co jest w B i niepuste klucze z A
--FULL OUTER JOIN - wszystko z A i B (puste i niepuste klucze)

--porównajmy
SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
INNER JOIN departments d ON (e.department_id = d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
LEFT OUTER JOIN departments d ON (e.department_id = d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
RIGHT OUTER JOIN departments d ON (e.department_id = d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
FULL OUTER JOIN departments d ON (e.department_id = d.department_id);

--SELF JOIN - łączenie tabeli samej ze sobą.
--Tabela employees jest połączona ze sobą ponieważ występuje relacja samej ze sobą tzn. kolumn employee_id i manager_id
SELECT worker.last_name || ' works for ' || manager.last_name
AS "Works for"
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

SELECT worker.last_name, worker.manager_id, manager.last_name
AS "Manager name"
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

--Zapytania hierarchiczne - budujemy drzewo ze strukturą czegoś np. organizacji
-- START WITH - korzeń drzewa, od czego zaczynamy czyli np. szef szefów
-- CONNECT BY PRIOR - jak zrobić joiny
-- LEVEL - numer głębokości, warstwy drzewa (kolumna)
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100 --zaczynamy budowe od pracownika z numerem 100
CONNECT BY PRIOR employee_id = manager_id

SELECT last_name ||' reports to ' || PRIOR last_name AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;

SELECT LEVEL, last_name || 
' reports to ' || 
PRIOR last_name
AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR 
employee_id = manager_id;

SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_')
AS "Org Chart"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;


--przycinanie drzewa:

--usuwamy tylko jednego pracownika
SELECT last_name
FROM employees
WHERE last_name != 'Higgins'
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id;

--usuwamy całą gałąź po Higgins'ie
SELECT last_name
FROM employees 
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id
AND last_name != 'Higgins';

--Joiny oraclowe
SELECT employees.last_name, employees.job_id, jobs.job_title
FROM employees, jobs 
WHERE employees.job_id = jobs.job_id; --złączenie w where

--oraclowy iloczyn kartezjański
SELECT employees.last_name, departments.department_name
FROM employees, departments;

--join w where z warunkiem
SELECT employees.last_name, employees.job_id, jobs.job_title
FROM employees, jobs 
WHERE employees.job_id = jobs.job_id
AND employees.department_id = 80;

--alisowanie tabel
SELECT last_name, e.job_id, job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND department_id = 80;

--oraclowe złączenia nierówne
SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees, job_grades
WHERE (salary BETWEEN lowest_sal AND highest_sal);

--oraclowy outer join - (+) przy tabeli, przy której mogą być brakujące dane czyli bierzemy wszystko z jednej tabeli i dołączamy do niej dane z tabeli z (+)
SELECT e.last_name, d.department_id, 
d.department_name
FROM employees e, departments d
WHERE e.department_id = 
d.department_id(+);  --jak left outer join

SELECT e.last_name, d.department_id, 
d.department_name
FROM employees e, departments d
WHERE e.department_id(+) = --odpowiednik right outer join 
d.department_id;


--nie ma odpowiednika FULL OUTER JOIN


Do domu:
4. Join.sql (2 osoby: 4+4)
4. laczenia.sql (2 osoby: 4+4)
