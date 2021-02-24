CREATE view [dbo].[volumes]
AS

Select 

EVENT_ID,
EVENT_DT,
DateName(year, EVENT_DT ) as 'Year',
DateName(month, EVENT_DT) as 'Month',
DateName(weekday, EVENT_DT) as 'Day',
PPTRADEDVOL,
IPTRADEDVOL

from PlaceData
GO
