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



    /*Future<void> showAlertDialog(String message, double discount, int lim) async {
      return showDialog(context: context,
          barrierDismissible: false, //must take action
          builder: (BuildContext context)
          {
            if (isIOS) {
              return CupertinoAlertDialog( //styling is not always auto adjusted
                title: Text("Success"),
                content: SingleChildScrollView(
                  child: Text("The discount will be applied for your next purchase:\n${message}"),
                ),
                actions: [
                  TextButton(onPressed: () {
                    updateDiscount(widget.myUser!.email!, discount);
                    updateLim(widget.myUser!.email!, lim);
                    Navigator.of(context).pop(); //pop the current alert view
                  },
                      child: Text("OK")),
                ],
              );
            }
            else {
              return AlertDialog(
                title: Text("Success"),
                content: SingleChildScrollView(
                  child: Text("The discount will be applied for your next purchase:\n${message}"),
                ),
                actions: [
                  TextButton(onPressed: () {
                    updateDiscount(widget.myUser!.email!, discount);
                    updateLim(widget.myUser!.email!, lim);
                    Navigator.of(context).pop(); //pop the current alert view
                  },
                      child: Text(
                          "OK", style: TextStyle(color: AppColors.purchaseAndAdd))),
                ],
              );
            }
          }
      );
    }*/


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
                  /*OutlinedButton(onPressed: (){
                    //showAlertDialog("10% discount for minimum 50TL purchases", 10.0, 50);
                  },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: AppColors.purchaseAndAdd,
                        side: BorderSide(color: AppColors.purchaseAndAdd, width: 1),
                      ),
                      child: Text("Apply\nDiscount")),*/
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
                  /*OutlinedButton(onPressed: (){
                    showAlertDialog("15% discount for minimum 75TL purchases", 15.0, 75);
                  },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: AppColors.purchaseAndAdd,
                        side: BorderSide(color: AppColors.purchaseAndAdd, width: 1),
                      ),
                      child: Text("Apply\nDiscount")),*/
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
                  /*OutlinedButton(onPressed: (){
                    showAlertDialog("5% discount for all products", 5.0, 0);
                  },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: AppColors.purchaseAndAdd,
                        side: BorderSide(color: AppColors.purchaseAndAdd, width: 1),
                      ),
                      child: Text("Apply\nDiscount")),*/
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
                  /*OutlinedButton(onPressed: (){
                    showAlertDialog("20% discount for minimum 100TL purchases", 20.0, 100);
                  },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: AppColors.purchaseAndAdd,
                        side: BorderSide(color: AppColors.purchaseAndAdd, width: 1),
                      ),
                      child: Text("Apply\nDiscount")),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}