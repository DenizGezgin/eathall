import 'dart:io' show Platform;

import 'package:cs310_step3/services/analytics.dart';
import 'package:cs310_step3/services/authentication_file.dart';
import 'package:cs310_step3/utils/dimension.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import 'feedView.dart';


class Login extends StatefulWidget {
  Login({Key? key,required this.analytics, required this.observer}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _LoginState createState() => _LoginState();
}
  bool isIOS = Platform.isIOS;
  String mail = "";
  String pass = "";

  AuthService auth = AuthService();

class _LoginState extends State<Login> {

  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => setCurrentScreen(widget.analytics, 'Login Page', 'login_page.dart'));
  }

  @override

  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    Future<void> showAlertDialog(String title, String message) async {
      return showDialog(context: context,
          barrierDismissible: false, //must take action
          builder: (BuildContext context) {
            if(isIOS) {
              return CupertinoAlertDialog( //styling is not always auto adjusted
                title: Text(title),
                content: SingleChildScrollView(
                  child: Text(message),
                ),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(); //pop the current alert view
                  },
                      child: Text("OK"))
                ],
              );
            }
            else{
              return AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(
                  child: Text(message),
                ),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(); //pop the current alert view
                  },
                      child: Text("OK"))
                ],
              );
            }
          }
      );
    }
  if(user == null) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      appBar: AppBar(title: Text(
        'User login',
        style: appBarTitleTextStyle,
      ),
        backgroundColor: AppColors.loginToContinueBackGround,
        elevation: 0.0,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: widget.formKey,
          child: SingleChildScrollView(
            child: Column(


              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                Image.asset('assets/images/appLogo_login.jpg',
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2.2,
                ),

                Text("Eathall", style: TextStyle(
                  fontFamily: 'Sansita_Swashed',
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.7,
                ),
                ),
                SizedBox(height: 50,),
                Row( //MAIL FIELD
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.background,
                          filled: true,
                          hintText: 'E-mail',
                          errorStyle: loginErrorStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,

                        validator: (value) {
                          if (value == null) {
                            return 'E-mail field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              return 'E-mail field cannot be empty';
                            }
                            if (!EmailValidator.validate(trimmedValue)) {
                              return 'Please enter a valid email';
                            }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if (value != null) {
                            mail = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.background,
                          filled: true,
                          hintText: 'Password',
                          errorStyle: loginErrorStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        //text from field passwords
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,

                        validator: (value) {
                          if (value == null) {
                            return 'Password field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              return 'Password field cannot be empty';
                            }
                            if (trimmedValue.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if (value != null) {
                            pass = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () async {
                          if (widget.formKey.currentState!.validate()) {
                            print('Mail: ' + mail + "\nPass: " + pass);
                            widget.formKey.currentState!.save();
                            print('Mail: ' + mail + "\nPass: " + pass);
                            //getUser();

                            try {
                              User? u = await auth.loginWithMailAndPass(mail, pass);
                              UserFirebase myUserc = await getUserWithMail(mail);
                              if(myUserc.email == "NULL_NAME"){
                                setState(() {
                                  showAlertDialog("Invalid Login Info",
                                      "Please sign up first!");
                                });
                              }
                              else
                                {

                                  if(myUserc.disabled!){
                                    await addNotificaitonToUser(myUserc.email!, "You have activated your account again.");
                                    await makeUserEnabled(myUserc.email!);
                                  }

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FeedView(myUser: myUserc)
                                      ));
                                }

                            } catch(e) {
                              setState(() {
                                showAlertDialog("Invalid Login Info",
                                    "Please sign up first!");
                              });
                            }
                          }
                          else {
                            setState(() {
                              showAlertDialog("Invalid Login Info",
                                  "Please check mail and password fields and try again.");
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text("Login",
                            style: loginButtonTextStyle,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Divider(
                                color: Colors.black26,
                                thickness: 1.2,
                              )
                          ),

                          Text("  Or  ",
                            style: loginSignupOrContinueSmallTextStyleBlack,),
                          Expanded(
                              child: Divider(
                                color: Colors.black26,
                                thickness: 1.2,
                              )
                          ),
                        ]
                    ),
                    SizedBox(height: 16,),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        //////////////////////////////////
                        auth.signInWithGoogle();
                      },
                    ),
                    SizedBox(height: 16,),
                  ],

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  else{
    return FeedView();
  }
  }

}

