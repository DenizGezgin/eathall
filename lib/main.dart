import 'package:flutter/material.dart';
import '/routes/login_page.dart';


void main() {
  runApp(MaterialApp(
    //home: Welcome(),
    //initialRoute: '/login',
    routes: {
      '/': (context) => Login(),
      '/login': (context) => Login(),
      '/signup': (context) => Login(),
    },
  ));
}
