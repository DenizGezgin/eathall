import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class notification{
  final String? msg;
  String? date;
  String? hour;

  notification({required this.msg}){
    DateTime dateToday =new DateTime.now();
    String dateN = dateToday.toString().substring(0,10);
    //String hourN = dateToday.toString().substring(11,10);
    String hourN = "hour";
    date = dateN;
    hour = hourN;
  }
}




CollectionReference _collectionRef = FirebaseFirestore.instance.collection('notifications');

Future<notification> getProdcutWithUrl(String url) async{  //productname + seller
  var documentSnapshot = await _collectionRef.doc(url).get();

  print("Getting ${url}");
  if (documentSnapshot.exists) {

    final Map<String, dynamic> dataMap =
    documentSnapshot.data() as Map<String, dynamic>;

    print('Document exists on the database');
    notification finalNotification = notification(
      msg: dataMap['msg'] ?? "NULL",
    );
    print(finalNotification.msg);
    return finalNotification;
  }
  return notification(
    msg: "NULL_NAME",
  );
}

Future<void> deleteProduct(String notifKey) async{
  return _collectionRef.doc(notifKey).delete()
      .then((value) => print("Notification Deleted"))
      .catchError((error) => print("Failed to delete notification: $error"));
}