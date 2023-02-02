USE PRZYCHODNIA

/* the path must be updated, remeber FIELDTERMINATOR defines how data in dane.bulk are separated*/

/* T0 - T1 */
BULK INSERT OSOBA FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\people1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT LEKARZ FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\doctors1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT PACJENT FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\patients1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT REJESTRATOR_MEDYCZNY FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\ward_clerks1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT REJESTRACJA FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\regs1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT WIZYTA FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\visits1.bulk' WITH (FIELDTERMINATOR='|')

/* T0 - T2 */
BULK INSERT OSOBA FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\people2.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT REJESTRATOR_MEDYCZNY FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\ward_clerks2.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT WIZYTA FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\visits2.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT LEKARZ FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\doctors2.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT REJESTRACJA FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\regs2.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT PACJENT FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab02\sql\patients2.bulk' WITH (FIELDTERMINATOR='|')



UPDATE OSOBA
SET NAZWISKO = 'NOWAK'
WHERE ID_OSOBY IN ( SELECT MIN(ID_OSOBY) AS ID
                    FROM OSOBA
                  ) 

UPDATE REJESTRATOR_MEDYCZNY
SET STAZ = 2
WHERE ID_REJESTRATORA IN ( SELECT MIN(ID_REJESTRATORA) AS ID
                                      FROM REJESTRATOR_MEDYCZNY
                                     )

UPDATE WIZYTA
SET RODZAJ_WIZYTY = 'REMOTE'
WHERE CZAS_TRWANIA_WIZYTY = 10


UPDATE LEKARZ
SET SPECJALIZACJA = 'CARDIOLOGIST'
WHERE ID_LEKARZA IN ( SELECT MIN(ID_LEKARZA) AS ID
                      FROM LEKARZ
                      )

UPDATE REJESTRACJA
SET CZAS_TRWANIA_REJESTRACJI = CZAS_TRWANIA_REJESTRACJI - 1
WHERE ID_REJESTRATORA IN ( SELECT MIN(ID_REJESTRATORA) AS ID
                                      FROM REJESTRATOR_MEDYCZNY
                                     )

UPDATE PACJENT
SET LEKARZ_RODZINNY = 1
WHERE ID_PACJENTA IN ( SELECT MIN(ID_PACJENTA) AS ID
                       FROM PACJENT
                      )