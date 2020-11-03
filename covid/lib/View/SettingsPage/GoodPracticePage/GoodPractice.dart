import 'package:covid19/global.dart';
import 'package:flutter/material.dart';

class GoodPracticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Color(0xff0099CC),
        bottomNavigationBar: _buildNavBar(context),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                child: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  _buildPage(context, "assets/covidWHO1.png"),
                  _buildPage(context, "assets/covidWHO2.png"),
                  _buildPage(context, "assets/covidWHO3.png"),
                  _buildPage(context, "assets/covidWHO4.png")
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget _buildPage(BuildContext context, sImage) {
    return Container(child: Image.asset(sImage));
  }

  Widget _buildNavBar(BuildContext context){
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: new TabBar(
          tabs: [
            Tab(
              child: Text("1"),
            ),
            Tab(
              child: Text("2"),
            ),
            Tab(
              child: Text("3"),
            ),
            Tab(
              child: Text("4"),
            ),

          ],
          unselectedLabelColor: Colors.black26,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.white,
          labelColor: Colors.white,
        ),
      ),
    );
  }
}
