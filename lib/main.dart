
import 'package:flutter/material.dart';
import '/routes/login_page.dart';
import '/routes/welcome_page.dart';
import '/routes/signup_page.dart';
import '/routes/walkthrough.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:is_first_run/is_first_run.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';


/*
bool? _isFirstRun;
bool? _isFirstCall;


class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
  MySharedPreferences._privateConstructor();
  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isLoggedIn = false;
  bool? _isFirstRun;
  bool? _isFirstCall;

  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
    });
  }

  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("isfirstRun")
        .then((value) => setState(() {
      isLoggedIn = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        //if true return intro screen for first time Else go to login Screen
        home: isLoggedIn ? Login() : WalkThrough());
  }
}


Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}

Future<File> writeCounter(int counter) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString('$counter');
}

Future<int> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}
*/


/*
main() {

  bool isFirstRun = false;

  Future checkFirstRun() async {
    isFirstRun = await IsFirstRun.isFirstRun();
  }
  checkFirstRun();

  runApp(MaterialApp(
    //home: Welcome(),

    initialRoute: isFirstRun ? "/walkthrough" : "/" ,
    routes: {
      '/': (context) => Welcome(),
      '/login': (context) => Login(),
      '/signup': (context) => Signup(),
      '/walkthrough': (context) => WalkThrough(),
    },
  ));
}
*/



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isLoggedIn = false;

  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("isfirstRun")
        .then((value) => setState(() {
      isLoggedIn = value;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        //if true return intro screen for first time Else go to login Screen
      home: isLoggedIn ? Welcome() : WalkThrough(),
      //initialRoute:

    );
  }
}

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
  MySharedPreferences._privateConstructor();
  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }
}

