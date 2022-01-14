import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_step3/routes/edit_profile.dart';
import 'package:cs310_step3/routes/pastPurchase.dart';
import 'package:cs310_step3/routes/seller_profile.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'commentReqs.dart';
import 'login_page.dart';
import '/services/authentication_file.dart';

class MyCommentsPage extends StatefulWidget {
  @override
  State<MyCommentsPage> createState() => _MyCommentsPageState();
  MyCommentsPage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;

}
String theUser = "";

class  _MyCommentsPageState extends State<MyCommentsPage> {
  late UserFirebase? theUser;
  late List<dynamic> myComments;

  Future<List<dynamic>> getPosts() async {
    List<dynamic> myPostsPrev = [];
    theUser = await getUserWithMail(widget.myUser!.email!);
    List<dynamic> myKeys = theUser!.comments!;
    return myKeys;
  }

  void asyncMethod() async {
    myComments = await getPosts();
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    myComments = [];
    asyncMethod();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primary)/*AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.pushNamed(context, "/Welcome");

            },
            icon: Icon(Icons.logout),
          ),
          centerTitle: true,
          title: Text("Eathall", textAlign: TextAlign.center, style: TextStyle(
            fontFamily: 'Sansita_Swashed',
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.7,
          ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed:(){
                Navigator.pushNamed(context, "/notificationsPage");
              },
              icon: Icon(Icons.add_alert),
            ),
          ]
      ),*/,
      body: SingleChildScrollView(
      ),
    );
  }
}