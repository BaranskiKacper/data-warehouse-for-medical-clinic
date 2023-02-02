USE CLINICMASTER

BULK INSERT LEKARZ FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab05\sources\doctors1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT PACJENT FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab05\sources\patients1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT REJESTRATOR_MEDYCZNY FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab05\sources\ward_clerks1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT REJESTRACJA FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab05\sources\regs1.bulk' WITH (FIELDTERMINATOR='|')
BULK INSERT WIZYTA FROM 'D:\studia\V_sem\Hurtownie_Danych\laby\lab05\sources\visits1.bulk' WITH (FIELDTERMINATOR='|')

SELECT * FROM LEKARZ 
SELECT * FROM PACJENT WHERE (LEKARZ_RODZINNY > 0 AND LEKARZ_RODZINNY <= 300)
SELECT * FROM REJESTRATOR_MEDYCZNY
SELECT * FROM REJESTRACJA
SELECT * FROM WIZYTA