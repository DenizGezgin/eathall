

import 'package:cloud_firestore/cloud_firestore.dart';

class Product
{
  final String? category;
  final String? name;
  final String? displayName;
  final String? seller;
  final String? sellerDisplayName;
  final int? price;
  final bool? isOnSale;
  final String? photoUrl;
  final String? description;
  final List<dynamic>? comments;
  final double? rating;
  final String? sellerMail;
  final int? numberOfRatings;
  final int? sumOfRatings;

  Product({this.category, this.name, this.displayName, this.seller, this.sellerDisplayName, this.price, this.isOnSale, this.photoUrl, this.description, this.comments, this.rating, this.sellerMail, this.numberOfRatings, this.sumOfRatings, });

}
CollectionReference _collectionRef = FirebaseFirestore.instance.collection('products');

Future<List<Product>> getAllData() async {

  QuerySnapshot querySnapshot = await _collectionRef.get();
  //final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  return querySnapshot.docs.map((snapshot) {

    final Map<String, dynamic> dataMap =
    snapshot.data() as Map<String, dynamic>;


    print(dataMap["name"]);

    return Product(
      name: dataMap['name'] ?? "NULL_NAME",
      category: dataMap['category'] ?? "NULL_NAME",
      displayName: dataMap['category'] ?? "NULL_NAME",
      seller: dataMap['seller'] ?? "NULL_NAME",
      sellerDisplayName: dataMap['sellerDisplayName'] ?? "NULL_NAME",
      price: dataMap['price'] ?? 0,
      isOnSale: dataMap['isOnSale'] ?? true,
      photoUrl: dataMap["photoUrl"] ?? "https://www.google.com/search?q=resim&sxsrf=AOaemvK7ZJcn_d10R5R_Ud4anuePvKfTLw:1640451347562&tbm=isch&source=iu&ictx=1&fir=__Sz5QrzgaLGQM%252CQqB-ANoE8WAWxM%252C_%253BsOq7MsHbHDLXMM%252CCby56JbflgexjM%252C_%253BS70l8sydBMSnFM%252CQfjjSjUDG3aNxM%252C_%253BEp-fpHBd4_4fmM%252ChHZhF9HOp-GSTM%252C_%253B1zdi0mQ1-m0qvM%252CFD4f9XfSM9BOyM%252C_%253BnMAwpdurIJpWVM%252ClopRlmOVgH8l9M%252C_%253BTLg1yYGXRaO8RM%252CHnjvaDa-2nsc1M%252C_%253BHz1Zp-C_m3U8UM%252CX3aYi0eT-lR7OM%252C_%253Bu9G6iqYTJ6mB4M%252CPjgHitmFUPexwM%252C_%253B3PB5EWdTJ__kTM%252CQfjjSjUDG3aNxM%252C_%253Bf38-IZ6LUM6OGM%252CjEKL356qqhkyLM%252C_%253Bt5FXRB4rwPQ_CM%252CHywpbdcUr65P-M%252C_%253BzTzg4T1EUp1DBM%252CTqgB9i1x2xK4PM%252C_%253Bi0z-sd7wiQsjBM%252CQM1dtXwplDn0aM%252C_&vet=1&usg=AI4_-kS1KRYCnxuCxGJRbQOZBnx-zWpM2Q&sa=X&ved=2ahUKEwj2od6-tf_0AhXnSfEDHRBUBl4Q9QF6BAgFEAE#imgrc=__Sz5QrzgaLGQM",
      description: dataMap["description"] ?? "NULL_NAME",
      rating: dataMap["rating"] ?? 0.0,
      comments: dataMap["comments"] ?? [],
      sellerMail: dataMap["sellerMail"] ?? "NULL_NAME@gmail.com",
      numberOfRatings: dataMap["numberOfRatings"] ?? 0,
      sumOfRatings: dataMap["sumOfRatings"] ?? 0,
    );

  }).toList();
}

Future<void> addProduct(String namec, String categoryc,String sellerc,int pricec,String descriptionc, String photoUrlc, String sellerMailc) {
  return _collectionRef.doc(namec + sellerc)
      .set({
    'name': namec,
    'displayName': namec,
    'category': categoryc,
    'seller': sellerc,
    'sellerDisplayName': sellerc,
    'price': pricec,
    'description': descriptionc,
    'isOnSale': false,
    'photoUrl': photoUrlc,
    'comments': [],
    "rating" : 0.0,
    "sellerMail": sellerMailc,
    "numberOfRatings": 0,
    "sumOfRatings": 0,
  })
      .then((value) => print("Product Added"))
      .catchError((error) => print("Failed to add product: $error"));
}

