/*with, merge, inline view*/
--WITH - służy do przygotowania zapytań, które potem można użyć poza klauzulą with

--przyjmijmy, że mamy taki kod z podzapytaniem
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
(SELECT salary
FROM employees
WHERE department_id IN (10,20))
ORDER BY department_id;

--przygotujmy podzapytanie przed finalnym zapytaniem
WITH 
pensje_dep_10_20 as
(select salary from employees where department_id IN (10,20)),
min_salary as 
(select department_id, MIN(salary) from employees group by department_id
HAVING MIN(salary) < ANY(select * from pensje_dep_10_20))
select * from min_salary


--sprawdzmy, ktorzy pracownicy zarabiaja wiecej niz mediana + odch_standardowe ze swoich departamentów
WITH statystyki as 
(select stddev(salary) as odchylenie, median(salary) as mediana, job_id from employees group by job_id),
pracownicy as
(select first_name, last_name, employees.job_id, salary, odchylenie, mediana from employees inner join statystyki on statystyki.job_id = employees.job_id)
select first_name, last_name, job_id, salary, odchylenie, mediana from pracownicy where salary > mediana + odchylenie



--MERGE służy do aktualizacji i dołączania wierszy z jednej tabeli do drugiej.
drop table pracownicy_finalna;
drop table pracownicy_tymczasowa;

create table pracownicy_finalna as select * from employees where 1 = 2; --tworzymy pustą tabele 
create table pracownicy_tymczasowa as select * from employees where to_char(hire_date, 'yyyy') < '1993'; --tworzymy tabele z jakimiś danymi

select * from pracownicy_finalna 
select * from pracownicy_tymczasowa 

--musimy zdefiniować, po czym łączymy tabele
MERGE INTO pracownicy_finalna pf
USING pracownicy_tymczasowa pt ON (
    pf.employee_id = pt.employee_id
)
--jeżeli w pierwszej tabeli i w drugiej tabeli jest rekord z tym samym kluczem
WHEN MATCHED THEN 
update SET
pf.department_id = pt.department_id,
pf.job_id = pt.job_id,
pf.manager_id = pt.manager_ID
--jeżeli w pierwszej tabeli nie istnieje rekord który istnieje w drugiej porównując klucze
WHEN NOT MATCHED THEN 
INSERT 
(pf.employee_id, pf.first_name, pf.last_name, pf.email, pf.phone_number, pf.hire_date, pf.job_id, pf.salary, pf.commission_pct, pf.manager_id, pf.department_id, pf.bonus)
VALUES
(pt.employee_id, pt.first_name, pt.last_name, pt.email, pt.phone_number, pt.hire_date, pt.job_id, pt.salary, pt.commission_pct, pt.manager_id, pt.department_id, pt.bonus)


select * from pracownicy_finalna 
select * from pracownicy_tymczasowa 

--teraz zadziala WHEN MATCHED THEN update
update pracownicy_tymczasowa set job_id = 'AD_VP' where employee_id = 103

MERGE INTO pracownicy_finalna pf
USING pracownicy_tymczasowa pt ON (
    pf.employee_id = pt.employee_id
)
WHEN MATCHED THEN 
update SET
pf.department_id = pt.department_id,
pf.job_id = pt.job_id,
pf.manager_id = pt.manager_ID
WHEN NOT MATCHED THEN 
INSERT 
(pf.employee_id, pf.first_name, pf.last_name, pf.email, pf.phone_number, pf.hire_date, pf.job_id, pf.salary, pf.commission_pct, pf.manager_id, pf.department_id, pf.bonus)
VALUES
(pt.employee_id, pt.first_name, pt.last_name, pt.email, pt.phone_number, pt.hire_date, pt.job_id, pt.salary, pt.commission_pct, pt.manager_id, pt.department_id, pt.bonus)

select * from pracownicy_finalna 

drop table pracownicy_finalna;
drop table pracownicy_tymczasowa;

--Inline view - zamiast pobierać dane z tabeli pobieramy dane z polecenia select

select last_name, salary, e.job_id, iv.avgsal
from employees e, (select job_id,avg(salary) avgsal
from employees
group by job_id) iv
where e.job_id=iv.job_id




