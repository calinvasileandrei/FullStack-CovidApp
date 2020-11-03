import 'package:covid19/global.dart';
import 'package:covid19/View/MapPage/MapPage.dart';
import 'package:covid19/View/ReportPage/ReportPage.dart';
import 'package:covid19/View/SettingsPage/SettingPage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:covid19/View/IntroSlide/IntroSlide.dart';
import 'package:flutter/services.dart' as syst;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
void main() {
  runApp(
      DevicePreview(
          enabled: false,
          builder: (context) => MyApp()
      )
  );
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstTime=false;

  void setValue() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    if (launchCount == 0) {
      setState(() {
        firstTime = true;//true
      });
    } else {
      setState(() {
        firstTime = false; //false
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setValue();


  }

  @override
  Widget build(BuildContext context) {
    syst.SystemChrome.setPreferredOrientations([syst.DeviceOrientation.portraitUp]);

    return new MaterialApp(
        locale: DevicePreview.of(context).locale, // <--- Add the locale
        builder: DevicePreview.appBuilder, // <--- Add the builder
        debugShowCheckedModeBanner: false,
        color: covidTheme.backgroundColor,
        theme: covidTheme,
        home: _buildSplash(context, firstTime),
    );
  }

  Widget _buildSplash(BuildContext context,_firstTime){
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: _firstTime? IntroSlide(): buildTabController(context),
      title: new Text(
        "COVID-19",
        style: splashMainTextStyle,
        textScaleFactor: 1.0,
      ),
      backgroundColor: covidTheme.primaryColor,
      loadingText: new Text(
          "CalinVasileAndrei",
          style: splashSecondTextStyle,
          textScaleFactor: 1.0
      ),
      loaderColor: Colors.transparent,
    );
  }
}


Widget buildTabController(BuildContext context) {
  return DefaultTabController(
    length: 3,
    initialIndex: 1,
    child: new Scaffold(
      bottomNavigationBar: _buildNavBar(context),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          new MapPage(),
          new ReportPage(),
          new SettingPage(),
        ],
      ),
      backgroundColor: covidTheme.primaryColor,
    ),
  );
}

Widget _buildNavBar(BuildContext context) {
  return SafeArea(
    child: Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      child: new TabBar(
        tabs: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //boxShadow: shadowsNavBarColor,
            ),
            width: 50,
            child: Tab(
              icon: new Icon(
                Icons.my_location,
                size: 30,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //boxShadow: shadowsNavBarColor,
            ),
            width: 50,
            child: Tab(
              icon: new Icon(
                Icons.filter_list,
                size: 30,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //boxShadow: shadowsNavBarColor,
            ),
            width: 50,
            child: Tab(
              icon: new Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          )
        ],
        unselectedLabelColor: covidTheme.backgroundColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: covidTheme.accentColor,
        labelColor: covidTheme.accentColor,
      ),
    ),
  );
}
