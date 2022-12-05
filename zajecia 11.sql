/*Opeartory grupujące 
Rollup, cube, grouping sets, kolumny nierozłączne, grouping
*/

--Uwaga - Null (albo: "-") oznacza, że po tej wartości nie dokonano grupowania
--Klauzula ROLLUP zwraca częściowe podsumowanie pierwszej kolumny i podsumowanie całkowite wszystkich grup
--jedna kolumna
select job_id, avg(salary) as srednia_pensja
from employees
group by job_id
order by 1

select job_id, avg(salary) as srednia_pensja
from employees
group by ROLLUP(job_id) -- + srednia dla wszystkich job_id
order by 1

--2 kolumny
select job_id, department_id, avg(salary) as srednia_pensja
from employees
group by job_id, department_id
order by 1

select job_id, department_id, avg(salary) as srednia_pensja
from employees
group by ROLLUP(job_id, department_id) -- + srednia dla wszystkich job_id, job_id+department_id i wszystkich razem
order by 1

--2 kolumny - inna kolejność
select job_id, department_id, avg(salary) as srednia_pensja
from employees
group by job_id, department_id
order by 1

select job_id, department_id, avg(salary) as srednia_pensja
from employees
group by ROLLUP(department_id,job_id) -- + srednia dla wszystkich job_id, job_id+department_id i wszystkich razem
order by 1

--Klauzula CUBE dodaje wiersze zawierające podsumowania częściowe dla wszystkich kombinacji kolumn oraz wiersz zawierający podsumowanie całkowite
select job_id, department_id, avg(salary) as srednia_pensja
from employees
group by job_id, department_id
order by 1

select job_id, department_id, avg(salary) as srednia_pensja
from employees
group by CUBE(job_id, department_id) --grupuje po pierwszej i po drugiej + podsumowanie
order by 1,2

select job_id, department_id, manager_id, avg(salary) as srednia_pensja
from employees
group by CUBE(job_id, department_id, manager_id) --grupuje po pierwszej, po drugiej i po trzeciej+ podsumowanie
order by 1
--wniosek 1 : w CUBE trzeba poda >= 2 kolumny
--wniosek 2 : kolejność ma znaczenie ale tylko do wyświetlania kolejności, grupowanie i tak jest robione po wszystkich


--Funkcja GROUPING() jako argument bierze kolumnę i zwraca 0 lub 1.
--Zwraca 1 gdy wartość kolumny wynosi NULL (nie jest używana do grupowania)
--Zwraca 0 gdy wartość kolumny nie jest NULLem (jest używana do grupowania)
select department_id, avg(salary) from employees group by ROLLUP(department_id) order by department_id

--zauważmy, że przedostatni NULL dane wartość zero a ostatni 1.
--Dzieje się tak, ponieważ wśród wartości w kolumnie department_id mamy wartość NULL, która jest poddana grupowaniu
select grouping(department_id), department_id, avg(salary) from employees group by ROLLUP(department_id) order by department_id 

--co zwróci to zapytanie?
select grouping(department_id) as group_dep_id, department_id, grouping(job_id) as group_job_id, job_id, avg(salary) 
from employees group by CUBE(department_id, job_id) having grouping(department_id) = 1 and grouping(job_id) = 1

--dodajemy wyrażenie case
select 
case when grouping(department_id) = 0 then to_char(department_id) else 'wszystkie departamenty' end as department, 
case when grouping(job_id) = 0 then to_char(job_id) else 'wszystkie stanowiska' end as job,
avg(salary) from employees group by CUBE(department_id, job_id) order by department_id 


--Wyrażenie GROUPING SETS pozwala na uzyskanie podsumowań częściowych
--Możemy określić konkretne poziomy grupowań

select department_id, grouping(department_id), avg(salary) from employees
group by GROUPING SETS((department_id)) --grupujemy tylko po department_id
/*porównajmy z 
select department_id, avg(salary) from employees
group by department_id*/

select job_id, grouping(job_id), avg(salary) from employees
group by GROUPING SETS((job_id)) --grupujemy tylko po job_id
/*porównajmy z 
select job_id, avg(salary) from employees
group by job_id*/

select department_id, grouping(department_id), job_id, grouping(job_id), avg(salary) from employees
group by GROUPING SETS((department_id, job_id)) --grupujemy jednocześnie po department_id i job_id
/*porównajmy z 
select department_id, job_id, avg(salary) from employees
group by department_id, job_id*/


select department_id, grouping(department_id), job_id, grouping(job_id), avg(salary) from employees
group by GROUPING SETS((department_id), (job_id), (department_id, job_id), ())
/*
spróbujmy rozbić: GROUPING SETS((department_id), (job_id), (department_id, job_id), ())
(department_id) - grupowanie po departamencie a nie po job_id 
(job_id) - grupowanie po job_id a nie po departamencie
(department_id, job_id) - jednoczesne grupowanie po job_id i po departamencie
() - brak grupowania po departamencie i po job_id, podsumowanie dla wszystkich grup
*/


--wielokrotne użycie kolumny w GROUP BY
select department_id, job_id, avg(salary) from employees
group by department_id, GROUPING SETS(department_id, (department_id, job_id), ()) --spowoduje duplikaty

--KLAUZULA GROUP_ID() zwraca liczbe <> 0 gdy agregacja jest zduplikowana
select department_id, job_id, GROUP_ID(), avg(salary) from employees
group by department_id, GROUPING SETS(department_id, (department_id, job_id), ()) 

--możemy odfiltorować zduplikowane agregacje
select department_id, job_id, avg(salary) from employees
group by department_id, GROUPING SETS(department_id, (department_id, job_id), ()) having GROUP_ID() = 0


Do domu:
rollup (2 osoby: 3+3)
