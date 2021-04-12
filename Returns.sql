CREATE VIEW [dbo.Returns]
AS

SELECT
	SELECTION_NAME
	BSP,
	CASE WHEN WIN_LOSE = 1 THEN (BSP - 1.0) ELSE -1 END AS Profit,
	FORMAT(1.0 * (BSP-1.0),'0.00') AS LayLiability,
    	FORMAT(IIF(WIN_LOSE = 1, (1.0 * (BSP-1.0) * -1), 1),'0.00') AS LayReturn

FROM PlaceData
