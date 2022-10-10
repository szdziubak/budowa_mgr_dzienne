--Transakcje
/*
Współbieżność - jednocześnie mogą być dokonywane wiele odczytów i zapisów.
ACID:
A - Atomowość - transakcje są niepodzielne, albo wykonywane są wszystkie operacje w ramach transakcji albo żadna.
C - Spójność - stan bazy przed i po operacji powinien być spójny - poprawny, wszystkie warunki nałożone na bazę danych muszą być spełnione.
I - Izolacja - transakcje nie powinny wzajemnie przeszkadzać sobie w działaniu. 
D - Trwałość - niepodatność na awarie.
Transakcja to ciąg operacji do wspólnego niepodzielnego wykonania.
*/

--Przykład transakcji - wykonywanie przelewu
COMMIT; --zatwierdź transakcję
ROLLBACK; --wycofaj transakcję
SAVEPOINT savepoint1; --punkty zachowania
ROLLBACK TO SAVEPOINT savepoint1; --wycofujemy transakcje do określonego momentu

--przykład transakcji:
UPDATE employees set salary = salary*1.2;
SAVEPOINT save1;
UPDATE employees set salary = salary*1.1;
select * from employees;
ROLLBACK TO SAVEPOINT save1;
select * from employees;
ROLLBACK; --wycofuje całą transakcje


--więcej np. tutaj: https://mst.mimuw.edu.pl/lecture.php?lecture=bad&part=Ch7