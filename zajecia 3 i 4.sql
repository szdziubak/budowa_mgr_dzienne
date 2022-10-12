--Funkcje
--jednowierszowe - jeden wiersz na wejściu, jeden na wyjściu np. formatowanie tekstu
--wielowierszowe - wiele wierszy na wejściu, jeden na wyjściu np. średnia

--Dual table - tabela do wykonywania obliczeń
select 2+3 from dual;
SELECT (319/29) + 12 FROM DUAL;

--funkcje jednowierszowe mogą być używane w select, where i order by

--Funkcje znakowe manipulują napisami
SELECT last_name FROM employees WHERE LOWER(last_name) = 'abel';
SELECT last_name FROM employees WHERE UPPER(last_name) = 'ABEL';
SELECT last_name FROM employees WHERE INITCAP(last_name) = 'Abel';
SELECT CONCAT('Hello', 'World') FROM DUAL;
SELECT CONCAT(first_name, last_name) FROM employees;
SELECT SUBSTR('HelloWorld', 1, 5) FROM DUAL;
SELECT SUBSTR('HelloWorld', 6) FROM DUAL;
SELECT SUBSTR(last_name, 1, 3) FROM employees;
SELECT LENGTH('HelloWorld') FROM DUAL;
SELECT LENGTH(last_name) FROM employees;
SELECT INSTR('HelloWorld', 'W') FROM DUAL; --pozycja 
SELECT last_name, INSTR(last_name, 'a') FROM employees;
SELECT LPAD('HelloWorld', 15, '-') FROM DUAL; --z lewej uzupełnia do 15 znaków
SELECT LPAD(last_name, 10, '*') FROM employees; --z lewej uzupełnia do 10 znaków
SELECT RPAD('HelloWorld', 15, '-') FROM DUAL; --uzupełnia z prawej
SELECT RPAD(last_name, 10, '*') FROM employees; --uzupełnia z prawej
SELECT TRIM(LEADING 'a' FROM 'abcba') FROM DUAL; --ucina a z przodu
SELECT TRIM(TRAILING 'a' FROM 'abcba') FROM DUAL; --ucina a z tyłu
SELECT TRIM(BOTH 'a' FROM 'abcba') FROM DUAL;--ucina obydwa a
SELECT REPLACE('JACK and JUE', 'J', 'BL') FROM DUAL; --zamienia J na BL w JACK and JUE
SELECT REPLACE('JACK and JUE', 'J') FROM DUAL; --zamienia J na nic
SELECT REPLACE(last_name, 'a', '*') FROM employees; 
SELECT LOWER(last_name)|| LOWER(SUBSTR(first_name,1,1)) AS "User Name"
FROM employees;

--wpisywanie własnych wartości:
SELECT first_name, last_name, salary, department_id FROM employees WHERE department_id= 10;
SELECT first_name, last_name, salary, department_id FROM employees WHERE department_id=:enter_dept_id;
SELECT * FROM employees WHERE last_name = :l_name;

--Funkcje numeryczne wykonują obliczenia
select ROUND(45.926, 2) from dual; --zaokroglenie do 2 miejsc
select ROUND(45.926, -1) from dual; --zaokraglenie do -1 miejsca
select TRUNC (45.926, 2) from dual --obcina nie zaokrągla
select TRUNC (45.926) from dual;
select mod(3,2) from dual; --operator modulo, reszta z dzielenia
SELECT country_name, MOD(airports,2) AS "Mod Demo" FROM wf_countries;
ABS(-1)
CEIL(1.222) --2
FLOOR(1.222)m --1
GREATEST(1,2,3,4) --4
LOWEST(1,2,3,4) --1
POWER(2,3) --8
SQRT(5) --25, 5^2


