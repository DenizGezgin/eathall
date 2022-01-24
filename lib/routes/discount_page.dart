import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class DiscountsPage extends StatefulWidget {
  @override
  State<DiscountsPage> createState() => _DiscountsPageState();
  DiscountsPage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;



}



class  _DiscountsPageState extends State<DiscountsPage>{


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginToContinueBackGround,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRect(
                      child: Image.asset("assets/images/10_50.png", fit: BoxFit.fill, height: 170, width: 355,),
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRect(
                      child: Image.asset("assets/images/15_75.png", fit: BoxFit.fill, height: 170, width: 355,),
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRect(
                      child: Image.asset("assets/images/5_0.png", fit: BoxFit.fill, height: 170, width: 355,),
                    ),
                  ),

                ],

              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRect(
                      child: Image.asset("assets/images/20_100.png", fit: BoxFit.fill, height: 170, width: 355,),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}