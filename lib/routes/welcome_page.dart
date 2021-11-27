import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushNamed(context, '/login');

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
                      Navigator.pushNamed(context, '/signup');
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

            },
                child: Text("or continue as guest",
                style: loginSignupOrContinueSmallTextStyle,),

            ),

          ],
        ),

      ),
    );
  }
}
