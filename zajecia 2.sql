--operatory logiczne AND, OR, NOT
/*TRUE AND FALSE = FALSE
TRUE AND TRUE = TRUE
FALSE AND FALSE = FALSE

TRUE OR FALSE = TRUE
TRUE OR TRUE = TRUE
FALSE OR FALSE = FALSE

NOT TRUE = FALSE
NOT FALSE = TRUE*/

--muszą być spełnione obydwa warunki
SELECT last_name, department_id, salary FROM employees WHERE department_id > 50 AND salary > 12000;
SELECT last_name, hire_date, job_id FROM employees WHERE hire_date > '01-Jan-1998' AND job_id LIKE 'SA%';

--musi być spełniony chociaż jeden warunek
SELECT department_name, manager_id, location_id FROM departments WHERE location_id = 2500 OR manager_id=124;

--nie może być spełniony ten warunek
SELECT department_name, location_id FROM departments WHERE location_id NOT IN (1700,1800);

--co stanie się najpierw?
SELECT last_name||' '||salary*1.05 As "Employee Raise" FROM employees
WHERE department_id IN(50,80) AND first_name LIKE 'C%' OR last_name LIKE '%s%';

/*Kolejność wykonywania operacji
1. Operacje artmentyczne: + - * /
2. Konkatencja ||
3. Porówniania: >, < itd
4. IS (NOT) NULL, LIKE, (NOT) IN
4. (NOT) BETWEEN
6. NOT
7. AND
8. OR
Polecam natomiast używać nawiasów np:
((warunek1) OR (warunek2)) AND (warunek3)*/


--ORDER BY
--domyślne sortowanie to ascending: 
    --od najstarszego do najnowszego 
    --od najmniejszego do największego
    --od a do z
    --Nulle będą ostatnie

SELECT last_name, hire_date FROM employees ORDER BY hire_date;
--sortowanie malejąco
SELECT last_name, hire_date FROM employees ORDER BY hire_date DESC;
--sortowanie z aliasami
SELECT last_name, hire_date AS "Date Started" FROM employees ORDER BY "Date Started";
SELECT last_name, hire_date DateStarted FROM employees ORDER BY DateStarted ;
--sortowanie po kolumnie której nie ma w select
SELECT employee_id, first_name FROM employees WHERE employee_id < 105 ORDER BY last_name;

/*
Kolejność wykonywania:
FROM
WHERE
SELECT
ORDER BY
*/

--sortowanie po wielu kolumnach
SELECT department_id, last_name FROM employees WHERE department_id <= 50 ORDER BY department_id, last_name;
SELECT department_id, last_name FROM employees WHERE department_id <= 50 ORDER BY department_id DESC, last_name;


Do domu:
SQL-where (3 osoby: 4+4+3)
