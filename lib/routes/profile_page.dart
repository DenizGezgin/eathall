import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class  _ProfilePageState extends State<ProfilePage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
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
      ),
      body: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: OutlinedButton(
                  child: Text("Seller Profile"),
                  onPressed: (){
                    Navigator.pushNamed(context, "/sellerProfile");
                  },
                ),
              ),
            Padding(
              padding:const EdgeInsets.all(10),
              child:CircleAvatar(
                radius: 25,
                child: ClipOval(
                  child: Image.asset("assets/images/default_profile_picture.png",
                    fit: BoxFit.fill, height: 200, width: 100,),
                ),
              ),
            ),
            Text("username usersurname",
                textAlign: TextAlign.center,
                style: smallTitleBlackTextStyle
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Padding(

                  padding: const EdgeInsets.all(2),
                  child: OutlinedButton(
                    child: Text("Edit\nProfile", textAlign: TextAlign.center, style: loginSignupOrContinueSmallTextStyleBlack),
                    onPressed: (){
                      Navigator.pushNamed(context, "/editProfilePage");
                    },
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: OutlinedButton(
                    child: Text("Deactivate\nAccount", textAlign: TextAlign.center, style: loginSignupOrContinueSmallTextStyleBlack),
                    onPressed: (){
                      //pop up something
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: OutlinedButton(
                    child: Text("Delete\nAccount", textAlign: TextAlign.center,style: loginSignupOrContinueSmallTextStyleBlack),
                    onPressed: (){
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
                    Text("Account", style: loginSignupOrContinueSmallTextStyleBlack),
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
                    Icon(Icons.account_balance_wallet_rounded, color: Colors.black),
                    Text("Purchases", style: loginSignupOrContinueSmallTextStyleBlack),
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
                    Text("Bookmarks", style: loginSignupOrContinueSmallTextStyleBlack),
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
              height: 25,
              width: 400,
              color: Colors.white,

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.thumb_up_alt_rounded, color: Colors.black),
                    Text("Likes", style: loginSignupOrContinueSmallTextStyleBlack),
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
                    Text("Comments", style: loginSignupOrContinueSmallTextStyleBlack),
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
                    Text("Credit Cards", style: loginSignupOrContinueSmallTextStyleBlack),
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
                    Text("Settings", style: loginSignupOrContinueSmallTextStyleBlack),
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
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        fixedColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_headline, color: Colors.white),

            title: SizedBox(
              height: 0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white,),

            title: SizedBox(
              height: 0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, color: Colors.white, ),
            title: SizedBox(
              height: 0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.white,),
            title: SizedBox(
              height: 0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white,),
            title: SizedBox(
              height: 0,
            ),
          ),
        ],

      ),
    );
  }
}