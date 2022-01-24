import 'package:cs310_step3/services/authentication_file.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RedirectionPage extends StatefulWidget {
  @override
  State<RedirectionPage> createState() => _RedirectionPageState();
}

class _RedirectionPageState extends State<RedirectionPage>{
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginToContinueBackGround,
      body: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80, left: 45),
              child: Text("login or sign up to continue this page", style: appBarTitleTextStyle),

            ),
            Padding(
              padding: EdgeInsets.only(top:380, left: 45),
              child: Text("press button to go to welcome page", style: loginSignupOrContinueSmallTextStyleSansitaSwashed),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 45),
              child: IconButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.pushNamed(context, "/Welcome");
                },
                icon: Icon(Icons.login_outlined),
                color: Colors.white,
                iconSize: 30,
              ),
            ),
          ],
        ),
      );
  }
}