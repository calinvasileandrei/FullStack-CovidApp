from flask import Flask
import json
import pandas as pd
import ssl
import requests

app = Flask(__name__)
ssl._create_default_https_context = ssl._create_unverified_context

confirmUrl = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
recoveredUrl = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv"
deathsUrl = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"


@app.route('/')
def index():
    return "<h1>COVID19<h1>"

#ITALY ROUTE

@app.route('/Italy/list',methods=['GET'])
def listItaly():
    url = 'https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni.json'
    df = requests.get(url)
    data = df.json()
    dataList = []

    for row in data[-21:]:
        try:
            dataList.append({"Province/State": row['denominazione_regione'], "Country/Region": "Italy", "Lat": row["lat"],"Long": row["long"], "Confirmed": row["totale_casi"],"Deaths": row["deceduti"] ,"Recovered": row["dimessi_guariti"]})
        except:
            print("error")
            continue;

    if(dataList != None):
        return json.dumps(dataList)
    else:
        return json.dumps({"Data":"None"})


#ALL ROUTE
@app.route('/map/<string:province>',methods=['GET'])
def map(province):
    df = pd.read_csv(confirmUrl)
    dataList = []
    lat=""
    long = ""
    _country= ""
    _province = ""

    for index, row in df.iterrows():
        if (province == row['Province/State']):
            lat = row["Lat"]
            long = row["Long"]
            _province = row['Province/State']
            _country = row["Country/Region"]
            break
        elif(province == row["Country/Region"]):
            lat = row["Lat"]
            long = row["Long"]
            _province = row["Country/Region"]
            _country = row["Country/Region"]
            break



    if(lat != "" and long != ""):
        return json.dumps([{"Province/State":_province},{"Country/Region":_country},{"Lat":lat},{"Long":long}])
    else:
        return json.dumps({"Data":"None"})


