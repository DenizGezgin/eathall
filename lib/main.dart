import 'package:flutter/material.dart';
import '/routes/login_page.dart';
import '/routes/welcome_page.dart';
import '/routes/signup_page.dart';


void main() {
  runApp(MaterialApp(
    //home: Welcome(),
    //initialRoute: '/login',
    routes: {
      '/': (context) => Welcome(),
      '/login': (context) => Login(),
      '/signup': (context) => Signup(),
    },
  ));
}
