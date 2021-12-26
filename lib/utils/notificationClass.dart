import 'package:flutter/material.dart';

class notification{
  final String? msg;
  String? date;
  String? hour;

  notification(this.msg){
    DateTime dateToday =new DateTime.now();
    String dateN = dateToday.toString().substring(0,10);
    //String hourN = dateToday.toString().substring(11,10);
    String hourN = "hour";
    date = dateN;
    hour = hourN;
  }
}