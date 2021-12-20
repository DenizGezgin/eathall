import 'package:cs310_step3/routes/welcome_page.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import '/services/authentication_file.dart';
import '/services/db.dart';

class FeedView extends StatefulWidget {
  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {

    //db.addUser('name', 'surname', 'mail', 'token');
    //db.addUserAutoID('nameAuto', 'surnameAuto', 'mail@auto', 'token');

    return Scaffold(
      backgroundColor: AppColors.loginToContinueBackGround,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            auth.signOut();
            Navigator.pushNamed(context, "/Welcome");
            
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: Scaffold(
        bottomNavigationBar:
          BottomNavigationBar(

            type: BottomNavigationBarType.fixed,
            iconSize: 35,
            fixedColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.view_headline),
                title: SizedBox(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: SizedBox(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                title: SizedBox(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: SizedBox(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: SizedBox(
                  height: 0,
                ),
              ),
            ],
          ),



      ),
    );
  }
}