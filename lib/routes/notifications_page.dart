import 'package:cs310_step3/routes/redirection_page.dart';
import 'package:cs310_step3/utils/cart_tile.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'package:cs310_step3/main.dart';
import 'package:cs310_step3/utils/notificationClass.dart';

import 'login_page.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificaitonsPageState();
  NotificationsPage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;
}

String theUser = "";

class _NotificaitonsPageState extends State<NotificationsPage>{
  int counter = 0;
  List<notification> myNotifications = [];

  Future<void> asyncMethod() async {
    myNotifications = await getNotifications();
    setState(() {

    });
  }

  void initState() {
    asyncMethod();
    super.initState();
  }

  Future<List<notification>> getNotifications() async {
    List<notification> myNotificationPrev = [];
    widget.myUser = await getUserWithMail(widget.myUser!.email!);
    List<dynamic> myKeys = widget.myUser!.notifications!;
    for(dynamic key in myKeys)
    {
      notification current = notification();

      current.msg = key["msg"];
      current.hour = key["hour"];
      current.date = key["date"];
      myNotificationPrev.add(current);
    }


    for(notification n in myNotificationPrev){
      print(n.msg);
      print(n.hour);
      print(n.date);
    }


    return myNotificationPrev;
  }

  buttonPressed() {
    setState(() {
      counter++;
      print(counter);
      //addNotification(myNotifications, notification("Notification message", "date", "hour"));
    });
  }
  pressButton(){
    addNotificaitonToUser(widget.myUser!.email!, "notificationExample");
    addNotificaitonToUser(widget.myUser!.email!, "notificationExample2");

  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    Future<void> showAlertDialog(String title, String message) async {
      return showDialog(context: context,
          barrierDismissible: false, //must take action
          builder: (BuildContext context) {
            if(isIOS) {
              return CupertinoAlertDialog( //styling is not always auto adjusted
                title: Text(title),
                content: SingleChildScrollView(
                  child: Text(message),
                ),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(); //pop the current alert view
                  },
                      child: Text("OK"))
                ],
              );
            }
            else{
              return AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(
                  child: Text(message),
                ),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(); //pop the current alert view
                  },
                      child: Text("OK"))
                ],
              );
            }
          }
      );
    }

    if(user != null)
    {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
            backgroundColor: AppColors.primary,
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Text("Current userrr" + widget.myUser!.name!),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: myNotifications.map(
                          (notificationOf) =>
                          CartTileNotification(
                            notif: notificationOf,
                            delete: () {

                              asyncMethod();
                              setState(() {
                              });
                            },)
                  ).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async{
                      await clearNotificationsList(widget.myUser!.email!);

                      setState(() {

                      });
                    },
                    child: Text("Delete all notifications", style: TextStyle(color: Colors.black)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,),
                  ),
                ],
              ),
            ],
          ),
        ),

      );
    }
    else {
      return RedirectionPage();

    }
  }

  Widget prefixIcon(){
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Icon(Icons.notifications, size: 25, color: Colors.grey),
    );
  }

  Widget message(){
    double textSize = 14;
    return Container(
        child: RichText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              text: "Message ",
              style: TextStyle(
                  fontSize: textSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                  text: "Notification Description",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]
          ),
        )
    );
  }

  Widget timeAndDate(){
    DateTime dateToday =new DateTime.now();
    //String hour = dateToday.toString().substring(10,4);
    String dateN = dateToday.toString().substring(0,10);
    String hourN = "hour";
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dateN,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          Text(
            hourN,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

}


Widget displayNotifications(List<notification> entries){
  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: entries.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 50,
        color: Colors.amber,
        child: Center(
            child: Column(
              children: [
                Text('${entries[index].msg}'),
                Text('${entries[index].date} - ${entries[index].hour}')
              ],
            )
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}