Future<Product> getProdcutWithUrl(String url) async{  //productname + seller
  var documentSnapshot = await _collectionRef.doc(url).get();

  print("Getting ${url}");
  if (documentSnapshot.exists) {

    final Map<String, dynamic> dataMap =
    documentSnapshot.data() as Map<String, dynamic>;

    print('Document exists on the database');
    Product finalProduct = Product(
      name: dataMap['name'] ?? "NULL_NAME",
      category: dataMap['category'] ?? "NULL_NAME",
      displayName: dataMap['displayName'] ?? "NULL_NAME",
      seller: dataMap['seller'] ?? "NULL_NAME",
      sellerDisplayName: dataMap['sellerDisplayName'] ?? "NULL_NAME",
      price: dataMap['price'] ?? 0,
      isOnSale: dataMap['isOnSale'] ?? true,
      photoUrl: dataMap["photoUrl"] ?? "https://www.google.com/search?q=resim&sxsrf=AOaemvK7ZJcn_d10R5R_Ud4anuePvKfTLw:1640451347562&tbm=isch&source=iu&ictx=1&fir=__Sz5QrzgaLGQM%252CQqB-ANoE8WAWxM%252C_%253BsOq7MsHbHDLXMM%252CCby56JbflgexjM%252C_%253BS70l8sydBMSnFM%252CQfjjSjUDG3aNxM%252C_%253BEp-fpHBd4_4fmM%252ChHZhF9HOp-GSTM%252C_%253B1zdi0mQ1-m0qvM%252CFD4f9XfSM9BOyM%252C_%253BnMAwpdurIJpWVM%252ClopRlmOVgH8l9M%252C_%253BTLg1yYGXRaO8RM%252CHnjvaDa-2nsc1M%252C_%253BHz1Zp-C_m3U8UM%252CX3aYi0eT-lR7OM%252C_%253Bu9G6iqYTJ6mB4M%252CPjgHitmFUPexwM%252C_%253B3PB5EWdTJ__kTM%252CQfjjSjUDG3aNxM%252C_%253Bf38-IZ6LUM6OGM%252CjEKL356qqhkyLM%252C_%253Bt5FXRB4rwPQ_CM%252CHywpbdcUr65P-M%252C_%253BzTzg4T1EUp1DBM%252CTqgB9i1x2xK4PM%252C_%253Bi0z-sd7wiQsjBM%252CQM1dtXwplDn0aM%252C_&vet=1&usg=AI4_-kS1KRYCnxuCxGJRbQOZBnx-zWpM2Q&sa=X&ved=2ahUKEwj2od6-tf_0AhXnSfEDHRBUBl4Q9QF6BAgFEAE#imgrc=__Sz5QrzgaLGQM",
      description: dataMap["description"] ?? "NULL_NAME",
      rating: dataMap["rating"] ?? 0,
      comments: dataMap["comments"] ?? [],
      sellerMail: dataMap["sellerMail"] ?? "NULL_NAME@gmail.com",
      numberOfRatings: dataMap["numberOfRatings"] ?? 0,
      sumOfRatings: dataMap["sumOfRatings"] ?? 0,
    );
    print(finalProduct.name);
    return finalProduct;
  }
  return Product(
    name: "NULL_NAME",
    category:  "NULL_NAME",
    displayName: "NULL_NAME",
    seller: "NULL_NAME",
    sellerDisplayName: "NULL_NAME",
    price:  0,
    isOnSale:  true,
    photoUrl:  "https://www.google.com/search?q=resim&sxsrf=AOaemvK7ZJcn_d10R5R_Ud4anuePvKfTLw:1640451347562&tbm=isch&source=iu&ictx=1&fir=__Sz5QrzgaLGQM%252CQqB-ANoE8WAWxM%252C_%253BsOq7MsHbHDLXMM%252CCby56JbflgexjM%252C_%253BS70l8sydBMSnFM%252CQfjjSjUDG3aNxM%252C_%253BEp-fpHBd4_4fmM%252ChHZhF9HOp-GSTM%252C_%253B1zdi0mQ1-m0qvM%252CFD4f9XfSM9BOyM%252C_%253BnMAwpdurIJpWVM%252ClopRlmOVgH8l9M%252C_%253BTLg1yYGXRaO8RM%252CHnjvaDa-2nsc1M%252C_%253BHz1Zp-C_m3U8UM%252CX3aYi0eT-lR7OM%252C_%253Bu9G6iqYTJ6mB4M%252CPjgHitmFUPexwM%252C_%253B3PB5EWdTJ__kTM%252CQfjjSjUDG3aNxM%252C_%253Bf38-IZ6LUM6OGM%252CjEKL356qqhkyLM%252C_%253Bt5FXRB4rwPQ_CM%252CHywpbdcUr65P-M%252C_%253BzTzg4T1EUp1DBM%252CTqgB9i1x2xK4PM%252C_%253Bi0z-sd7wiQsjBM%252CQM1dtXwplDn0aM%252C_&vet=1&usg=AI4_-kS1KRYCnxuCxGJRbQOZBnx-zWpM2Q&sa=X&ved=2ahUKEwj2od6-tf_0AhXnSfEDHRBUBl4Q9QF6BAgFEAE#imgrc=__Sz5QrzgaLGQM",
    description:  "NULL_NAME",
    rating:  0.0001,
    comments: [],
    sellerMail: "NULL_NAME@gmail.com",
    numberOfRatings: 0,
    sumOfRatings: 0,
  );
}

