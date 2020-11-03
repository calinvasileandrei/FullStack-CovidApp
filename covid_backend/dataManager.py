import json
import pandas as pd
import ssl
import requests

ssl._create_default_https_context = ssl._create_unverified_context

urlConfirmed = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv'
urlDeaths = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv'
urlRecovered = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv'

#overall data
confirmed = 0
deaths= 0
recovered = 0

dataList = []

dfConfirmed = pd.read_csv(urlConfirmed)
dfRecovered = pd.read_csv(urlRecovered)
dfDeaths = pd.read_csv(urlDeaths)

for index, row in dfConfirmed.iterrows():
    try:
        if (pd.isnull(row['Province/State'])):
            dataList.append(
                {"Province": row["Country/Region"], "Country": row["Country/Region"], "Lat": row["Lat"],
                 "Long": row["Long"],
                 "Confirmed": row[len(dfConfirmed.columns) - 1] if not pd.isnull(row[len(dfConfirmed.columns) - 1]) else row[len(dfConfirmed.columns) - 2]
                 })
            confirmed+=row[len(dfConfirmed.columns) - 1] if not pd.isnull(row[len(dfConfirmed.columns) - 1]) else row[len(dfConfirmed.columns) - 2]
        else:
            dataList.append(
                {"Province": row['Province/State'], "Country": row["Country/Region"], "Lat": row["Lat"],
                 "Long": row["Long"],
                 "Confirmed": row[len(dfConfirmed.columns) - 1] if not pd.isnull(row[len(dfConfirmed.columns) - 1]) else row[
                     len(dfConfirmed.columns) - 2]})
            confirmed+=row[len(dfConfirmed.columns) - 1] if not pd.isnull(row[len(dfConfirmed.columns) - 1]) else row[len(dfConfirmed.columns) - 2]

    except:
        continue;


for index, row in dfRecovered.iterrows():
    print(index)
    try:
        if(row["Province/State"] == dataList[index]["Province"]):
            dataList[index].update( {"Recovered": row[len(dfRecovered.columns) - 1] if not pd.isnull(row[len(dfRecovered.columns) - 1]) else row[len(dfRecovered.columns) - 2]})
            recovered+=row[len(dfRecovered.columns) - 1] if not pd.isnull(row[len(dfRecovered.columns) - 1]) else row[len(dfRecovered.columns) - 2]
        elif (row["Country/Region"] == dataList[index]["Country"]):
            dataList[index].update( {"Recovered": row[len(dfRecovered.columns) - 1] if not pd.isnull(row[len(dfRecovered.columns) - 1]) else row[len(dfRecovered.columns) - 2]})
            recovered+=row[len(dfRecovered.columns) - 1] if not pd.isnull(row[len(dfRecovered.columns) - 1]) else row[len(dfRecovered.columns) - 2]
            print(row["Country/Region"], " | ", dataList[index]["Province"])
    except:
        continue;


for index, row in dfDeaths.iterrows():
    print(index)
    try:
        if(row["Province/State"] == dataList[index]["Province"]):
            dataList[index].update( {"Deaths": row[len(dfDeaths.columns) - 1] if not pd.isnull(row[len(dfDeaths.columns) - 1]) else row[len(dfDeaths.columns) - 2]})
            deaths += row[len(dfDeaths.columns) - 1] if not pd.isnull(row[len(dfDeaths.columns) - 1]) else row[len(dfDeaths.columns) - 2]
        elif (row["Country/Region"] == dataList[index]["Country"]):
            dataList[index].update( {"Deaths": row[len(dfDeaths.columns) - 1] if not pd.isnull(row[len(dfDeaths.columns) - 1]) else row[len(dfDeaths.columns) - 2]})
            deaths += row[len(dfDeaths.columns) - 1] if not pd.isnull(row[len(dfDeaths.columns) - 1]) else row[len(dfDeaths.columns) - 2]
            print(row["Country/Region"], " | ", dataList[index]["Province"])
    except:
        continue;



print(dataList)
print("Confirmed:",confirmed)
print("Deaths:",deaths)
print("Recovered:",recovered)


newdata = {"Overall":[{"Confirmed":confirmed},{"Deaths":deaths},{"Recovered":recovered}],}





'''
if (dataList != None):
    return json.dumps(dataList)
else:
    return json.dumps({"Data": "None"})

'''
