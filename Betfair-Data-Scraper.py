import os
import requests
import pypyodbc as odbc             #pip install pypyodbc
from urllib.parse import urljoin
from bs4 import BeautifulSoup       #pip install beautifulsoup4
import pandas as pd                 #pip install pandas


# Add your settings
DRIVER = 'SQL Server'
SERVER_NAME = 'YOUR-SERVER-NAME'
DATABASE_NAME = 'BetfairData'

# Filters csv URL prefixes
# Currently looks for UK & IE 'place' files
# Can switch out to look for 'win' files

def matc(string):
    if 'dwbfpricesukplace' in string or 'dwbfpricesireplace' in string:
        return True
    return False

url = 'https://promo.betfair.com/betfairsp/prices'

# Downloads csv files to the folder below and reimports to SQL Server
# Add your preferred location to download the csv

folder_location = r'C:\betfairdata'
if not os.path.exists(folder_location):os.mkdir(folder_location)

response = requests.get(url)
soup= BeautifulSoup(response.text, "html.parser")


def connection_string(driver, server_name, database_name):
    conn_string = f"""
        DRIVER={{{driver}}};
        SERVER={server_name};
        DATABASE={database_name};
        Trust_Connection=yes;
    """
    return conn_string

try:
    conn = odbc.connect(connection_string(DRIVER, SERVER_NAME, DATABASE_NAME))
except odbc.DatabaseError as e:
    print("Database error")
    print(str(e.value[1]))
except odbc.Error as e:
    print("Connection Error:")
    print(str(e.value[1]))

cursor = conn.cursor()

# Include your SQL tablename
sql_insert ='''
    INSERT INTO PlaceData
    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
'''


# Dates are converted to int. eg 05-01-2010converts to 20100105
Date = input("Enter the Start DATE (DD-MM-YYYY) : ")                      #Start Date
Date = "".join(Date.split('-'))
Date = int(Date[4:] + Date[2:4] + Date[:2])

EndDate = input("Enter End DATE (DD-MM-YYYY) : ")
EndDate = "".join(EndDate.split('-'))                                     #End Date
EndDate = int(EndDate[4:] + EndDate[2:4] + EndDate[:2])

for link in soup.select("a[href$='.csv']"):

    # Fdate is extracted from the name of the csv file
    Fdate = str(link['href'])[-12:-4]
    Fdate = "".join(Fdate.split('-'))
    Fdate = int(Fdate[4:] + Fdate[2:4] + Fdate[:2])

    # Checking the condition                                                                    Condition
    if matc(link['href']) and Fdate <= EndDate and Fdate >= Date:                               #Between StartDate and EndDate

        filename = os.path.join(folder_location,link['href'].split('/')[-1])

        with open(filename, 'wb') as f:
            f.write(requests.get(urljoin(url,link['href'])).content)

        df = pd.read_csv(filename)
        rc = df.shape[0]

        for i in range(rc):
            df['EVENT_DT'].iloc[i] = df['EVENT_DT'].iloc[i] + ":00"

        df['EVENT_DT'] = pd.to_datetime(df['EVENT_DT']).dt.strftime('%Y-%m-%d %H:%M:%S')
        df.fillna(0, inplace=True)
        records = df.values.tolist()


        try:

            cursor.executemany(sql_insert, records)
            cursor.commit();
        except Exception as e:
            cursor.rollback()
            print(str(e))
        finally:
            print("Done")

        # Cleans temporarily downloaded CSVs
        os.remove(filename)


print("ALL FILES TRANSFERED")
cursor.close()
conn.close()
