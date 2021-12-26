import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'package:cs310_step3/main.dart';
import 'package:cs310_step3/utils/notificationClass.dart';

import 'login_page.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<NotificationsPage> createState() => _NotificaitonsPageState();
}

class _NotificaitonsPageState extends State<NotificationsPage>{
  int counter = 0;
  List<notification> entries = [];

  buttonPressed() {
    setState(() {
      counter++;
      print(counter);
      addNotification(entries, notification("Notification message ${counter}"));
    });
  }

  @override
  Widget build(BuildContext context) {

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
      body: Center(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        showAlertDialog("Notification Heading", "Notification Description");
                      },
                          icon: Icon(Icons.notifications, size: 25, color: Colors.grey)),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              message(),
                              timeAndDate(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),Divider(
                color: AppColors.primary,
                thickness: 0.5,
              ),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        showAlertDialog("Notification Heading", "Notification Description");
                      },
                          icon: Icon(Icons.notifications, size: 25, color: Colors.grey)),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              message(),
                              timeAndDate(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),Divider(
                color: AppColors.primary,
                thickness: 0.5,
              ),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        showAlertDialog("Notification Heading", "Notification Description");
                      },
                          icon: Icon(Icons.notifications, size: 25, color: Colors.grey)),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              message(),
                              timeAndDate(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Divider(
                color: AppColors.primary,
                thickness: 0.5,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        showAlertDialog("Notification Heading", "Notification Description");
                      },
                          icon: Icon(Icons.notifications, size: 25, color: Colors.grey)),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              message(),
                              timeAndDate(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Divider(
                color: AppColors.primary,
                thickness: 0.5,
              ),
            ],
          )
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
            icon: Icon(Icons.shopping_cart, color: Colors.white,),
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

void addNotification(List<notification> entries, notification notif) {
  entries.add(notif);
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