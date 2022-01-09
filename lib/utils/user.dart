import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebase
{
  final String? email;
  final String? name;
  final String? surname;
  final String? adress;
  String? photoUrl;
  final List<dynamic>? comments;
  final List<dynamic>? bookmarks;
  final List<dynamic>? likes;
  final List<dynamic>? credit_cards;
  //final bool? disabled;
  //final List<dynamic>? productsOnSale;
  //final List<dynamic>? soldProducts;
  //final double? averageRating;

  UserFirebase({this.email, this.name, this.surname, this.adress, this.photoUrl, this.comments, this.bookmarks, this.likes, this.credit_cards, /*this.disabled*/});

}
CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users');

Future<void> updateUserPic(String userMail, String url) async{
  return _collectionRef.doc(userMail)
      .update({
    "photoUrl": url,
  })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to add user product: $error"));
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
      photoUrl: dataMap["photoUrl"] ?? "https://www.google.com/search?q=resim&sxsrf=AOaemvK7ZJcn_d10R5R_Ud4anuePvKfTLw:1640451347562&tbm=isch&source=iu&ictx=1&fir=__Sz5QrzgaLGQM%252CQqB-ANoE8WAWxM%252C_%253BsOq7MsHbHDLXMM%252CCby56JbflgexjM%252C_%253BS70l8sydBMSnFM%252CQfjjSjUDG3aNxM%252C_%253BEp-fpHBd4_4fmM%252ChHZhF9HOp-GSTM%252C_%253B1zdi0mQ1-m0qvM%252CFD4f9XfSM9BOyM%252C_%253BnMAwpdurIJpWVM%252ClopRlmOVgH8l9M%252C_%253BTLg1yYGXRaO8RM%252CHnjvaDa-2nsc1M%252C_%253BHz1Zp-C_m3U8UM%252CX3aYi0eT-lR7OM%252C_%253Bu9G6iqYTJ6mB4M%252CPjgHitmFUPexwM%252C_%253B3PB5EWdTJ__kTM%252CQfjjSjUDG3aNxM%252C_%253Bf38-IZ6LUM6OGM%252CjEKL356qqhkyLM%252C_%253Bt5FXRB4rwPQ_CM%252CHywpbdcUr65P-M%252C_%253BzTzg4T1EUp1DBM%252CTqgB9i1x2xK4PM%252C_%253Bi0z-sd7wiQsjBM%252CQM1dtXwplDn0aM%252C_&vet=1&usg=AI4_-kS1KRYCnxuCxGJRbQOZBnx-zWpM2Q&sa=X&ved=2ahUKEwj2od6-tf_0AhXnSfEDHRBUBl4Q9QF6BAgFEAE#imgrc=__Sz5QrzgaLGQM",
      comments: dataMap["comments"] ?? [],
      bookmarks: dataMap["bookmarks"] ?? [],
      likes: dataMap["likes"] ?? [],
      credit_cards: dataMap["credit_cards"] ?? [],
      //disabled: dataMap["disabled"] ?? true,
    );
    print(finalUser.name);
    return finalUser;
  }

  return UserFirebase(
    email: "NULL_NAME",
    name: "NULL_NAME",
    surname:"NULL_NAME",
    adress: "NULL_NAME",
    photoUrl: "https://www.google.com/search?q=resim&sxsrf=AOaemvK7ZJcn_d10R5R_Ud4anuePvKfTLw:1640451347562&tbm=isch&source=iu&ictx=1&fir=__Sz5QrzgaLGQM%252CQqB-ANoE8WAWxM%252C_%253BsOq7MsHbHDLXMM%252CCby56JbflgexjM%252C_%253BS70l8sydBMSnFM%252CQfjjSjUDG3aNxM%252C_%253BEp-fpHBd4_4fmM%252ChHZhF9HOp-GSTM%252C_%253B1zdi0mQ1-m0qvM%252CFD4f9XfSM9BOyM%252C_%253BnMAwpdurIJpWVM%252ClopRlmOVgH8l9M%252C_%253BTLg1yYGXRaO8RM%252CHnjvaDa-2nsc1M%252C_%253BHz1Zp-C_m3U8UM%252CX3aYi0eT-lR7OM%252C_%253Bu9G6iqYTJ6mB4M%252CPjgHitmFUPexwM%252C_%253B3PB5EWdTJ__kTM%252CQfjjSjUDG3aNxM%252C_%253Bf38-IZ6LUM6OGM%252CjEKL356qqhkyLM%252C_%253Bt5FXRB4rwPQ_CM%252CHywpbdcUr65P-M%252C_%253BzTzg4T1EUp1DBM%252CTqgB9i1x2xK4PM%252C_%253Bi0z-sd7wiQsjBM%252CQM1dtXwplDn0aM%252C_&vet=1&usg=AI4_-kS1KRYCnxuCxGJRbQOZBnx-zWpM2Q&sa=X&ved=2ahUKEwj2od6-tf_0AhXnSfEDHRBUBl4Q9QF6BAgFEAE#imgrc=__Sz5QrzgaLGQM",
    comments: [],
    bookmarks: [],
    likes:  [],
    credit_cards: [],
    //disabled: true,
  );
}

Future<void> addUser(String namec, String emailc,String surnamec,String adressc) async{
  return _collectionRef.doc(namec)
      .set({
    "email": namec,
    "name": emailc,
    "surname": surnamec,
    "adress": adressc,
    "photoUrl": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dreamstime.com%2Fdefault-avatar-profile-flat-icon-social-media-user-vector-portrait-unknown-human-image-default-avatar-profile-flat-icon-image184330869&psig=AOvVaw3d6iMZWTwaLMaEdmnv4tYE&ust=1640691045646000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNCw3cnwg_UCFQAAAAAdAAAAABAD",
    "comments": [],
    "bookmarks": [],
    "likes":  [],
    "credit_cards": [],
    //"disabled": false,
  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user product: $error"));
}

Future<void> deleteUser(String userMail) async{
  return _collectionRef.doc(userMail).delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user product: $error"));
}


//calculate average rating