import 'package:cs310_step3/routes/welcome_page.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/styles.dart';
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

        body: SingleChildScrollView(
          child: Column(

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: OutlinedButton(
                      child: Text("Go to Search"),
                      onPressed: (){
                        Navigator.pushNamed(context, "/SearchView");
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.primary,
                thickness: 1,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                      child: ClipRect(
                        child: Image.asset("assets/images/add_banner.png", fit: BoxFit.fill, height: 110, width: 330,),
                      ),
                  ),
                ],
              ),

              Text("Products", style: loginSignupOrContinueSmallTextStyleBlack,),
              Divider(
                color: AppColors.primary,
                thickness: 1,
              ),
              SizedBox(
                width: 5,
                height: 7,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Container(
                height: 150,
                width: 150,
                color: AppColors.primary,
                child: IconButton(
                  icon: Image.asset('assets/images/cigkofte.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                  onPressed: () {print("CigKofte");},
                ),
              ),
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.primary,
                    child: IconButton(
                      icon: Image.asset('assets/images/kofte.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                      onPressed: () {print("kofte");},
                    ),
                  ),

                ],
              ),
              SizedBox(
                width: 5,
                height: 15,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.primary,
                    child: IconButton(
                      icon: Image.asset('assets/images/manti.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                      onPressed: () {print("manti");},
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.primary,
                    child: IconButton(
                      icon: Image.asset('assets/images/menemen.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                      onPressed: () {print("menemen");},
                    ),
                  ),

                ],
              ),
              SizedBox(
                width: 5,
                height: 15,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.primary,
                    child: IconButton(
                      icon: Image.asset('assets/images/pizza.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                      onPressed: () {print("pizza");},
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.primary,
                    child: IconButton(
                      icon: Image.asset('assets/images/sushi.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                      onPressed: () {print("sushi");},
                    ),
                  ),

                ],
              ),
              SizedBox(
                width: 5,
                height: 15,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.primary,
                    child: IconButton(
                      icon: Image.asset('assets/images/tavukdoner.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                      onPressed: () {print("tavukdoner");},
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.primary,
                    child: IconButton(
                      icon: Image.asset('assets/images/tavukkanat.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                      onPressed: () {print("tavukkanat");},
                    ),
                  ),

                ],
              ),
              SizedBox(
                width: 5,
                height: 15,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: AppColors.primary,
                    child: IconButton(
                      icon: Image.asset('assets/images/tavukpilav.jpg', fit: BoxFit.fill, height: 149, width: 149,),
                      onPressed: () {print("tavukpilav");},
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,

                  ),

                ],
              ),




            ],
          ),
        ),

        bottomNavigationBar:
        BottomNavigationBar(
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






      ),
    );
  }
}