Future<void> deleteProduct(String productKey) async{
  return _collectionRef.doc(productKey).delete()
      .then((value) => print("Product Deleted"))
      .catchError((error) => print("Failed to delete product: $error"));
}

Future<void> updateProductRating(String productKey, double raiting) async{
  Product current = await getProdcutWithUrl(productKey);
  double finalRate = (current.rating!*current.numberOfRatings! + raiting)/(current.numberOfRatings! + 1);
  return _collectionRef.doc(productKey)
      .update({
    "rating": finalRate,
    "numberOfRatings" : current.numberOfRatings! + 1,
  })
      .then((value) => print("Rating product Updated"))
      .catchError((error) => print("Failed to update Rating product: $error"));
}

Future<void> addCommentProduct(String productKey, Map<String, dynamic> myComment) async {
  //commentFields: USER + DATA + RATING + ISAPPROVED + USERMAIL + PRODUCTKEY
  List<dynamic> newItem = [myComment];
  _collectionRef.doc(productKey)
      .update({
    "comments": FieldValue.arrayUnion(newItem),
  });
}

Future<void> updateProductName(String productKey, String nameNew) async{
  Product current = await getProdcutWithUrl(productKey);
  return _collectionRef.doc(productKey)
      .update({
    "displayName": nameNew,
  })
      .then((value) => print("name of the product Updated"))
      .catchError((error) => print("Failed to update name of the product: $error"));
}

Future<void> updateProductSellerName(String productKey, String sellerNameNew) async{
  Product current = await getProdcutWithUrl(productKey);
  return _collectionRef.doc(productKey)
      .update({
    "sellerDisplayName": sellerNameNew,
  })
      .then((value) => print("name of the product Updated"))
      .catchError((error) => print("Failed to update name of the product: $error"));
}

Future<void> updateProductCategory(String productKey, String categoryNew) async{
  Product current = await getProdcutWithUrl(productKey);
  return _collectionRef.doc(productKey)
      .update({
    "category": categoryNew,
  })
      .then((value) => print("category of the product Updated"))
      .catchError((error) => print("Failed to update category of the product: $error"));
}

Future<void> updateProductPrice(String productKey, int priceNew) async{
  Product current = await getProdcutWithUrl(productKey);
  return _collectionRef.doc(productKey)
      .update({
    "price": priceNew,
  })
      .then((value) => print("price of the product Updated"))
      .catchError((error) => print("Failed to update price of the product: $error"));
}

Future<void> updateProductDescription(String productKey, String descriptionNew) async{
  Product current = await getProdcutWithUrl(productKey);
  return _collectionRef.doc(productKey)
      .update({
    "description": descriptionNew,
  })
      .then((value) => print("description of the product has been updated"))
      .catchError((error) => print("Failed to update the description of the product: $error"));
}

Future<void> updateProductPhotoUrl(String productKey, String urlNew) async{
  Product current = await getProdcutWithUrl(productKey);
  return _collectionRef.doc(productKey)
      .update({
    "photoUrl": urlNew,
  })
      .then((value) => print("url of the product has been updated"))
      .catchError((error) => print("Failed to update the url of the product: $error"));
}