--Funkcje dat przetwarzają daty i czas
SELECT SYSDATE FROM dual; --dzisiejsza data
SELECT last_name, hire_date + 60 FROM employees; --+60 dni
SELECT employee_id, (end_date - start_date)/365 
AS "Tenure in last job" FROM job_history; --ilość lat
SELECT last_name, hire_date FROM employees 
WHERE MONTHS_BETWEEN (SYSDATE, hire_date) > 240; --ilość miesięcy pomiędzy datami
SELECT ADD_MONTHS (SYSDATE, 12) AS "Next Year" FROM dual; --dodaje 12 miesiecy do biezacej daty
SELECT NEXT_DAY (SYSDATE, 'Saturday') AS "Next Saturday" FROM dual; --wyswietla nastepna sobote
SELECT LAST_DAY (SYSDATE) AS "End of the Month" FROM dual; --ostatni dzień miesiąca
SELECT hire_date, ROUND(hire_date, 'Month')
FROM employees WHERE department_id = 50; --zaokrągla do pełnego miesiąca
SELECT hire_date, ROUND(hire_date, 'Year')
FROM employees WHERE department_id = 50; --zaokrągla do lat
SELECT employee_id, hire_date, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS TENURE,
ADD_MONTHS (hire_date, 6) AS REVIEW, NEXT_DAY(hire_date, 'FRIDAY'), LAST_DAY(hire_date)
FROM employees WHERE MONTHS_BETWEEN (SYSDATE, hire_date) > 36;


--Funkcje konwertujące konwertują wartość z jednego typu na inny
/* typy danych w Oracle:
VARCHAR2 - tekst o zmiennej długości
CHAR - tekst o stałej długości
NUMBER - dane numeryczne o zmiennej długości
DATE - daty */
/*
YYYY     Full year in numbers
YEAR     Year spelled out 
MM      Two-digit value for month
MONTH    Full name of the month
MON      Three-letter abbreviation of the month
DY      Three-letter abbreviation of the day of the week
DAY     Full name of the day of the week
DD      Numeric day of the month
DDspth   FOURTEENTH
Ddspth   Fourteenth
ddspth      fourteenth
DDD or DD or D      Day of year, month or week
HH24:MI:SS AM   15:45:32 PM
DD "of" MONTH   12 of October
*/
--TO_CHAR(dane, 'format model')
SELECT TO_CHAR(hire_date, 'Month dd, YYYY') FROM employees;
SELECT TO_CHAR(hire_date, 'Month ddth, YYYY') FROM employees;
SELECT TO_CHAR(hire_date, 'Day ddthsp Mon, YYYY') FROM employees;
SELECT TO_CHAR(SYSDATE, 'hh:mm') FROM dual;
SELECT TO_CHAR(SYSDATE, 'hh:mm pm') FROM dual;
SELECT TO_CHAR(SYSDATE, 'hh:mm:ss pm') FROM dual;
SELECT TO_CHAR(salary, '$99,999') AS "Salary" FROM employees;

--TO_NUMBER(character string, 'format model')
SELECT TO_NUMBER('5,320', '9,999') AS "Number" FROM dual;
SELECT last_name, TO_NUMBER(bonus, '9999') AS "Bonus" FROM employees WHERE department_id = 80;

--TO_DATE('character string', 'format model')
SELECT TO_DATE('May10,1989', 'MonDD,YYYY') AS "Convert" FROM DUAL;

--Funkcje związane z wartością NULL
select NULL from dual;
select Null+1 from dual;
select NULL *1 from dual;
--NVL(wyrażenie, które może mieć NULL, jeżeli ma null to czym go zastąpimy)
select NVL(NULL, 'tekst') as funkcja_nvl from dual
SELECT last_name, NVL(commission_pct, 0) FROM employees WHERE department_id IN(80,90);
select employee_id, nvl(bonus, 0) from employees
--NVL2(wyrażenie, które może mieć NULL, jeżeli ma null to czym go zastąpimy, jeżeli nie jest NULL to czym je zastąpimy)
select NVL2(NULL, 'byl null', 'nie bylo nulla') as funkcja_nvl from dual
select NVL2(1, 'byl null', 'nie bylo nulla') as funkcja_nvl from dual
SELECT last_name, salary, NVL2(commission_pct, salary + (salary * commission_pct), salary) AS income
FROM employees WHERE department_id IN(80,90); 
--COALESCE(wartosc1, wartosc2, wartosc3...)-jeeli wartosc 1 jest null to wartosc2, jeeli wartosc 2 jest null to wartosc3 itd
SELECT last_name, COALESCE(commission_pct, salary, 10) 
AS "Comm" FROM employees ORDER BY commission_pct;

