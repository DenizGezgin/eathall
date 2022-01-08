import 'dart:typed_data';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 82),
                      child:Text("Seller Profile",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                        fontFamily: 'Sansita_Swashed',
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.7,
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Container(
                        color: Colors.black,
                        width: 267.5,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("userName userSurname",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.7,
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 125),
                  child: Text("rating of the seller if possible"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/addProductPage"); }, //sorun var
                child: Container(
                  height: 30,
                  color: AppColors.purchaseAndAdd,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.add_box, color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.only(left: 103),
                        child: Text("ADD NEW PRODUCT", style: loginSignupOrContinueSmallTextStyleBlack),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(

                ),
                Container(

                ),
                Container(

                ),
              ],
            ),//for the products on sale
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 30,
                width: 368,
                color: AppColors.loginToContinueBackGround,
                child: Padding(
                  padding: const EdgeInsets.only(top:6),
                  child: Text("SOLD PRODUCTS", textAlign: TextAlign.center,),
                ),
              ),
            ),
            Row(
              children: [
                Container(

                ),
                Container(

                ),
                Container(

                ),
              ],
            ), //for the sold products
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: () {},
                child: Container(
                  height: 30,
                  color: AppColors.purchaseAndAdd,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.mode_comment, color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.only(left: 95),
                        child: Text("COMMENT REQUESTS", style: loginSignupOrContinueSmallTextStyleBlack),
                      ),
                    ],
                  ),
                ),
              ),
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