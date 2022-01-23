import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class notification{
  String? msg;
  String? date;
  String? hour;

  notification({this.msg, this.hour, this.date}){
    /*
    DateTime dateToday =new DateTime.now();
    String dateN = dateToday.toString().substring(0,10);
    //String hourN = dateToday.toString().substring(11,10);
    String hourN = "hour";
    date = dateN;
    hour = hourN;
     */
  }}

CollectionReference _collectionRef = FirebaseFirestore.instance.collection('notifications');

Future<List<notification>> getAllData() async {

  QuerySnapshot querySnapshot = await _collectionRef.get();
  //final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  return querySnapshot.docs.map((snapshot) {

    final Map<String, dynamic> dataMap =
    snapshot.data() as Map<String, dynamic>;

    print(dataMap["notification"]);

    return notification(
      msg: dataMap['msg'] ?? "NULL_NAME",
      date: dataMap['date'] ?? "NULL_NAME",
      hour: dataMap['hour'] ?? "NULL_NAME",
    );
  }).toList();
}

Future<void> addNotification(String msg, String date,String hour) {
  return _collectionRef.doc(msg + date + hour)
      .set({
    'msg': msg,
    'date': date,
    'hour': hour,
  })
      .then((value) => print("Notification Added"))
      .catchError((error) => print("Failed to add notification: $error"));
}

Future<notification> getNotificationWithUrl(String url) async{  //productname + seller
  var documentSnapshot = await _collectionRef.doc(url).get();

  print("Getting ${url}");
  if (documentSnapshot.exists) {

    final Map<String, dynamic> dataMap =
    documentSnapshot.data() as Map<String, dynamic>;

    print('Document exists on the database');
    notification finalNotification = notification(
      msg: dataMap['msg'] ?? "NULL",
      date: dataMap['date'] ?? "NULL_NAME",
      hour: dataMap['hour'] ?? "NULL_NAME",
    );
    print(finalNotification.msg);
    return finalNotification;
  }
  return notification(
    msg: "NULL_NAME",
    date: "NULL_NAME",
    hour: "NULL_NAME",
  );
}

Future<void> deleteNotification(String notifKey) async{
  return _collectionRef.doc(notifKey).delete()
      .then((value) => print("Notification Deleted"))
      .catchError((error) => print("Failed to delete notification: $error"));
}

class CartTileNotification extends StatelessWidget {

  final notification notif;
  final VoidCallback delete;

  const CartTileNotification({required this.notif, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shadowColor: AppColors.primary,
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                notif.msg.toString(),
              ),
            ),

            Row(
              children: [
                Text(
                  "Date: ${notif.date.toString()}",
                ),

                Spacer(),
                Text("${notif.hour.toString()}"),

              ],
            ),
          ],
        ),
      ),
    );
  }
}