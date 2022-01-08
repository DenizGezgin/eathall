import 'dart:typed_data';

import 'package:cs310_step3/routes/edit_profile.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'package:cs310_step3/utils/styles.dart';


class SellerProfilePage extends StatefulWidget {
  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
  SellerProfilePage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;
}
String theUser = "";


class  _SellerProfilePageState extends State<SellerProfilePage> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    Future<String?> getUsername(User user) async {
      if (user == null) {
        return "no user";
      }
      else {
        user.displayName;
      }
    }

    /*var f = widget.myUser;
    if (f != null) {
      var widgetMyUser = f; // Safe
    }*/

    if (user != null) {
      return Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Container(
                    color: Colors.black,
                    width: 30,
                    height: 1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 5, top: 90, bottom: 10, left: 5),
                  child: CircleAvatar(
                    radius: 40,
                    child: ClipOval(

                      child: Image.network(/*widget.myUser!.photoUrl!*/
                        'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.nicepng.com%2Fpng%2Fdetail%2F933-9332131_profile-picture-default-png.png&imgrefurl=https%3A%2F%2Fwww.nicepng.com%2Fourpic%2Fu2y3a9e6t4o0a9w7_profile-picture-default-png%2F&tbnid=bLv2FccUvqriEM&vet=12ahUKEwjjs6SAgqL1AhWO4bsIHRIjD48QMygRegUIARCCAg..i&docid=-E5pvHnffveX2M&w=820&h=719&q=default%20profile%20picture&ved=2ahUKEwjjs6SAgqL1AhWO4bsIHRIjD48QMygRegUIARCCAg',
                        fit: BoxFit.fill, height: 200, width: 100,),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 82),
                      child:Text("Seller Profile",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                        fontFamily: 'Sansita_Swashed',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.7,
                        ),

                      ),
                    ),

                    Container(
                      color: Colors.black,
                      width: 180,
                      height: 1,
                    ),
                    Text("userName userSurname",
                        style: smallTitleBlackTextStyle
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    else {
      return Scaffold(

      );
    }
  }
}