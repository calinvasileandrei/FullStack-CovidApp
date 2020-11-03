import 'dart:async';
import 'dart:developer';
import 'package:covid19/View/SettingsPage/GoodPracticePage/GoodPractice.dart';
import 'package:flutter/material.dart';
import 'package:covid19/global.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with TickerProviderStateMixin {
  static DateTime dayOne = DateTime(2020, 01, 22);
  static DateTime date = DateTime.now();
  static var diff = date.difference(dayOne).inDays;
  static String dateOneFormat = DateFormat('dd-MM-yyyy').format(dayOne);

  double _scale = 0;
  AnimationController _controller;

  double _scale2 = 0;
  AnimationController _controller2;

 
  @override
  void initState() {
    //_initialize();
    super.initState();

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

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    _scale2 = 1 - _controller2.value;
    return SafeArea(
      child: new Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
        color: covidTheme.primaryColor,
        child: Column(
          children: <Widget>[
            Text(
              "COVID-19",
              style: settingHeaderTextStyle,
              textScaleFactor: 1.0,
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width - 30,
              height: ScreenUtil().setHeight(1200),
              decoration: BoxDecoration(
                  boxShadow: shadowsPrimaryColor,
                  color: covidTheme.primaryColor,
                  borderRadius: BorderRadius.all(radiusButtons)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildButton("Day One: " + dateOneFormat),
                  _buildButton("Since Day One : " + diff.toString() + "days"),
                  GestureDetector(
                    child: Transform.scale(
                        scale: _scale, child: _buildButton("Good Practice")),
                    onTapDown: (detail) => _controller.forward(),
                    onTapUp: (detail) {
                      _controller.reverse();
                      //AdmobManager.setPremiumUser();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoodPracticePage()));
                    },
                  ),
                ],
              ),
            ),
            Text("Made by: Calin Vasile Andrei",
                style: settingsFooterTextStyle, textScaleFactor: 1.0),
            Text("MadWorks",
                style: settingsFooterTextStyle, textScaleFactor: 1.0),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(_Text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setHeight(180),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(radiusButtons),
        color: covidTheme.primaryColor,
        boxShadow: shadowsPrimaryColor,
        //gradient: overallGradient
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(_Text, style: itemListWTextStyle, textScaleFactor: 1.0),
          ),
        ],
      ),
    );
  }
}
