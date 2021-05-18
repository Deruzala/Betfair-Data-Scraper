# Betfair Data Scraper
A repo to scrape and import Betfair data to SQL Server

Python script to extract Betfair data from https://promo.betfair.com/betfairsp/prices 
and insert to SQL Server


1: [Install Microsoft SQL Server 2019](https://www.microsoft.com/en-gb/sql-server/sql-server-downloads)

2: [Install SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?redirectedfrom=MSDN&view=sql-server-ver15)

3: [Create Database and table for data](https://github.com/Deruzala/Betfair-Data-Scraper/blob/main/Create-dB-and-table.sql)

4: [Scrape the Betfar Promo files and insert to SQLS](https://github.com/Deruzala/Betfair-Data-Scraper/blob/main/Betfair-Data-Scraper.py)

The script is pliable allowing the user to select either UK, IRE, AUS Horse Racing data - both win and place markets 

Run the .py script via your favourite IDE or run via the command line

When prompted enter the start / end date of the data you would like to import

----

- [Returns & Liability](https://github.com/Deruzala/Betfair-Data-Scraper/blob/main/Returns.sql) Creates a view to show back & lay returns including liability at BSP

- [Traded Volumes](https://github.com/Deruzala/Betfair-Data-Scraper/blob/main/TradedVolumes.sql) Creates a view to analyse traded volumes

- [Group Traded Volumes](https://github.com/Deruzala/Betfair-Data-Scraper/blob/main/group-traded-volumes.sql) Breaks down traded volumes by year, month & weekday 
