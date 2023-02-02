DECLARE  @Start datetime
		 ,@End  datetime
DECLARE @AllDates table
		(Date datetime)

SELECT @Start = '1980-01-01', @End = '2015-12-31';

WITH Nbrs_3( n ) AS ( SELECT 1 UNION SELECT 0 ),
     Nbrs_2( n ) AS ( SELECT 1 FROM Nbrs_3 n1 CROSS JOIN Nbrs_3 n2 ),
     Nbrs_1( n ) AS ( SELECT 1 FROM Nbrs_2 n1 CROSS JOIN Nbrs_2 n2 ),
     Nbrs_0( n ) AS ( SELECT 1 FROM Nbrs_1 n1 CROSS JOIN Nbrs_1 n2 ),
     Nbrs  ( n ) AS ( SELECT 1 FROM Nbrs_0 n1 CROSS JOIN Nbrs_0 n2 )

	SELECT @Start+n-1 as "Data", CAST(YEAR(@Start+n-1) AS VARCHAR(4)) as "Rok", 
	
case month(@Start+n-1)
WHEN 1 THEN 'JANUARY'
WHEN 2 THEN 'FEBRUARY'
WHEN 3 THEN 'MARCH'
WHEN 4 THEN 'APRIL'
WHEN 5 THEN 'MAY'
WHEN 6 THEN 'JUNE'
WHEN 7 THEN 'JULY'
WHEN 8 THEN 'AUGUST'
WHEN 9 THEN 'SEPTEMBER'
WHEN 10 THEN 'OCTOBER'
WHEN 11 THEN 'NOVEMBER'
WHEN 12 THEN 'DECEMBER'
END as "Miesi¹c", DATEPART("dw", @Start+n-1) as "Dzieñ",

case month(@Start+n-1)
WHEN 1 THEN 'WINTER'
WHEN 2 THEN 'WINTER'
WHEN 3 THEN 'SPRING'
WHEN 4 THEN 'SPRING'
WHEN 5 THEN 'SPRING'
WHEN 6 THEN 'SUMMER'
WHEN 7 THEN 'SUMMER'
WHEN 8 THEN 'SUMMER'
WHEN 9 THEN 'AUTUMN'
WHEN 10 THEN 'AUTUMN'
WHEN 11 THEN 'AUTUMN'
WHEN 12 THEN 'WINTER'
END as "Pora_roku", 

CASE DATEPART("dw", @Start+n-1)
WHEN 1 THEN 'Sunday'
WHEN 2 THEN 'Monday'
WHEN 3 THEN 'Tuesday'
WHEN 4 THEN 'Wednesday'
WHEN 5 THEN 'Thursday'
WHEN 6 THEN 'Friday'
WHEN 7 THEN  'Saturday'
END as "Dzieñ_tygodnia"
		FROM ( SELECT ROW_NUMBER() OVER (ORDER BY n)
			FROM Nbrs ) D ( n )
	WHERE n <= DATEDIFF(day,@Start,@End)+1 ;