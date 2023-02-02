USE LAB5

CREATE TABLE Przychodnia(
	ID_przychodni INT IDENTITY(1,1) PRIMARY KEY,
	Miasto NVARCHAR(30) NOT NULL,
	Kod_pocztowy NVARCHAR(6) NOT NULL,
	Ulica NVARCHAR(60) NOT NULL,
	Nr_budynku NVARCHAR(5) NOT NULL,
	Wielkość_przychodni NVARCHAR(20) NOT NULL,
	CONSTRAINT spr_Wielkość_przychodni CHECK ( Wielkość_przychodni IN('SMALL', 'MEDIUM', 'BIG'))
);
	
CREATE TABLE Pacjent(
    ID_pacjenta INT IDENTITY(1,1) PRIMARY KEY,
    ImieINazwisko VARCHAR(50) NOT NULL,
	PESEL CHAR(11) CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
	UNIQUE(PESEL)
    );

CREATE TABLE Rejestrator_medyczny(
    ID_rejestratora INT IDENTITY(1,1) PRIMARY KEY,
	ImieINazwisko VARCHAR(50) NOT NULL,
	PESEL CHAR(11) CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
    Staz CHAR(20) NOT NULL,
	UNIQUE(PESEL)
    );

CREATE TABLE Lekarz(
    ID_lekarza INT IDENTITY(1,1) PRIMARY KEY,
	ID_przychodni INT REFERENCES Przychodnia(ID_przychodni) NOT NULL,
    ImieINazwisko VARCHAR(50) NOT NULL,
	PESEL CHAR(11) CHECK(PESEL LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
	Specjalizacja VARCHAR(50) NOT NULL,
    CONSTRAINT spr_Specjalizacja CHECK ( Specjalizacja IN ('CARDIOLOGIST', 'ANESTHESIOLOGIST', 'INTENSIVIST',
														'ORTHOPEDIC SURGEON', 'DERMATOLOGIST','ONCOLOGIST',
														'UROLOGIST','RHINOLOGIST','PSYCHIATRIST','RADIOLOGIST',
														'SURGEON', 'PATHOLOGIST','GYNECOLOGIST', 'PULMONOLOGIST',
														'RHEUMATOLOGIST', 'DENTIST', 'FAMILY DOCTOR', 'OPTOMETRIST')),
	UNIQUE(PESEL)
    );
	
CREATE TABLE Data_(
	ID_daty INT IDENTITY(1,1) PRIMARY KEY,
	Data_ Date NOT NULL,
	Rok INT NOT NULL,
	Miesiąc VARCHAR(20) NOT NULL,
	CONSTRAINT spr_Miesiąc CHECK(Miesiąc IN('JANUARY', 'FEBRUARY','MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER','NOVEMBER', 'DECEMBER')),
	Dzień INT NOT NULL,
	Pora_roku VARCHAR(20) NOT NULL,
	CONSTRAINT spr_Pora_roku CHECK ( Pora_roku IN('SPRING', 'SUMMER', 'AUTUMN',  'WINTER')),
	Dzień_tygodnia VARCHAR(20) NOT NULL,
	CONSTRAINT spr_Dzień_tygodnia CHECK (Dzień_tygodnia IN('SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY'))
);

CREATE TABLE Czas(
	ID_czasu INT IDENTITY(1,1) PRIMARY KEY,
	Godzina INT NOT NULL,
	Pora_dnia VARCHAR(20) NOT NULL
);


CREATE TABLE Śmieci(
	ID_śmieci INT IDENTITY(1,1) PRIMARY KEY,
	Rodzaj_wizyty VARCHAR(20) NOT NULL,
	CONSTRAINT Rodzaj_wizyty CHECK ( Rodzaj_wizyty IN ('REMOTE','STATIONARY')),
	Opinia VARCHAR(20) NOT NULL,	
	CONSTRAINT spr_Opinia CHECK (Opinia IN('VERY SATISFIED','SATISFIED','NEUTRAL','DISSATISFIED','VERY DISSATISFIED'))
);

CREATE TABLE Wizyta(
	ID_rejestratora INT REFERENCES Rejestrator_medyczny(ID_rejestratora) NOT NULL,
	ID_pacjenta INT REFERENCES Pacjent(ID_pacjenta) NOT NULL,
    ID_lekarza INT REFERENCES Lekarz(ID_lekarza) NOT NULL,
    ID_daty_wizyty INT REFERENCES Data_(ID_daty) NOT NULL,
    ID_daty_rejestracji INT REFERENCES Data_(ID_daty) NOT NULL,
	ID_czasu_wizyty INT REFERENCES Czas(ID_czasu) NOT NULL,
	ID_czasu_rejestracji INT REFERENCES Czas(ID_czasu) NOT NULL,
	ID_śmieci INT REFERENCES Śmieci(ID_śmieci) NOT NULL,
	Czas_oczekiwania INT NOT NULL
    );