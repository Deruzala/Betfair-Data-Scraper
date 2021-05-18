CREATE VIEW [dbo.Returns]
AS

SELECT
	SELECTION_NAME
	BSP,
	
	-- A 'case expression' can be used for a conditional statement
	(CASE WHEN WIN_LOSE = 1 THEN (BSP - 1.0) ELSE -1.0 END) AS Return,
	(CASE WHEN place = 1 THEN (BSP - 1.0) * .02 ELSE 0 END) AS backCommission,
	(CASE WHEN place = 1 THEN (BSP - 1.0) - ((BFSP - 1.0) * .02) ELSE -1.0 END) AS netReturn,
	
	-- The 'format' function restricts decimal places
	FORMAT(1.0 * (BSP-1.0),'0.00') AS LayLiability,
	
	-- An 'IIF' function can also be used for conditional statements
    	IIF(WIN_LOSE = 1, (1.0 * (BFSP-1.0) * -1.0), 1.0) AS layReturn,
	IIF(WIN_LOSE = 1, 0, 0.20 END) AS layCommission,
	IIF(WIN_LOSE = 1, (1.0 * (BFSP-1.0) * -1), 0.98) AS netLayReturn
	

FROM PlaceData
