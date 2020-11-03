import 'package:covid19/global.dart';
import 'package:covid19/View/ReportList/ReportList.dart';
import 'package:covid19/View/ReportOverall/ReportOverall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid19/View/ReportList/ReportListBloc.dart';

class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: covidTheme.primaryColor,
      child: SafeArea(
          child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ReportListBloc>.value(value: ReportListBloc()),
        ],
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: ReportOverall(),
              ),
              Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: covidTheme.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black87,
                              blurRadius: 15.0,
                              // has the effect of softening the shadow
                              spreadRadius: 1.0,
                              // has the effect of extending the shadow
                              offset: Offset(
                                0.0, // horizontal, move right 10
                                5.0, // vertical, move down 10
                              ))
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: ReportList(),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
