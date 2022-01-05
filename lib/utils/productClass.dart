

import 'package:cloud_firestore/cloud_firestore.dart';

class Product
{
  final String? category;
  final String? name;
  final String? seller;
  final int? price;
  final bool? isOnSale;
  final String? photoUrl;
  final String? description;
  final List<dynamic>? comments;
  final double? rating;

  Product({this.name, this.category, this.seller, this.price, this.isOnSale, this.description, this.photoUrl, this.comments, this.rating});

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
      seller: dataMap['seller'] ?? "NULL_NAME",
      price: dataMap['price'] ?? 0,
      isOnSale: dataMap['isOnSale'] ?? true,
      photoUrl: dataMap["photoUrl"] ?? "https://www.google.com/search?q=resim&sxsrf=AOaemvK7ZJcn_d10R5R_Ud4anuePvKfTLw:1640451347562&tbm=isch&source=iu&ictx=1&fir=__Sz5QrzgaLGQM%252CQqB-ANoE8WAWxM%252C_%253BsOq7MsHbHDLXMM%252CCby56JbflgexjM%252C_%253BS70l8sydBMSnFM%252CQfjjSjUDG3aNxM%252C_%253BEp-fpHBd4_4fmM%252ChHZhF9HOp-GSTM%252C_%253B1zdi0mQ1-m0qvM%252CFD4f9XfSM9BOyM%252C_%253BnMAwpdurIJpWVM%252ClopRlmOVgH8l9M%252C_%253BTLg1yYGXRaO8RM%252CHnjvaDa-2nsc1M%252C_%253BHz1Zp-C_m3U8UM%252CX3aYi0eT-lR7OM%252C_%253Bu9G6iqYTJ6mB4M%252CPjgHitmFUPexwM%252C_%253B3PB5EWdTJ__kTM%252CQfjjSjUDG3aNxM%252C_%253Bf38-IZ6LUM6OGM%252CjEKL356qqhkyLM%252C_%253Bt5FXRB4rwPQ_CM%252CHywpbdcUr65P-M%252C_%253BzTzg4T1EUp1DBM%252CTqgB9i1x2xK4PM%252C_%253Bi0z-sd7wiQsjBM%252CQM1dtXwplDn0aM%252C_&vet=1&usg=AI4_-kS1KRYCnxuCxGJRbQOZBnx-zWpM2Q&sa=X&ved=2ahUKEwj2od6-tf_0AhXnSfEDHRBUBl4Q9QF6BAgFEAE#imgrc=__Sz5QrzgaLGQM",
      description: dataMap["description"] ?? "NULL_NAME",
      rating: dataMap["rating"] ?? 0.0,
      comments: dataMap["comments"] ?? [],
    );

  }).toList();
}

Future<void> addProduct(String namec, String categoryc,String sellerc,int pricec,String descriptionc, String photoUrlc) {
  return _collectionRef.doc(namec + sellerc)
      .set({
    'name': namec,
    'category': categoryc,
    'seller': sellerc,
    'price': pricec,
    'description': descriptionc,
    'isOnSale': true,
    'photoUrl': photoUrlc,
    'comments': [],
    "rating" : 0.0,
  })
      .then((value) => print("Product Added"))
      .catchError((error) => print("Failed to add product: $error"));
}

