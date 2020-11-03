import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covid19/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:covid19/credentials.dart' as credentials;

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> _markerList = new List<Marker>();

  @override
  void initState() {
    super.initState();
    fetchMarks().then((value) {
      setState(() {
        _markerList.addAll(value);
      });
    });
  }

  Future fetchMarks() async {
 
    var url =
        credentials.urlApiBackend+'/list/confirmed'; 
    var response = await http.get(url);

    var markers = List<Marker>();
    if (response.statusCode == 200) {
      var reportsJson = json.decode(response.body);

      for (var data in reportsJson) {
        if (data["Confirmed"] > 0) {
          Marker newMark = new Marker(
              width: returnSize(data["Confirmed"])  ,
              height: returnSize(data["Confirmed"]),
              point: new LatLng(data["Lat"], data['Long']),
              builder: (context) => GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildDialog(
                        data["Province/State"],
                        data["Country/Region"],
                        data["Confirmed"]),
                  );
                },
                child: new Container(
                        alignment: Alignment.center,
                        width: returnSize(data["Confirmed"]),
                        height: returnSize(data["Confirmed"]),
                        child: Icon(Icons.adjust,color: returnColor(data["Confirmed"]),size:returnSize(data["Confirmed"] )),
              )));
          markers.add(newMark);
        }
      }
    }

    return markers;
  }

  returnSize(_value){
    var value = _value.round();

    if(value <= 5000){
      return 25.0;
    }else if(value <= 10000){
      return 35.0;
    }else if(value <= 20000){
      return 40.0;
    }else if(value <= 50000){
      return 50.0;
    }else if(value <= 100000){
      return 60.0;
    }else if(value > 100000){
      return 70.0;
    }

  }

  returnColor(_value){
    var value = _value.round();

    if(value <= 500){
      return Color(0xffFFECB3);
    }if(value <= 5000){
      return Color(0xffFFC107);
    }else if(value <= 10000){
      return Color(0xffFFA726);
    }else if(value <= 20000){
      return Color(0xffFF5722);
    }else if(value <= 50000){
      return Color(0xfff44336);
    }else if(value <= 100000){
      return Color(0xffd32f2f);
    }else if(value > 100000){
      return Color(0xffb71c1c);
    }  }

  Widget _buildDialog(_city, _country, _confirmed) {
    return new Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: ScreenUtil().setWidth(600),
        height: ScreenUtil().setWidth(450),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: covidTheme.primaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.all(radiusButtons),
          //boxShadow: shadowsPrimaryColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              _city.toString(),
              style: mainWTextStyle,
            ),
            Text(
              "Confirmed: " + _confirmed.toString(),
              style: confirmedListTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: covidTheme.primaryColor,
      child: new FlutterMap(
        options: new MapOptions(
          zoom: 3.5,
          minZoom: 3,
          maxZoom: 6,
          center: new LatLng(41.9, 12.4),
          interactive: true,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate:
                  credentials.urlTemplateMapbox,
              additionalOptions: {
                'accessToken':
                    credentials.urlApiBackend,
                'id': credentials.idAccescTokenMapbox , 
              }),
          new MarkerLayerOptions(markers: _markerList)
        ],
      ),
    );
  }
}
