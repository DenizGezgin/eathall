
import 'package:cs310_step3/utils/color.dart';
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

import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(_FirebaseAppState());
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

class _FirebaseAppState extends StatefulWidget {
  const _FirebaseAppState({Key? key}) : super(key: key);

  @override
  _FirebaseAppStateState createState() => _FirebaseAppStateState();
}

class _FirebaseAppStateState extends State<_FirebaseAppState> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context,snapshot)
        {
          if(snapshot.hasError)
            {
              return MaterialApp(
                home: Scaffold(
                  backgroundColor: AppColors.primary,
                  body: Center(
                    child: Wrap(
                      children: [Text("No connection to Firebase: ${snapshot.error.toString()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.7,
                        ),),]
                    ),

                  ),
                ),
              );
            }
          if(snapshot.connectionState == ConnectionState.done)
            {
              return MyApp();
            }
          else
            {
              return MaterialApp(
                home: Scaffold(
                  backgroundColor: AppColors.primary,
                  body: Center(
                    child: Text("Connecting...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 69,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.7,
                      ),),

                  ),
                ),
              );
            }
        }
    );
  }
}


