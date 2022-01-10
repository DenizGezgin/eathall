import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFirebase
{
  final String? email;
  final String? name;
  final String? surname;
  final String? adress;
  String? photoUrl;
  final List<dynamic>? comments;
  final List<dynamic>? bookmarks;
  final List<dynamic>? credit_cards;

  final List<dynamic>? shopping_card;
  final List<dynamic>? bought_products;
  final List<dynamic>? products_onsale;
  final List<dynamic>? prev_sales;
  final List<dynamic>? comment_approves;
  final List<dynamic>? notifications;
  final bool? disabled;
  final double? averageRating;
  final int? numberOfRatings;


  UserFirebase({this.numberOfRatings, this.prev_sales, this.notifications, this.photoUrl, this.email, this.name, this.surname, this.adress, this.comments, this.bookmarks, this.credit_cards, this.shopping_card, this.bought_products, this.products_onsale, this.comment_approves, this.disabled, this.averageRating});

}
CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users');
CollectionReference _collectionRefDisabled = FirebaseFirestore.instance.collection('disabled_users');

Future<void> updateUserPic(String userMail, String url) async{
  return _collectionRef.doc(userMail)
      .update({
    "photoUrl": url,
  })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

Future<void> updateSoldProducts(String userMail, String productKey) async{
  List<dynamic> newItem = [productKey];
  return _collectionRef.doc(userMail)
      .update({
    "products_onsale": FieldValue.arrayUnion(newItem),
  })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

Future<void> updateCard(String userMail, String productKey) async{
  List<dynamic> newItem = [productKey];
  return _collectionRef.doc(userMail)
      .update({
    "shopping_card": FieldValue.arrayUnion(newItem),
  })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

Future<void> updateBookmark(String userMail, String productKey) async{
  List<dynamic> newItem = [productKey];
  return _collectionRef.doc(userMail)
      .update({
    "bookmarks": FieldValue.arrayUnion(newItem),
  })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

Future<void> addPendingComment(String userMail, String commentData, double finalRate, int index, String productKey, String commenterMail) async{
  //commentFields: USER + DATA + RATING + ISAPPROVED + USERMAIL
  Map<String, dynamic> myComment = {};
  UserFirebase curerntCommenter = await getUserWithMail(commenterMail);
  var listUpdate = curerntCommenter.bought_products!;
  listUpdate[index]["isAlreadyRated"] = true;
  myComment["user"] = curerntCommenter.name! + " " +  curerntCommenter.surname!;
  myComment["data"] = commentData;
  myComment["productKey"] = productKey;
  myComment["rating"] = finalRate;
  myComment["userMail"] = curerntCommenter.email!;
  myComment["isApproved"] = false;
  List<dynamic> newItem = [myComment];
  _collectionRef.doc(commenterMail)
      .update({
    "bought_products": listUpdate,
  });
  return _collectionRef.doc(userMail)
      .update({
    "comment_approves": FieldValue.arrayUnion(newItem),
  })
      .then((value) => print("Comment Added to approve list Updated"))
      .catchError((error) => print("Failed toComment Added to approve list user: $error"));
}

Future<void> addAprrovedComment(String userMail, Map<String, dynamic> myComment) async{
  //commentFields: USER + DATA + RATING + ISAPPROVED + USERMAIL + PRODUCTKEY
  List<dynamic> newItem = [myComment];
  _collectionRef.doc(userMail)
      .update({
    "comment_approves": FieldValue.arrayRemove(newItem),
  });

  return _collectionRef.doc(userMail)
      .update({
    "comments": FieldValue.arrayUnion(newItem),
  })
      .then((value) => print("Comment Added to approve list Updated"))
      .catchError((error) => print("Failed toComment Added to approve list user: $error"));
}

Future<void> updateUserRating(String userMail, double raiting) async{
  UserFirebase current = await getUserWithMail(userMail);
  double finalRate = (current.averageRating!*current.numberOfRatings! + raiting)/(current.numberOfRatings! + 1);
  return _collectionRef.doc(userMail)
      .update({
  "averageRating": finalRate,
  "numberOfRatings" : current.numberOfRatings! + 1,
  })
      .then((value) => print("Rating USER Updated"))
      .catchError((error) => print("Failed to update Rating USER: $error"));
}

Future<void> removeFromCard(String userMail, String productKey) async{
  List<dynamic> newItem = [productKey];
  return _collectionRef.doc(userMail)
      .update({
    "shopping_card": FieldValue.arrayRemove(newItem),
  })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}


Future<UserFirebase> getUserWithMail(String userMail) async{
  var documentSnapshot = await _collectionRef.doc(userMail).get();

  print("Getting ${userMail}");
  if (documentSnapshot.exists) {

    final Map<String, dynamic> dataMap =
    documentSnapshot.data() as Map<String, dynamic>;

    print('Document exists on the database');
    UserFirebase finalUser = UserFirebase(
      email: dataMap['email'] ?? "NULL_NAME",
      name: dataMap['name'] ?? "NULL_NAME",
      surname: dataMap['surname'] ?? "NULL_NAME",
      adress: dataMap['adress'] ?? "NULL_NAME",
      photoUrl: dataMap["photoUrl"] ?? "https://freepikpsd.com/file/2019/10/default-profile-picture-png-1-Transparent-Images.png",
      comments: dataMap["comments"] ?? [],
      bookmarks: dataMap["bookmarks"] ?? [],
      credit_cards: dataMap["credit_cards"] ?? [],

      shopping_card: dataMap["shopping_card"] ?? [],
      bought_products: dataMap["bought_products"] ?? [],
      products_onsale: dataMap["products_onsale"] ?? [],
      comment_approves: dataMap["comment_approves"] ?? [],
      notifications: dataMap["notifications"] ?? [],
      prev_sales: dataMap["prev_sales"] ?? [],
      averageRating: dataMap["averageRating"] ?? 0.00001,
      numberOfRatings: dataMap["numberOfRatings"] ?? 0,
      disabled: dataMap["disabled"] ?? false,
    );
    print(finalUser.name);
    return finalUser;
  }

  return UserFirebase(
    email: "NULL_NAME",
    name: "NULL_NAME",
    surname:"NULL_NAME",
    adress: "NULL_NAME",
    photoUrl: "https://freepikpsd.com/file/2019/10/default-profile-picture-png-1-Transparent-Images.png",
    comments: [],
    bookmarks: [],
    credit_cards: [],
    disabled: false,
    shopping_card: [],
    bought_products: [],
    products_onsale: [],
    comment_approves: [],
    notifications: [],
    prev_sales: [],
    numberOfRatings: 0,
    averageRating: 0.00001,
  );
}

Future<void> addUser(String emailc, String namec,String surnamec,String adressc) async{
  return _collectionRef.doc(emailc)
      .set({
    "email": emailc,
    "name": namec,
    "surname": surnamec,
    "adress": adressc,
    "photoUrl": "https://freepikpsd.com/file/2019/10/default-profile-picture-png-1-Transparent-Images.png",
    "comments": [],
    "bookmarks": [],
    "credit_cards": [],
    "disabled": false,
    "shopping_card": [],
    "bought_products": [],
    "products_onsale": [],
    "comment_approves": [],
    "notifications": [],
    "prev_sales": [],
    "numberOfRatings" : 0,
    "averageRating": 0.00001,
  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user product: $error"));
}

Future<void> deleteUser(String userMail) async{
  return _collectionRef.doc(userMail).delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user product: $error"));
}

Future<void> disableUser(String userMail) async{

  UserFirebase myUser = await getUserWithMail(userMail);

  _collectionRefDisabled.doc(myUser.email)
      .set({
    "email": myUser.email,
    "name": myUser.name,
    "surname": myUser.surname,
    "adress": myUser.adress,
    "photoUrl": myUser.photoUrl,
    "comments": myUser.comments,
    "bookmarks": myUser.bookmarks,
    "credit_cards": myUser.bought_products,
    "disabled": false,
    "shopping_card": myUser.shopping_card,
    "bought_products": myUser.bought_products,
    "products_onsale": myUser.products_onsale,
    "comment_approves": myUser.comment_approves,
    "averageRating": myUser.averageRating,
    "prev_sales": myUser.prev_sales,
    "notifications": myUser.notifications,
    "numberOfRatings": myUser.numberOfRatings,
  })
      .then((value) => print("User Saved to Disabled"))
      .catchError((error) => print("Failed to add disable: $error"));


  return _collectionRef.doc(userMail).delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user product: $error"));
}

Future<UserFirebase> getDisabledUserWithMail(String userMail) async{
  var documentSnapshot = await _collectionRefDisabled.doc(userMail).get();

  print("Getting ${userMail}");
  if (documentSnapshot.exists) {

    final Map<String, dynamic> dataMap =
    documentSnapshot.data() as Map<String, dynamic>;

    print('Document exists on the database');
    UserFirebase finalUser = UserFirebase(
      email: dataMap['email'] ?? "NULL_NAME",
      name: dataMap['name'] ?? "NULL_NAME",
      surname: dataMap['surname'] ?? "NULL_NAME",
      adress: dataMap['adress'] ?? "NULL_NAME",
      photoUrl: dataMap["photoUrl"] ?? "https://freepikpsd.com/file/2019/10/default-profile-picture-png-1-Transparent-Images.png",
      comments: dataMap["comments"] ?? [],
      bookmarks: dataMap["bookmarks"] ?? [],
      credit_cards: dataMap["credit_cards"] ?? [],

      shopping_card: dataMap["shopping_card"] ?? [],
      bought_products: dataMap["bought_products"] ?? [],
      products_onsale: dataMap["products_onsale"] ?? [],
      prev_sales: dataMap["prev_sales"] ?? [],
      comment_approves: dataMap["comment_approves"] ?? [],
      notifications: dataMap["notifications"] ?? [],
      averageRating: dataMap["averageRating"] ?? 0.00001,
      numberOfRatings: dataMap["numberOfRatings"] ?? 0,
      disabled: dataMap["disabled"] ?? false,
    );
    print(finalUser.name);
    return finalUser;
  }

  return UserFirebase(
    email: "NULL_NAME",
    name: "NULL_NAME",
    surname:"NULL_NAME",
    adress: "NULL_NAME",
    photoUrl: "https://freepikpsd.com/file/2019/10/default-profile-picture-png-1-Transparent-Images.png",
    comments: [],
    bookmarks: [],
    credit_cards: [],
    disabled: false,
    shopping_card: [],
    bought_products: [],
    products_onsale: [],
    comment_approves: [],
    prev_sales: [],
    notifications: [],
    numberOfRatings: 0,
    averageRating: 0.00001,
  );
}

Future<void> enableUser(String userMail) async{

  UserFirebase myUser = await getDisabledUserWithMail(userMail);

  _collectionRef.doc(myUser.email)
      .set({
    "email": myUser.email,
    "name": myUser.name,
    "surname": myUser.surname,
    "adress": myUser.adress,
    "photoUrl": myUser.photoUrl,
    "comments": myUser.comments,
    "bookmarks": myUser.bookmarks,
    "credit_cards": myUser.bought_products,
    "disabled": false,
    "shopping_card": myUser.shopping_card,
    "bought_products": myUser.bought_products,
    "products_onsale": myUser.products_onsale,
    "comment_approves": myUser.comment_approves,
    "prev_sales": myUser.prev_sales,
    "averageRating": myUser.averageRating,
    "notifications": myUser.notifications,
    "numberOfRatings": myUser.numberOfRatings,
  })
      .then((value) => print("User Saved to Disabled"))
      .catchError((error) => print("Failed to add disable: $error"));


  return _collectionRefDisabled.doc(userMail).delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user product: $error"));
}

//calculate average rating