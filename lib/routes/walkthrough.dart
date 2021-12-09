import 'dart:io' show Platform;

import 'package:cs310_step3/routes/welcome_page.dart';
import 'package:cs310_step3/services/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class WalkThrough extends StatefulWidget {
  const WalkThrough({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => setCurrentScreen(widget.analytics, 'Walkthrough Page', 'walkthrough.dart'));
  }



  int currentPage = 0;
  int lastPage = 3;

  int ctr = 0;

  List<String> title = [
    'WELCOME',
    'ORDER',
    'SELL',
    "FINISH",
  ];

  List<String> heading = [
    "LET'S BEGIN",
    "WHATEVER YOU WANT",
    "SELL LOCAL FOODS",
    "LET'S GO",
  ];

  List<String> captions=[
    "Welcome to EATHALL",
    "You can order WHATEVER you desire ANYTIME you want",
    "List your homemade food or your shops food and start earning today",
    "Create an account and begin the journey",
  ];

  List<String> photos=[
    'assets/images/el_logo.JPG',
    'assets/images/el_hamburger.JPG',
    'assets/images/stockfood.jpg',
    'assets/images/appLogo_login2.jpg',
  ];


  void nextPage() {
    if(currentPage < lastPage) {
      setState(() {
        currentPage += 1;
      });
    }
  }

  void prevPage() {
    if(currentPage > 0) {
      setState(() {
        currentPage -= 1;
      });
    }
  }

  void finishThePage(){
    ctr++;
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Welcome(analytics: analytics, observer: observer)),);
    MySharedPreferences.instance.setBooleanValue("isfirstRun", true);
    MySharedPreferences.instance.setBooleanValue("loggedin", true);
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(

      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.loginToContinueBackGround,
        title: Text(
          title[currentPage],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  heading[currentPage],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ),
            Container(
              height: 280,
              child: CircleAvatar(
                backgroundColor: AppColors.background,
                radius: 140,
                backgroundImage: AssetImage(photos[currentPage]),
                ),
              ),
            Center(
              child: Text(
                captions[currentPage],
                style: smallTitleBlackTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(onPressed: prevPage, child: Text('Prev', style: TextStyle(
                      color: AppColors.textColorPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.1,
                    ),)),
                    Text(
                      '${currentPage+1}/${lastPage+1}',
                      style: TextStyle(
                        color: AppColors.textColorPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.1,
                      ),
                    ),
                    OutlinedButton(onPressed: currentPage==lastPage ? finishThePage:nextPage, child: currentPage==lastPage ? Text('Finish', style: TextStyle(
                      color: AppColors.textColorPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.1,
                    ),):Text('Next', style: TextStyle(
                      color: AppColors.textColorPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.1,
                    ),)),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
