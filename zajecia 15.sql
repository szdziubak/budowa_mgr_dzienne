/*RegEXP, strefy czasowe*/

--Wyrażenia regularne - RegEX
/*
Wybrane metaznaki:
^ - początek napisu
$ - koniec napisu
[abc] - spełnione przez każdy wymieniony znak
[a-z] - spełnione przez każdy znak z zakresu

Metaznaki z języka Perl:
\d - cyfra
\D - znak niebędący cyfrą
\w - słowo
\s - snak spacji
*/

select hire_date from employees where REGEXP_LIKE(to_char(hire_date, 'yyyy'), '^19[89][1-3]$') --19 & 8 lub 9 & 1 lub 2 lub 3
select REGEXP_REPLACE(to_char(hire_date, 'yyyy'), '^19[89][1-3]$', '2000')  from employees --zamieniamy na 2000
select job_id, REGEXP_INSTR(job_id, 'A', 2) from employees --zwraca pozycję drugiego wystąpienia 'A'
select street_address, REGEXP_COUNT(street_address, 'a', 7, 'i') from locations --od 7 pozycji zlicza litery 'a' i 'A', 'i' oznacza case insensitive


--strefy czasowe
select 
current_timestamp, -- data i czas dla ustawionej strefy czasowej sesji
sessiontimezone, --strefa czasowa dla sesji bazy danych np. +2:00
current_date --data w ustawionej w sesji strefie czasowej
from dual

/*typy danych:
timestamp - składnik godzinowy
timestamp with time zone – składnik czasowy + strefa czasowa np. +2:00
timestamp with local time zone --umożliwia konwertowanie czasu do lokalnej strefy czasowej ustawionej dla bazy danych
*/

create table emp_zone
(empno number(4),
hiredate timestamp with local time zone);

/*Interwały
nterval year to month - przechowuje lata i miesiące
interval day to second - przechowuje dzień, godzinę, minutę i sekundę
*/
create table emp_interval1
(empno number(4),
time_scope interval year to month );

insert into emp_interval1
values (1000, '1-1'); --czas trwania zatrudnienia to 1 rok i 1 miesiąc

create table emp_interval2
(empno number(4),
time_scope interval day to second );

insert into emp_interval2
values (1000, INTERVAL '3' DAY);

insert into emp_interval2
values (1000, INTERVAL '3 2:25' DAY TO MINUTE);

select * from emp_interval1
select * from emp_interval2

drop table emp_interval1
drop table emp_interval2
drop table emp_zone

Do domu:
regular (1 osoba)
