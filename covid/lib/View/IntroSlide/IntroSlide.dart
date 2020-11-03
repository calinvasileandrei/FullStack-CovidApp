import 'package:covid19/main.dart';
import 'package:flutter/material.dart';
import 'package:covid19/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroSlide extends StatefulWidget {
  @override
  _IntroSlideState createState() => _IntroSlideState();
}

class _IntroSlideState extends State<IntroSlide> {
  final PageController ctrl = PageController(viewportFraction: 0.9);
  int currentPage = 0;
  List slides = [];
  String activeTag = 'favorites';

  @override
  void initState() {
    super.initState();
    // Set state when page changes
    slides.add(    {
      "img": "assets/slide1.jpg",
    });
    slides.add(    {
      "img": "assets/slide2.jpg",
    });
    slides.add(    {
      "img": "assets/slide3.jpg",
    });
    slides.add(    {
      "img": "assets/slide4.jpg",
    });



    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: ctrl,
            itemCount: slides.length + 1,
            itemBuilder: (context, int currentIdx) {
              if (currentIdx == 0) {
                return _buildTagPage();
              } else if (slides.length > currentIdx) {
                // Active page
                bool active = currentIdx == currentPage;
                return _buildStoryPage(slides[currentIdx - 1], active);
              }else{
                bool active = currentIdx == currentPage;
                return _buildFinalPage(slides[currentIdx - 1], active);

              }
            }));
  }

  _buildStoryPage(Map data, bool active) {
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(data['img']),
          ),
          boxShadow: shadowsPrimaryColor),
    );
  }

  _buildTagPage() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'COVID-19',
          style: splashMainTextStyle,textScaleFactor: 1,
        ),
        Text(' Tracker app', style:totalWTextStyle,textScaleFactor: 1,),
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text('Developer: Calin Vasile Andrei', style: TextStyle(color: Colors.white),textScaleFactor: 1,),
        ),

      ],
    ));
  }


  _buildFinalPage(Map data, bool active) {
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(data['img']),
          ),
          boxShadow: shadowsPrimaryColor),
      child: _buildButton(),
    );
  }

  _buildButton() {
    return Align(
      alignment: FractionalOffset.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton(
          child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => buildTabController(context))),
        ),
      ),
    );
  }
}
