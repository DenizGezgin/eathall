import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? category;
  final String? name;
  final String? seller;
  final int? price;
  final bool? isOnSale;
  final String? photoUrl;
  final String? sellerMail;
  final String? sellerDisplay;
  final String? productDisplay;

  DataModel({this.name, this.category, this.seller, this.price, this.isOnSale, this.photoUrl, this.sellerMail, this.sellerDisplay, this.productDisplay});

  List<DataModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;
      return DataModel(
          name: dataMap['name'],
          category: dataMap['category'],
          seller: dataMap['seller'], //sellerı user id ile tutmaliyiz ki buyerlarin gordugu seller profilea passlayabilelim
          price: dataMap['price'] ?? 0,
          isOnSale: dataMap['isOnSale'] ?? true,
          photoUrl: dataMap["photoUrl"] ?? "https://i.nefisyemektarifleri.com/2009/02/menemen.jpg",
          sellerMail: dataMap["sellerMail"],
          sellerDisplay: dataMap["sellerDisplayName"],
          productDisplay: dataMap["displayName"],
      );



    }).toList();
  }
}