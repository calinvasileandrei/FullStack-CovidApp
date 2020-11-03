import 'package:flutter/material.dart';

//Colors
Color myPrimaryColor= Colors.grey[850];
Color mySecondaryColor= Colors.grey[300]; 
Color myAccentColor= Color(0xffFE502B);
Color deathsColor = Color(0xffFE502B);
Color recoveredColor = Color(0xff66DEBA);


//Text Style
TextStyle deathsTextStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: deathsColor);
TextStyle recoveredTextStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w500,color: recoveredColor);
TextStyle confirmedListTextStyle =TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: covidTheme.accentColor);

TextStyle totalTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w800,color: Colors.black);
TextStyle totalWTextStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.w800,color: Colors.white54,);

TextStyle mainTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.grey[800]);
TextStyle mainWTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white);

TextStyle itemListTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black87);
TextStyle itemListWTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white);

TextStyle splashMainTextStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.w900,color: Colors.white);
TextStyle splashSecondTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white54);

TextStyle settingHeaderTextStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.w700,color: Colors.white);
TextStyle settingsFooterTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.white54);




var overallGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xff393939),
    Colors.grey[850],
    Color(0xff292929),
    Color(0xff242424),
  ],

);


var overallClickGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xff242424),
    Color(0xff292929),
    Colors.grey[850],
    Color(0xff393939),
    Colors.grey[850],
    Color(0xff292929),//Color(0xff242424),

    Color(0xff242424)
  ],

);
//Shadows
var shadowsPrimaryColor =[
  BoxShadow( // bottomright
    color: Colors.black87,
    blurRadius: 15.0, // has the effect of softening the shadow
    spreadRadius: 1.0, // has the effect of extending the shadow
    offset: Offset(
      4.0, // horizontal, move right 10
      4.0, // vertical, move down 10
    ),
  ),
  BoxShadow( //topleft
    color: Colors.grey[800],
    blurRadius: 15.0, // has the effect of softening the shadow
    spreadRadius: 1.0, // has the effect of extending the shadow
    offset: Offset(
      -3.0, // horizontal, move right 10
      -3.0, // vertical, move down 10
    ),
  )
];

var shadowsBackgroundColor =[
  BoxShadow( // bottomright
    color: Colors.grey[500],
    blurRadius: 15.0, // has the effect of softening the shadow
    spreadRadius: 1.0, // has the effect of extending the shadow
    offset: Offset(
      4.0, // horizontal, move right 10
      4.0, // vertical, move down 10
    ),
  ),
  BoxShadow( //topleft
    color: Colors.white,
    blurRadius: 15.0, // has the effect of softening the shadow
    spreadRadius: 1.0, // has the effect of extending the shadow
    offset: Offset(
      -4.0, // horizontal, move right 10
      -4.0, // vertical, move down 10
    ),
  )
];

var shadowsNavBarColor =[
  BoxShadow( // bottomright
    color: Colors.black12,
    blurRadius: 15.0, // has the effect of softening the shadow
    spreadRadius: 0.0, // has the effect of extending the shadow
    offset: Offset(
      5.0, // horizontal, move right 10
      5.0, // vertical, move down 10
    ),
  ),
  BoxShadow( //topleft
    color: Colors.grey[800],
    blurRadius: 15.0, // has the effect of softening the shadow
    spreadRadius: 1.0, // has the effect of extending the shadow
    offset: Offset(
      -5.0, // horizontal, move right 10
      -5.0, // vertical, move down 10
    ),
  )
];

var radiusButtons = Radius.circular(14.0);

ThemeData covidTheme = ThemeData(
  primaryColor: myPrimaryColor,
  accentColor: myAccentColor,
  brightness: Brightness.dark,
  backgroundColor: mySecondaryColor,
  unselectedWidgetColor: Colors.transparent,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  fontFamily: 'Helvetica',

  textTheme: TextTheme(
    body1: TextStyle(fontSize: 16,color: Colors.black),
    title: TextStyle(fontSize: 22,fontStyle: FontStyle.italic,color: Colors.black),
    headline: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.black)

  )
);