Future<Product> getProdcutWithUrl(String url) async{
  var documentSnapshot = await _collectionRef.doc(url).get();

  print("Getting ${url}");
  if (documentSnapshot.exists) {

    final Map<String, dynamic> dataMap =
    documentSnapshot.data() as Map<String, dynamic>;

    print('Document exists on the database');
    Product finalProduct = Product(
      name: dataMap['name'] ?? "NULL_NAME",
      category: dataMap['category'] ?? "NULL_NAME",
      seller: dataMap['seller'] ?? "NULL_NAME",
      price: dataMap['price'] ?? 0,
      isOnSale: dataMap['isOnSale'] ?? true,
      photoUrl: dataMap["photoUrl"] ?? "https://www.google.com/search?q=resim&sxsrf=AOaemvK7ZJcn_d10R5R_Ud4anuePvKfTLw:1640451347562&tbm=isch&source=iu&ictx=1&fir=__Sz5QrzgaLGQM%252CQqB-ANoE8WAWxM%252C_%253BsOq7MsHbHDLXMM%252CCby56JbflgexjM%252C_%253BS70l8sydBMSnFM%252CQfjjSjUDG3aNxM%252C_%253BEp-fpHBd4_4fmM%252ChHZhF9HOp-GSTM%252C_%253B1zdi0mQ1-m0qvM%252CFD4f9XfSM9BOyM%252C_%253BnMAwpdurIJpWVM%252ClopRlmOVgH8l9M%252C_%253BTLg1yYGXRaO8RM%252CHnjvaDa-2nsc1M%252C_%253BHz1Zp-C_m3U8UM%252CX3aYi0eT-lR7OM%252C_%253Bu9G6iqYTJ6mB4M%252CPjgHitmFUPexwM%252C_%253B3PB5EWdTJ__kTM%252CQfjjSjUDG3aNxM%252C_%253Bf38-IZ6LUM6OGM%252CjEKL356qqhkyLM%252C_%253Bt5FXRB4rwPQ_CM%252CHywpbdcUr65P-M%252C_%253BzTzg4T1EUp1DBM%252CTqgB9i1x2xK4PM%252C_%253Bi0z-sd7wiQsjBM%252CQM1dtXwplDn0aM%252C_&vet=1&usg=AI4_-kS1KRYCnxuCxGJRbQOZBnx-zWpM2Q&sa=X&ved=2ahUKEwj2od6-tf_0AhXnSfEDHRBUBl4Q9QF6BAgFEAE#imgrc=__Sz5QrzgaLGQM",
      description: dataMap["description"] ?? "NULL_NAME",
      rating: dataMap["rating"] ?? 0,
      comments: dataMap["comments"] ?? [],
    );
    print(finalProduct.name);
    return finalProduct;
  }
  return Product(
    name: "NULL_NAME",
    category:  "NULL_NAME",
    seller: "NULL_NAME",
    price:  0,
    isOnSale:  true,
    photoUrl:  "https://www.google.com/search?q=resim&sxsrf=AOaemvK7ZJcn_d10R5R_Ud4anuePvKfTLw:1640451347562&tbm=isch&source=iu&ictx=1&fir=__Sz5QrzgaLGQM%252CQqB-ANoE8WAWxM%252C_%253BsOq7MsHbHDLXMM%252CCby56JbflgexjM%252C_%253BS70l8sydBMSnFM%252CQfjjSjUDG3aNxM%252C_%253BEp-fpHBd4_4fmM%252ChHZhF9HOp-GSTM%252C_%253B1zdi0mQ1-m0qvM%252CFD4f9XfSM9BOyM%252C_%253BnMAwpdurIJpWVM%252ClopRlmOVgH8l9M%252C_%253BTLg1yYGXRaO8RM%252CHnjvaDa-2nsc1M%252C_%253BHz1Zp-C_m3U8UM%252CX3aYi0eT-lR7OM%252C_%253Bu9G6iqYTJ6mB4M%252CPjgHitmFUPexwM%252C_%253B3PB5EWdTJ__kTM%252CQfjjSjUDG3aNxM%252C_%253Bf38-IZ6LUM6OGM%252CjEKL356qqhkyLM%252C_%253Bt5FXRB4rwPQ_CM%252CHywpbdcUr65P-M%252C_%253BzTzg4T1EUp1DBM%252CTqgB9i1x2xK4PM%252C_%253Bi0z-sd7wiQsjBM%252CQM1dtXwplDn0aM%252C_&vet=1&usg=AI4_-kS1KRYCnxuCxGJRbQOZBnx-zWpM2Q&sa=X&ved=2ahUKEwj2od6-tf_0AhXnSfEDHRBUBl4Q9QF6BAgFEAE#imgrc=__Sz5QrzgaLGQM",
    description:  "NULL_NAME",
    rating:  0,
    comments: [],
  );
}