@app.route('/list/confirmed/<string:country>',methods=['GET'])
def listConfirmedInput(country):
    df = pd.read_csv(confirmUrl)
    dataList = []

    for index, row in df.iterrows():
        if(row["Country/Region"] == country):
            try:
                if(pd.isnull(row['Province/State'])):
                    dataList.append({"Province/State": row["Country/Region"], "Country/Region": row["Country/Region"], "Lat": row["Lat"],"Long": row["Long"], "Confirmed": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
                else:
                    dataList.append({"Province/State": row['Province/State'], "Country/Region": row["Country/Region"], "Lat": row["Lat"],"Long": row["Long"], "Confirmed": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
            except:
                continue;

    if(dataList != None):
        return json.dumps(dataList)
    else:
        return json.dumps({"Data":"None"})


@app.route('/list/deaths/<string:country>',methods=['GET'])
def listDeathsInput(country):
    df = pd.read_csv(deathsUrl)
    dataList = []

    for index, row in df.iterrows():
        if(row["Country/Region"] == country):
            try:
                if(pd.isnull(row['Province/State'])):
                    dataList.append({"Province/State": row["Country/Region"], "Country/Region": row["Country/Region"], "Lat": row["Lat"],"Long": row["Long"], "Deaths": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
                else:
                    dataList.append({"Province/State": row['Province/State'], "Country/Region": row["Country/Region"], "Lat": row["Lat"],"Long": row["Long"], "Deaths": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
            except:
                continue;

    if(dataList != None):
        return json.dumps(dataList)
    else:
        return json.dumps({"Data":"None"})


@app.route('/list/recovered/<string:country>',methods=['GET'])
def listRecoveredInput(country):
    df = pd.read_csv(recoveredUrl)
    dataList = []

    for index, row in df.iterrows():
        if(row["Country/Region"] == country):
            try:
                if(pd.isnull(row['Province/State'])):
                    dataList.append({"Province/State": row["Country/Region"], "Country/Region": row["Country/Region"], "Lat": row["Lat"],"Long": row["Long"], "Recovered": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
                else:
                    dataList.append({"Province/State": row['Province/State'], "Country/Region": row["Country/Region"], "Lat": row["Lat"],"Long": row["Long"], "Recovered": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
            except:
                continue;

    if(dataList != None):
        return json.dumps(dataList)
    else:
        return json.dumps({"Data":"None"})


@app.route('/list/confirmed')
def listConfirmed():
    df = pd.read_csv(confirmUrl)
    dataList = []
    for index, row in df.iterrows():
        try:
            if(pd.isnull(row['Province/State'])):
                dataList.append({"Province/State": row["Country/Region"], "Country/Region": row["Country/Region"], "Lat": row["Lat"],"Long": row["Long"], "Confirmed": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
            else:
                dataList.append({"Province/State": row['Province/State'], "Country/Region": row["Country/Region"], "Lat": row["Lat"],"Long": row["Long"], "Confirmed": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })


        except:
            continue;

    if(dataList != None):
        return json.dumps(dataList)
    else:
        return json.dumps({"Data":"None"})


@app.route('/list/recovered')
def listRecovered():
    df = pd.read_csv(recoveredUrl)
    dataList = []
    for index, row in df.iterrows():
        try:
            if (pd.isnull(row['Province/State'])):
                dataList.append({"Province/State": row["Country/Region"], "Country/Region": row["Country/Region"],
                                 "Lat": row["Lat"], "Long": row["Long"], "Recovered": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
            else:
                dataList.append({"Province/State": row['Province/State'], "Country/Region": row["Country/Region"],
                                 "Lat": row["Lat"], "Long": row["Long"], "Recovered": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })


        except:
            continue;

    if (dataList != None):
        return json.dumps(dataList)
    else:
        return json.dumps({"Data": "None"})


@app.route('/list/deaths')
def listDeaths():
    df = pd.read_csv(deathsUrl)
    dataList = []
    for index, row in df.iterrows():
        try:
            if (pd.isnull(row['Province/State'])):
                dataList.append({"Province/State": row["Country/Region"], "Country/Region": row["Country/Region"],
                                 "Lat": row["Lat"], "Long": row["Long"], "Deaths": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })
            else:
                dataList.append({"Province/State": row['Province/State'], "Country/Region": row["Country/Region"],
                                 "Lat": row["Lat"], "Long": row["Long"], "Deaths": row[len(df.columns) - 1] if not pd.isnull(row[len(df.columns) - 1]) else row[len(df.columns) - 2]  })


        except:
            continue;

    if (dataList != None):
        return json.dumps(dataList)
    else:
        return json.dumps({"Data": "None"})
















@app.route('/overall')
def overall():

    dfConfirmed = pd.read_csv(confirmUrl)
    dfDeaths= pd.read_csv(deathsUrl)
    dfRecovered= pd.read_csv(recoveredUrl)

    totalConfirmed = 0
    totalRecovered = 0
    totalDeaths = 0

    for index, row1 in dfDeaths.iterrows():
        totalDeaths += row1[len(dfDeaths.columns) - 1] if not pd.isnull(row1[len(dfDeaths.columns) - 1]) else row1[len(dfDeaths.columns) - 2]

    for index, row2 in dfRecovered.iterrows():
        totalRecovered += row2[len(dfRecovered.columns) - 1] if not pd.isnull(row2[len(dfRecovered.columns) - 1]) else row2[len(dfRecovered.columns) - 2]

    for index, row in dfConfirmed.iterrows():
        totalConfirmed += row[len(dfConfirmed.columns) - 1] if not pd.isnull(row[len(dfConfirmed.columns) - 1]) else row[len(dfConfirmed.columns) - 2]

    return json.dumps([{"Confirmed":totalConfirmed},{"Deaths":totalDeaths},{"Recovered":totalRecovered}])



@app.route('/overall/<string:country>',methods=['GET'])
def overallCountry(country):

    dfConfirmed = pd.read_csv(confirmUrl)
    dfDeaths= pd.read_csv(deathsUrl)
    dfRecovered= pd.read_csv(recoveredUrl)

    totalConfirmed = 0
    totalRecovered = 0
    totalDeaths = 0

    for index, row in dfConfirmed.iterrows():
        if(row["Country/Region"] == country):
            totalConfirmed += row[len(dfConfirmed.columns) - 1] if not pd.isnull(row[len(dfConfirmed.columns) - 1]) else row[len(dfConfirmed.columns) - 2]

    for index, row1 in dfDeaths.iterrows():
        if(row1["Country/Region"]== country):
            totalDeaths += row1[len(dfDeaths.columns) - 1] if not pd.isnull(row1[len(dfDeaths.columns) - 1]) else row1[len(dfDeaths.columns) - 2]

    for index, row2 in dfRecovered.iterrows():
        if(row2["Country/Region"] == country):
            totalRecovered += row2[len(dfRecovered.columns) - 1] if not pd.isnull(row2[len(dfRecovered.columns) - 1]) else row2[len(dfRecovered.columns) - 2]



    return json.dumps([{"Confirmed":totalConfirmed},{"Deaths":totalDeaths},{"Recovered":totalRecovered}])


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=False)