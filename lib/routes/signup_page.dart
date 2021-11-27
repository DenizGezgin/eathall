import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}
  bool isIOS = Platform.isIOS;
  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String pass = "";
  String passTemp = "";
  String name = "";
  String surname = "";
  String address = "";

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {

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





    return Scaffold(
        appBar: AppBar(title: Text(
          'Sign Up',
          style: appBarTitleTextStyle,
        ),
          backgroundColor: AppColors.loginToContinueBackGround,
          elevation: 0.0,),
      backgroundColor: AppColors.primary,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                          if(value == null) {
                            return 'E-mail field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'E-mail field cannot be empty';
                            }
                            if(!EmailValidator.validate(trimmedValue)) {
                              return 'Please enter a valid email';
                            }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if(value != null) {
                            mail = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row( //PASS
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
                          if(value == null) {
                            return 'Password field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Password field cannot be empty';
                            }
                            if(trimmedValue.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            passTemp = trimmedValue;
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if(value != null) {
                            pass = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row( //PASS REPEAT
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.background,
                          filled: true,
                          hintText: 'Password again',
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
                          if(value == null) {
                            return 'Password repeat field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Password field cannot be empty';
                            }
                            if(trimmedValue != passTemp) {
                                return "Passwords do not match";
                              }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if(value != null) {
                            pass = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row( //NAME FIELD
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.background,
                          filled: true,
                          hintText: 'Name',
                          errorStyle: loginErrorStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,

                        validator: (value) {
                          if(value == null) {
                            return 'Name field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Name field cannot be empty';
                            }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if(value != null) {
                            name = value.capitalize();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row( //SURNAME FIELD
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.background,
                          filled: true,
                          hintText: 'Surname',
                          errorStyle: loginErrorStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,

                        validator: (value) {
                          if(value == null) {
                            return 'Surname field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Surname field cannot be empty';
                            }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if(value != null) {
                            surname = value.capitalize();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row( //ADRESS FIELD
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.background,
                          filled: true,
                          hintText: 'Address',
                          errorStyle: loginErrorStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        maxLines: 5,
                        minLines: 3,
                        keyboardType: TextInputType.text,

                        validator: (value) {
                          if(value == null) {
                            return 'Address field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Address field cannot be empty';
                            }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if(value != null) {
                            address = value.toLowerCase();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              print('Mail: '+mail+"\nPass: "+pass+"\nName: "+name+"\nSurname: "+surname+"\nAddress: "+address);
                              _formKey.currentState!.save();
                              print('Mail: '+mail+"\nPass: "+pass+"\nName: "+name+"\nSurname: "+surname+"\nAddress: "+address);
                              //createUser();
                            }
                            else{
                              setState(() {
                                showAlertDialog("Invalid User Info", "Please check the fields again.");
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("Create Account",
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
                ),
                SizedBox(height: 16,),
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
                    SizedBox(height: 12,),
                    SignInButton(
                      Buttons.Google,
                      text: "Sign Up with Google",
                      onPressed: () {},
                    ),
                    SizedBox(height: 12,),
                    SignInButton(
                      Buttons.FacebookNew,
                      text: "Sign Up with Facebook",
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}



