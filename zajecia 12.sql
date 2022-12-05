/*operatory na zbiorach – union, union all, minus, intersect*/

--prosty przykład operacji na zbiorach
select employee_id, job_id, department_id  from employees
UNION --łączy 2 zbiory bez duplikatów
select employee_id, job_id, department_id from job_history

select employee_id, job_id, department_id  from employees
UNION ALL --łączy 2 zbiory dopuszczając duplikaty
select employee_id, job_id, department_id from job_history

select employee_id, job_id, department_id  from employees
INTERSECT --zwraca część wspólną obydwu zbiorów
select employee_id, job_id, department_id from job_history

select employee_id, job_id, department_id  from employees
MINUS --zwraca rekordy z pierwszego zbioru których nie ma w drugim zbiorze
select employee_id, job_id, department_id from job_history


--Zadanie - spróbujmy przerobić kod niżej bez operacji na zbiorach
select first_name, last_name, department_name, hire_date from employees inner join departments on departments.department_id = employees.department_id where salary < 10000
INTERSECT
select first_name, last_name, department_name, hire_date from employees inner join departments on departments.department_id = employees.department_id where to_char(hire_date, 'yyyy') < '1989'


--kiedy zapytanie zwróci błąd? - różnice w kolumnach
select * from employees
UNION
select * from job_history

Do domu:
union2 (2 osoby: 3+3)
