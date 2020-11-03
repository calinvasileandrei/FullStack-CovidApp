import 'dart:developer';

import 'package:covid19/global.dart';
import 'package:covid19/View/ReportList/ReportListBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class ReportList extends StatefulWidget {
  ReportList({Key key}) : super(key: key);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    final ReportListBloc reportListBloc = Provider.of<ReportListBloc>(context);
    return FutureProvider<void>.value(
      value: reportListBloc.fetchReports(),
      child: Column(
        children: <Widget>[

          Container(
            margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
            width: ScreenUtil.screenWidth,
            height: ScreenUtil().setHeight(120),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.white70,
                  blurRadius: 20.0, // has the effect of softening the shadow
                  spreadRadius: 0.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    -8.0, // vertical, move down 10
                  )),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(right: 0),
                  width: (MediaQuery.of(context).size.width - 80) / 3,
                  child: Text(
                    "City",textScaleFactor: 1.0,
                    style: mainTextStyle,
                  ),
                ),
                VerticalDivider(color: Colors.grey[800],),
                Container(
                  alignment: Alignment.center,
                  width: (MediaQuery.of(context).size.width - 60) / 3,
                  child: Text(
                    "Country",textScaleFactor: 1.0,
                    style: mainTextStyle,
                  ),
                ),
                VerticalDivider(color: Colors.grey[800],),

                Container(
                  alignment: Alignment.center,
                  width: (MediaQuery.of(context).size.width - 60) / 3,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      reportListBloc.reportsType==null ? "Confirmed":reportListBloc.reportsType,textScaleFactor: 1.0,
                      style: mainTextStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(),

          Expanded(
              child: Container(
                  color: covidTheme.backgroundColor,
                  child: (reportListBloc.isLoading)
                      ? Container(
                    width: MediaQuery.of(context).size.width,
                    color: covidTheme.backgroundColor,
                    child: Container(
                      child: Center(
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  covidTheme.accentColor))),
                    ),
                  )
                      : RefreshIndicator(
                    onRefresh: reportListBloc.fetchReports,
                    child: ListView.builder(
                      itemCount: reportListBloc.reports.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            _buildItem(context, index, reportListBloc),
                          ],
                        );
                      },
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _buildItem(context,index , reportListBloc){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil().setHeight(240),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(radiusButtons),
          color: covidTheme.backgroundColor,
          boxShadow: shadowsBackgroundColor),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: (MediaQuery.of(context).size.width -
                40) /
                3,
            child: Text(
              reportListBloc.reports[index].city == null
                  ? 'nodata'
                  : reportListBloc.reports[index].city,
              style: itemListTextStyle,
              textScaleFactor: 1.0,
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width -
                40) /
                3,
            child: Text(
              reportListBloc.reports[index].country ==
                  null
                  ? 'nodata'
                  : reportListBloc
                  .reports[index].country,
              style: itemListTextStyle,
              textScaleFactor: 1.0,
            ),
          ),
          Container(
            child: Text(
              reportListBloc.reports[index].confirmed
                  .toString(),
              style: confirmedListTextStyle,
              textScaleFactor: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}