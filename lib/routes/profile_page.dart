import 'dart:typed_data';

import 'package:cs310_step3/routes/edit_profile.dart';
import 'package:cs310_step3/routes/seller_profile.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
  ProfilePage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;
}
String theUser = "";



class  _ProfilePageState extends State<ProfilePage>{


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    Future<String?> getUsername(User user) async {
      if(user == null) {
        return "no user";
      }
      else{
        user.displayName;
      }
    }
    
  if(user != null){

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: OutlinedButton(
                child: Text("Seller Profile"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerProfilePage(myUser: widget.myUser)
                      ));
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 25,
                child: ClipOval(

                  child: Image.network(widget.myUser!.photoUrl!,
                    fit: BoxFit.fill, height: 200, width: 100,),
                ),
              ),
            ),
            Text(widget.myUser!.name! + " " + widget.myUser!.surname!,
                textAlign: TextAlign.center,
                style: smallTitleBlackTextStyle
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Padding(

                    padding: const EdgeInsets.all(2),
                    child: OutlinedButton(
                      child: Text("Edit\nProfile", textAlign: TextAlign.center,
                          style: loginSignupOrContinueSmallTextStyleBlack),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfilePage(myUser: widget.myUser)
                            ));
                      },
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: OutlinedButton(
                      child: Text(
                          "Deactivate\nAccount", textAlign: TextAlign.center,
                          style: loginSignupOrContinueSmallTextStyleBlack),
                      onPressed: () {
                        //pop up something
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: OutlinedButton(
                      child: Text(
                          "Delete\nAccount", textAlign: TextAlign.center,
                          style: loginSignupOrContinueSmallTextStyleBlack),
                      onPressed: () {
                        //pop up something
                      },
                    ),
                  ),
                ]
            ),
            Expanded(child: Container(),),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),

            Container(
              height: 20,
              width: 400,
              color: Colors.white,

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.account_circle_sharp, color: Colors.black),
                    Text("Account",
                        style: loginSignupOrContinueSmallTextStyleBlack),
                  ],
                ),
              ),
            ),
            Expanded(child: Container(),),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Container(
              height: 20,
              width: 400,
              color: Colors.white,

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet_rounded,
                        color: Colors.black),
                    Text("Purchases",
                        style: loginSignupOrContinueSmallTextStyleBlack),
                  ],
                ),
              ),
            ),
            Expanded(child: Container(),),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Container(
              height: 20,
              width: 400,
              color: Colors.white,

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.bookmark, color: Colors.black),
                    Text("Bookmarks",
                        style: loginSignupOrContinueSmallTextStyleBlack),
                  ],
                ),
              ),
            ),
            Expanded(child: Container(),),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),

            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Container(
              height: 20,
              width: 400,
              color: Colors.white,

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.mode_comment, color: Colors.black),
                    Text("Comments",
                        style: loginSignupOrContinueSmallTextStyleBlack),
                  ],
                ),
              ),
            ),
            Expanded(child: Container(),),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Container(
              height: 20,
              width: 400,
              color: Colors.white,

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.credit_card, color: Colors.black),
                    Text("Credit Cards",
                        style: loginSignupOrContinueSmallTextStyleBlack),
                  ],
                ),
              ),
            ),
            Expanded(child: Container(),),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Container(
              height: 20,
              width: 400,
              color: Colors.white,

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.black),
                    Text("Settings",
                        style: loginSignupOrContinueSmallTextStyleBlack),
                  ],
                ),
              ),
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
  else{
    return Scaffold(

    );
  }
  }
}