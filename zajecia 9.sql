/*Tworzenie tabeli
CREATE TABLE nazwa_tabeli (
    nazwa_kolumny_1 typ [CONSTRAINT definicja_więzów DEFAULT wyrażenie domyślne],
    nazwa_kolumny_2 typ [CONSTRAINT definicja_więzów DEFAULT wyrażenie domyślne],
)*/

CREATE TABLE employees_sa_rep (
    employee_id integer,
    first_name varchar2(30),
    last_name varchar2(32)
)

/*typy danych:
    varchar2(n)
    integer
    char
    date*/


/*więzy:
    CHECK - wartość w kolumnie musi spełniać określony warunek,
    NOT NULL - wartość w kolumnie musi być niepusta (not NULL),
    PRIMARY KEY - klucz główny tabeli, składający się z jednej lub więcej kolumn,
    FOREIGN KEY - klucz obcy tabeli,
    UNIQUE - w kolumnie muszą być składowane tylko unikatowe wartości
*/

CREATE TABLE employees_sa_rep (
    employee_id integer PRIMARY KEY,
    first_name varchar2(30),
    last_name varchar2(32),
    salary integer CONSTRAINT check_salary CHECK (salary > 0),
    department_id number(5) CONSTRAINT fk_department_id REFERENCES departments(department_id));

--modyfikacja tabeli
ALTER TABLE nazwa tabeli ADD/MODIFY/DROP/ADD CONSTRAINT

ALTER TABLE employees_sa_rep ADD staz INTEGER DEFAULT 0; --nowa kolumna
ALTER TABLE employees_sa_rep MODIFY salary number(10); --zmiana typu
ALTER TABLE employees_sa_rep ADD CONSTRAINT last_name_check CHECK (length(last_name)>=2) --dodawanie więzłów
ALTER TABLE employees_sa_rep DROP CONSTRAINT last_name_check --usuwanie więzłów
ALTER TABLE employees_sa_rep DISABLE CONSTRAINT last_name_check; --wyłączanie więzłów
ALTER TABLE employees_sa_rep ENABLE CONSTRAINT last_name_check; --włączanie więzłów

--usuwanie tabeli
DROP TABLE employees_sa_rep



/*uprawnienia systemowe
CREATE SESSION
CREATE SEQUENCE
CREATE SYNONIM
CREATE TABLE - w schemacie użytkownika
CREATE ANY TABLE - w dowolnym schemacie
DROP TABLE DROP ANY TABLE
CREATE PROCEDURE
EXECUTE ANY PROCEDURE
CREATE USER
DROP USER
CREATE VIEW*/

--aby nadać wiele uprawnień z możliwością ich dalszego rozpowszechniania (WITH ADMIN OPTION)
GRANT CREATE SEQUENCE, CREATE TABLE, CREATE VIEW to PL_A909_SQL_S99 with ADMIN OPTION; 

CREATE USER nazwa_uzytkownika identified by hasło.
DROP USER PL_A909_SQL_S99;
REVOKE CREATE TABLE FROM PL_A909_SQL_S99;

/*uprawnienia obiektowe
SELECT
INSERT
UPDATE
DELETE
EXECUTE
ALTER 
ALL
*/
GRANT SELECT, UPDATE on employees TO PL_A909_SQL_S99;
GRANT ALL on employees TO PL_A909_SQL_S99;
GRANT SELECT, UPDATE on employees TO PL_A909_SQL_S99 WITH GRANT OPTION; --with grant option - można dalej przekazywać uprawnienia
REVOKE UPDATE ON employees FROM PL_A909_SQL_S99;


/*Data Dictionary
to zbiór tabel o obiektach bazy danych czyli tabelach, kolumnach, użytkownikach itd. Innymi słowy to metadane bazy. Zawiera ponad 500 tabel.

Jak wyszukiwać pożądane tabele?
Musimy znaleźć tabele, która przypomina tą, która zawiera szukane przez nas informacje.
Na przykład szumay uprawnień systemowych:
1. select *  from dict where table_name like '%PRIV%'; 
2. Wybieramy user_sys_privs;
3. desc user_sys_privs; --wybieramy tabele
4. select privilege from user_sys_privs;

user_objects - obiekty użytkownika - indeksy, tabele, sekwencje itd
all_objects - wszystkie obiekty, nie tylko użytkownika
user_tables - tabele użytkownika 
user_views - perspektywy użytkownika
user_synonyms - synonimy użytkownika
*/

select * from all_objects

select * from dict where lower(table_name) like '%sequence%'
select * from all_sequences