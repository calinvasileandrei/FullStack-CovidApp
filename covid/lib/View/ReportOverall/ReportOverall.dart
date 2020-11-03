import 'dart:async';
import 'dart:developer';

import 'package:covid19/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:covid19/View/ReportList/ReportListBloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:covid19/credentials.dart' as credentials;

class ReportOverall extends StatefulWidget {
  @override
  _ReportOverallState createState() => _ReportOverallState();
}

class _ReportOverallState extends State<ReportOverall> with TickerProviderStateMixin {
  Timer timer;
  int typeSelected=0;
  double _scale=0;
  double _scale1=0;
  double _scale2=0;

  AnimationController _controller;
  AnimationController _controllerDeaths;
  AnimationController _controllerRecovered;


  void initState() {
    // TODO: implement initState

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
      setState(() {});
    });

    _controllerDeaths = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
      setState(() {});
    });

    _controllerRecovered = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
      setState(() {});
    });

    super.initState();
    fetchReports();




  }


  @override
  void dispose() {
    _controller.dispose();
    _controllerDeaths.dispose();
    _controllerRecovered.dispose();
    super.dispose();

  }

  Future<void> fetchReports() async {
    var response;
    var url =
        credentials.urlApiBackend+'/overall'; 
    try{
       response = await http.get(url);
    }catch(e){
      log("Connection problems gettin data!");
    }
    if (response.statusCode == 200) {
      var reportsJson = json.decode(response.body);
      return [
        reportsJson[0]["Confirmed"],
        reportsJson[1]["Deaths"],
        reportsJson[2]["Recovered"]
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => fetchReports());
    ScreenUtil.init(context, width: 1125, height: 2436, allowFontScaling: false);

    return FutureBuilder(
        future: fetchReports(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: covidTheme.primaryColor,
              child: Column(
                children: <Widget>[
                  _builTotalInfectedCounter(context, 0, totalWTextStyle),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 7, right: 7),
                    child: Row(
                      children: <Widget>[
                        _builCounterHalf(context, "Deaths", 0, deathsTextStyle),
                        _builCounterHalf(
                            context, "Recovered", 0, recoveredTextStyle)
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              color: covidTheme.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _builTotalInfectedCounter(
                      context, snapshot.data[0], totalWTextStyle),
                  Container(
                    width: ScreenUtil.screenWidth,
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _builCounterHalf(context, "Deaths", snapshot.data[1],
                            deathsTextStyle),
                        _builCounterHalf(context, "Recovered", snapshot.data[2],
                            recoveredTextStyle)
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        });
  }

  Widget _builTotalInfectedCounter(
      BuildContext context, _totalInfected, _mainTextStyle) {
    final ReportListBloc reportListBloc = Provider.of<ReportListBloc>(context);
    _scale = 1 - _controller.value;

    return     GestureDetector(
      onTapDown: (detail){
        _controller.forward();
        reportListBloc.setReportsType("Confirmed");
      },
      onTapUp: (detail){
        _controller.reverse();
      },
      child: Transform.scale(
          scale: _scale,
          child:Container(
              height: ScreenUtil().setHeight(210),
              width: (MediaQuery.of(context).size.width),
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color: covidTheme.primaryColor,
                borderRadius: BorderRadius.all(radiusButtons),
                boxShadow: shadowsPrimaryColor,
                //gradient: overallGradient,

              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Total Confirmed",textScaleFactor: 1.0,
                        style: _mainTextStyle,
                      ),
                    ),
                    Container(
                      child: Text(
                        _totalInfected.toString(),textScaleFactor: 1.0,
                        style: _mainTextStyle,
                      ),
                    )
                  ],
                ),
              ))

      ),

    );
  }

  Widget _builCounterHalf(
      BuildContext context,
      _text,
      _value,
      _mainTextStyle,
      ) {
    final ReportListBloc reportListBloc = Provider.of<ReportListBloc>(context);
    _scale1 = 1 - _controllerDeaths.value;
    _scale2 = 1 - _controllerRecovered.value;


    return new GestureDetector(
      onTapDown: (detail) {

        if(_text =="Deaths" ){
          _controllerDeaths.forward();
          reportListBloc.setReportsType("Deaths");
        }else if(_text =="Recovered"){
          _controllerRecovered.forward();
          reportListBloc.setReportsType("Recovered");
        }
      },
      onTapUp: (detail){
        _text=="Deaths"? _controllerDeaths.reverse(): _controllerRecovered.reverse();
      },
      child: Transform.scale(
        scale: _text=="Deaths"?_scale1:_scale2,
        child: Container(
            height: ScreenUtil().setHeight(210),
            width:(MediaQuery.of(context).size.width - 80) / 2,
            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: BoxDecoration(
              color: covidTheme.primaryColor,
              borderRadius: BorderRadius.all(radiusButtons),
              boxShadow: shadowsPrimaryColor,
              //gradient: overallGradient,

            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(
                      _text,textScaleFactor: 1.0,
                      style: _mainTextStyle,
                    ),
                  ),
                  Container(
                    child: Text(
                      _value.toString(),textScaleFactor: 1.0,
                      style: _mainTextStyle,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
