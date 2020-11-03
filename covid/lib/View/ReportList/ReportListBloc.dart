import 'package:covid19/Model/Report/report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:covid19/credentials.dart' as credentials;


class ReportListBloc extends ChangeNotifier{
  List<Report> _reports ;
  String _reportsType = "Confirmed" ;
  bool _isLoading = true;

  List<Report> get reports => _reports;
  String get reportsType => _reportsType;
  bool get isLoading => _isLoading;


  void setIsLoading(bool val){
    _isLoading= val;
    notifyListeners();
  }

  void setReportsType(String val){
    _isLoading=true;
    _reportsType = val;
    fetchReports();
    notifyListeners();
  }


  Future<void> fetchReports() async {
    var url = credentials.urlApiBackend+'/list/'+_reportsType[0].toLowerCase()+_reportsType.substring(1);

    var response = await http.get(url);
    var reports = List<Report>();
    if (response.statusCode == 200) {
      var reportsJson = json.decode(response.body);

      var n= 0;
      for (var data in reportsJson) {
        Report newReport = new Report();
        newReport.setType(_reportsType);
        newReport.fromJson(data);
        reports.add(newReport);
      }
    }
    reports.sort((b, a) => a.confirmed.compareTo(b.confirmed));
    _reports = reports;
    _isLoading=false;
    notifyListeners();

  }










}