import 'dart:developer';

class Report {
  String city;
  String country;
  int confirmed;
  String type;

  Report({this.city,this.country,this.confirmed,this.type});

  fromJson(Map<String,dynamic> json){
    city = json["Province/State"];
    country = json["Country/Region"];
    confirmed = json[type];
  }

  setCountry(country){
    this.country = country;
  }
  setCity(city){
    this.city = city;
  }
  setConfirmed(confirmed){
    this.confirmed = confirmed;
  }

  setType(type){
    this.type = type;
  }
}