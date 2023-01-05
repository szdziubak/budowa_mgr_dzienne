/*Insert wielotablicowy, Indeks B-tree, funkcje analityczne*/

--insert wielotablicowy pozwala na dodanie danych do wielu tablic jednocześnie
create table imie_nazwisko as select employee_id, first_name, last_name from employees where 1 = 2
create table job_dept as select employee_id, job_id, department_id from employees where 1 = 2

insert all
into imie_nazwisko values(employee_id, first_name, last_name) --definiujemy kolumny, z których dane zostaną dodane
into job_dept values(employee_id, job_id, department_id) --definiujemy kolumny, z których dane zostaną dodane
select employee_id, first_name, last_name, job_id, department_id from employees --definiujemy listę kolumn, z której pododajemy dane do nowych kolumn

select * from imie_nazwisko 
select * from job_dept 

truncate table imie_nazwisko
truncate table job_dept

--z warunkiem
insert all
when employee_id < 110 then
into imie_nazwisko values(employee_id, first_name, last_name)
when employee_id < 110 then
into job_dept values(employee_id, job_id, department_id) 
select employee_id, first_name, last_name, job_id, department_id from employees

--insert first - wstawia wiersz tylko raz, do momentu w którym spełniony jest pierwszy warunek, kolejnych już nie sprawdza
create table employees2 as select employee_id, first_name, last_name from employees where 1 = 2
create table employees3 as select employee_id, first_name, last_name from employees where 1 = 2

insert first
when employee_id < 110 then
into employees2 values (employee_id, first_name, last_name)
when employee_id < 150 then
into employees3 values (employee_id, first_name, last_name)
select employee_id, first_name, last_name from employees


--insert all z agregacjami
create table employees4 (department_id number, average_salary number)
create table employees5 (department_id number, max_salary number)

insert all
into employees4 values (department_id, avg_salary)
into employees5 values (department_id, max_salary)
select department_id, avg(salary) as avg_salary, max(salary) as max_salary
from employees group by department_id

select * from employees4
select * from employees5

drop table imie_nazwisko
drop table job_dept
drop table employees2
drop table employees3
drop table employees4
drop table employees5

--Indeks B-tree
/*Indeksy w bazie danych ułatwiają przeszukiwanie bazy danych. Należy zakładać je na często odpytywanych kolumnach, które podlegają filtrowaniu.
Przyjmuje się, że z tej kolumny powinniśmy pobierać niewielką ilość wierszy np. dane o transakcjach finansowych z dnia poprzedniego
jeżeli nasza baza danych posiada dane z wielu dni (np z okresu pół roku).
Indeksy B-tree (B-drzewo) powinny być tworzone na kolumnach zawierjących duży zakres wartości (np. numer pesel czy employee_id)
Oracle automatycznie tworzy indeks B-tree na kluczach głónych i na kolumnach unikatowych*/
create index employees_last_name_idx on employees(last_name) --zwykły indeks
create index employees_last_name_idx2 on employees(upper(last_name)) --indeks oparty na funkcji
create index employees_last_name_idx3 on employees(department_id, last_name) --indeks złożony z wielu tabel które będą odpytywane jednocześnie
--dla indeksu złożonego jednoczesne odpytywanie wielu kolumn:
select *
from employees
where department_id<100 and last_name='Abel'

alter index employees_last_name_idx rename to employees_last_name_idx1

--informacje o indeksie
select * from user_indexes where table_name = 'EMPLOYEES'
select * from user_ind_columns where table_name = 'EMPLOYEES'

drop index employees_last_name_idx1;
drop index employees_last_name_idx2;
drop index employees_last_name_idx3;

--funkcje analityczne

--Rank() - ranking departamentów z sumą pensji
select department_id, 
sum(salary), --suma pensji po departamencie
rank() OVER (ORDER BY SUM(salary) desc) as rank --ranking departamentów na które wydajemy najwięcej jezeli chodzi o pensje
from employees group by department_id

--LAG - poprzedni, LEAD - następny
select department_id, last_name ,salary,
 lead (last_name, 1) over (order by salary) next_last_name,
 lead (salary, 1) over (order by salary) next_salary,
 lag (last_name, 1) over (order by salary) previous_last_name,
 lag (salary, 1) over (order by salary) previous_salary
from employees

--suma krocząca
select to_char(hire_date, 'yyyy') as year, sum(salary) as year_sum,
SUM(SUM(salary)) OVER (order by to_char(hire_date, 'yyyy') ROWS BETWEEN UNBOUNDED PRECEDING and CURRENT ROW) as cumulative_amount
from employees
group by to_char(hire_date, 'yyyy')
order by to_char(hire_date, 'yyyy')

--suma centralna
select to_char(hire_date, 'yyyy') as year, sum(salary) as year_sum,
AVG(SUM(salary)) OVER (order by to_char(hire_date, 'yyyy') ROWS BETWEEN 1 PRECEDING and 1 FOLLOWING) as moving_average
from employees
group by to_char(hire_date, 'yyyy')
order by to_char(hire_date, 'yyyy')

Do domu (nie będziemy tego sprawdzać):
insert-multi (1 osoba)
indeks (2 osoby: 5+4)

