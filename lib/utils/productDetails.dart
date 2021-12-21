import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? category;
  final String? name;
  final String? seller;
  final int? price;
  final bool? isOnSale;

  DataModel({this.name, this.category, this.seller, this.price, this.isOnSale});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold
  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      print(dataMap["name"]);

      return DataModel(
          name: dataMap['name'],
          category: dataMap['category'],
          seller: dataMap['seller'],
          price: dataMap['price'],
          isOnSale: dataMap['isOnSale']);

    }).toList();
  }
}