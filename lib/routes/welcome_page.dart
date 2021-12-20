import 'dart:io' show Platform;

import 'package:cs310_step3/routes/login_page.dart';
import 'package:cs310_step3/routes/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:cs310_step3/services/analytics.dart';

import 'feedView.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key,required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => setCurrentScreen(widget.analytics, 'Welcome Page', 'welcome_page.dart'));

  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);

    if(user == null) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [SizedBox(height: 150,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/appLogo_login.jpg',
                        width: MediaQuery.of(context).size.width/2.2,
                      ),

                    ],
                  ),
                ],
              ),
              Text("Eathall", style: TextStyle(
                fontFamily: 'Sansita_Swashed',
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.7,
              ),

              ),
              SizedBox(height: 36,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, '/login');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login(analytics: widget.analytics, observer: widget.observer)),);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:12.0),
                        child: Text("Login",
                          style: loginSignupOrContinueSmallTextStyleBlack,),

                      ),

                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.background,
                      ),
                    ),

                  ),

                ],
              ),
              SizedBox(height: 18,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, '/signup');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup(analytics: widget.analytics, observer: widget.observer)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:12.0),
                        child: Text("Sign Up",
                          style: loginSignupOrContinueSmallTextStyleBlack,),

                      ),

                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.background,
                      ),
                    ),

                  ),

                ],
              ),

              TextButton(onPressed: () {
                auth.signInAnon();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedView(),),
                );

              },
                child: Text("or continue as guest",
                  style: loginSignupOrContinueSmallTextStyle,),

              ),

            ],
          ),

        ),
      );
    }

    else{
      return FeedView();
    }
  }
}
