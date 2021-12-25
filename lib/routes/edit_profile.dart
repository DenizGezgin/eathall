import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/utils/color.dart';
import '/utils/styles.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class  _EditProfilePageState extends State<EditProfilePage>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed:(){
            Navigator.pushNamed(context, "/notificationsPage");
          },
          icon: Icon(Icons.add_alert),
        ),
        title: Text("Eathall", style: TextStyle(
          fontFamily: 'Sansita_Swashed',
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.7,
        ),
        ),
      ),
      body: Scaffold(

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