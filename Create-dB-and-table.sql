CREATE DATABASE BetfairData
GO

USE BetfairData
GO

CREATE TABLE PlaceData

(
  EVENT_ID bigint,
  MENU_HINT varchar(500),
  EVENT_NAME varchar(500),
  EVENT_DT datetime2(0),
  SELECTION_ID bigint,
  SELECTION_NAME varchar(500),
  WIN_LOSE bigint,
  BSP float,
  PPWAP float,
  MORNINGWAP float,
  PPMAX float,
  PPMIN float,
  IPMAX float,
  IPMIN float,
  MORNINGTRADEDVOL float,
  PPTRADEDVOL float,
  IPTRADEDVOL float,
);
