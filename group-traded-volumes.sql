SELECT 
	   Year,
	   COUNT(DISTINCT EVENT_ID) AS Races,
	   FORMAT(SUM(PPTRADEDVOL),'0.00') as PreVol,
	   FORMAT(SUM(IPTRADEDVOL),'0.00') as IPvol

  FROM [NRaceHistory].[dbo].[volumes]
  group by YEAR
  order by YEAR

  SELECT 
	   Month,
	   COUNT(DISTINCT EVENT_ID) AS Races,
	   FORMAT(SUM(PPTRADEDVOL),'0.00') as PreVol,
	   FORMAT(SUM(IPTRADEDVOL),'0.00') as IPvol

  FROM [NRaceHistory].[dbo].[volumes]
  group by MONTH
  order by CASE
		  WHEN MONTH = 'January'	THEN 1
		  WHEN MONTH = 'February'	THEN 2
		  WHEN MONTH = 'March'		THEN 3
		  WHEN MONTH = 'April'		THEN 4
		  WHEN MONTH = 'May'		THEN 5
		  WHEN MONTH = 'June'		THEN 6
		  WHEN MONTH = 'July'		THEN 7
		  WHEN MONTH = 'August'		THEN 8
		  WHEN MONTH = 'September'	THEN 9
		  WHEN MONTH = 'October'	THEN 10
		  WHEN MONTH = 'November'	THEN 11
		  WHEN MONTH = 'December'	THEN 12
	END ASC

	SELECT 
	   Day,
	   COUNT(DISTINCT EVENT_ID) AS Races,
	   FORMAT(SUM(PPTRADEDVOL),'0.00') as PreVol,
	   FORMAT(SUM(IPTRADEDVOL),'0.00') as IPvol
  FROM [NRaceHistory].[dbo].[volumes]
  group by DAY
  order by CASE
		  WHEN Day = 'Monday'		THEN 1
		  WHEN Day = 'Tuesday'		THEN 2
		  WHEN Day = 'Wednesday'	THEN 3
		  WHEN Day = 'Thursday'		THEN 4
		  WHEN Day = 'Friday'		THEN 5
		  WHEN Day = 'Saturday'		THEN 6
		  WHEN Day = 'Sunday'		THEN 7
	 END ASC
