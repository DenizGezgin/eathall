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
              padding: const EdgeInsets.all(3),
              child: OutlinedButton(
                child: Text("Seller Profile"),
                onPressed: (){
                  Navigator.pushNamed(context, "/sellerProfile");
                  },
              ),
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Padding(
              padding:const EdgeInsets.all(14),
              child:CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: Image.asset("assets/images/default_profile_picture.png",
                    fit: BoxFit.fill, height: 110, width: 330,),
                ),
              ),
            ),
            Text("username usersurname",
                textAlign: TextAlign.center,
                style: smallTitleBlackTextStyle
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: OutlinedButton(
                    child: Text("Edit\nProfile"),
                    onPressed: (){
                      Navigator.pushNamed(context, "/editProfilePage");
                    },
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: OutlinedButton(
                    child: Text("Deactivate\nAccount"),
                    onPressed: (){
                      //pop up something
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: OutlinedButton(
                    child: Text("Delete\nAccount"),
                    onPressed: (){
                      //pop up something
                    },
                  ),
                ),
                Expanded(child: Container(),),
              ]
            ),
            Expanded(child: Container(),),
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