Do domu:
1. SQL-fun-poj (4 osoby: 5+4+4+4)


--Wyrażenia warunkowe - odpowiednik if then 
/*
CASE expr WHEN comparison_expr1 THEN return_expr1
[WHEN comparison_expr2 THEN return_expr2
WHEN comparison_exprn THEN return_exprn
ELSE else_expr]
END*/
SELECT last_name, 
CASE department_id
WHEN 90 THEN 'Management'
WHEN 80 THEN 'Sales'
WHEN 60 THEN 'It'
ELSE 'Other dept.'
END AS "Department"
FROM employees;

select employees.*, 
case when manager_ID is NULL THEN 'Szef'
else 'Pracownik' end as struktura 
 from employees

/*
DECODE(columnl|expression, search1, result1 
[, search2, result2,...,]
[, default])
*/
SELECT last_name, 
DECODE(department_id, 
90, 'Management',
80, 'Sales', 
60, 'It',
'Other dept.')
AS "Department"
FROM employees;

select employees.*,
decode(manager_ID, NULL, 'Szef', 'Pracownik') as struktura
from employees


--Funkcje wyrażeń regularnych służą do wyszukiwania danych. Omówimy je pod koniec semestru



--funkcje grupujące (wielowierszowe): SUM, AVG, COUNT, MAX, MIN, STDDEV, VARIANCE
SELECT MAX(salary)
FROM employees;

SELECT AVG(salary) from employees where department_id = 90
SELECT to_char(ROUND(AVG(salary),1), '$99,999.99') from employees where department_id = 90
SELECT MAX(salary), MIN(salary), MIN(employee_id)
FROM employees WHERE department_id = 60;
--funkcje gupujące ignorują NULLe, nie mogą być użyte w klauzuli where

SELECT COUNT(job_id) FROM employees; --tylu mamy pracowników
SELECT COUNT(commission_pct) FROM employees; --tyle jest niepustych wartości commission_pct
SELECT COUNT(*) FROM employees WHERE hire_date < '01-Jan-1996'; --zliczanie wszystkich wierszy

--DISTINCT - unikalne wartości
SELECT DISTINCT job_id FROM employees;
SELECT COUNT (DISTINCT job_id) FROM employees; --zliczenie unikalnych job_id
SELECT DISTINCT job_id, department_id FROM employees; --unikalne wartości z 2 kolumn

SELECT SUM(salary) FROM employees WHERE department_id = 90;
vs
SELECT SUM(DISTINCT salary) FROM employees WHERE department_id = 90;

SELECT AVG(NVL(commission_pct, 0)) FROM employees;
vs
SELECT AVG(commission_pct) FROM employees;


--group by - grupuje bo jakiejs wartosci
SELECT department_id, AVG(salary) FROM employees
GROUP BY department_id ORDER BY department_id; 

SELECT MAX(salary) FROM employees GROUP BY department_id;
SELECT department_id, MAX(salary) FROM employees GROUP BY department_id;
SELECT job_id, last_name, AVG(salary) FROM employees GROUP BY job_id; --błąd
SELECT department_id, MAX(salary) FROM employees WHERE last_name != 'King' GROUP BY department_id;
SELECT max(avg(salary)) FROM employees GROUP by department_id; --zagnieżdzenia

--having
SELECT department_id,MAX(salary) FROM employees
GROUP BY department_id HAVING COUNT(*)>1 ORDER BY department_id; --więcej niż 1 pracownik w departamencie


Do domu:
1. funkcje_grup-1 (3 osoby: 5+4+4)
2. Polimorf-2 (1 osoba)
