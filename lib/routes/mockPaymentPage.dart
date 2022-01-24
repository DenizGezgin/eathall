import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_step3/routes/addProduct.dart';
import 'package:cs310_step3/routes/feedView.dart';
import 'package:cs310_step3/routes/mockPaymentPage.dart';
import 'package:cs310_step3/routes/profile_page.dart';
import 'package:cs310_step3/routes/redirection_page.dart';
import 'package:cs310_step3/routes/search_explore.dart';
import 'package:cs310_step3/routes/shopping_cart_page.dart';
import 'package:cs310_step3/routes/welcome_page.dart';
import 'package:cs310_step3/utils/cart_bookmark_tile.dart';
import 'package:cs310_step3/utils/cart_tile.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/prodcutPage.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/productDetails.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import '/services/authentication_file.dart';
import '/services/db.dart';

import 'package:cs310_step3/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class MockPaymentPage extends StatefulWidget {

  @override
  _MockPaymentPageState createState() => _MockPaymentPageState();
  MockPaymentPage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;
  final formKey = GlobalKey<FormState>();
}

class _MockPaymentPageState extends State<MockPaymentPage> {

  List<Product> myPosts = [];

  late String namec;
  late int cardno;
  late int security;
  late String date;
  late bool datebool;

  Future<void> asyncMethod() async {
    myPosts = await getPosts();
    setState(() {

    });
  }

  @override
  void initState() {
    asyncMethod();
    super.initState();
    namec = "";
    cardno = 0;
    security = 0;
    date = "";
    datebool = true;
  }

  Future<List<Product>> getPosts() async {
    List<Product> myPostsPrev = [];
    widget.myUser = await getUserWithMail(widget.myUser!.email!);
    List<dynamic> myKeys = widget.myUser!.shopping_card!;
    Product current;
    for(String key in myKeys)
    {
      current = await getProdcutWithUrl(key);
      myPostsPrev.add(current);
    }
    return myPostsPrev;
  }

  double total = 0;

  String getTotal(double total){
    for(Product prod in myPosts){
      total += prod!.price!.toDouble();
    }

    late String toReturn;


    if(total >= 100){
      total = total*80/100;
      toReturn = total.toString() + "\nwith 20% off for minimum 100Tl purchases";
    }
    else if(total>= 75){
      total = total*85/100;
      toReturn = total.toString() + "\nwith 15% off for minimum 75TL purchases";
    }
    else if(total>= 50){
      total = total*90/100;
      toReturn = total.toString() + "\nwith 10% off for minimum 50TL purchases";
    }
    else{
      total = total*95/100;
      toReturn = total.toString() + "\nwith 5% off for all products";
    }

    return toReturn;
  }



  @override
  Widget build(BuildContext context) {
    Future<void> showAlertDialog(String title, String message) async {
      return showDialog(context: context,
          barrierDismissible: false, //must take action
          builder: (BuildContext context) {
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
      );
    }


    return Scaffold(
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Text("Total Price: ${getTotal(0)}", textAlign: TextAlign.center, style: TextStyle(
          fontFamily: 'Sansita_Swashed',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.7,
        ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            children: [
              Text("🛒 ITEMS IN THE CART 🛒", style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sansita_Swashed',
                letterSpacing: -0.7,
              )),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: myPosts.map(
                          (product) =>
                          CartTile(
                            post: product,
                            delete: () {
                              setState(() {
                                total = (total! + product.price!.truncateToDouble());
                                removeFromCard(widget.myUser!.email!, product.name! + product.seller!);
                                asyncMethod();
                              });
                            },)
                  ).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: AppColors.primary,
                thickness: 1,
              ),

              Text(
                'CREDIT CARD INFORMATION',
                style: smallTitleBlackTextStyle,
              ),

              Divider(
                color: AppColors.primary,
                thickness: 1,
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: widget.formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row( //CREDIT CARD NUMBER
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: AppColors.background,
                                  filled: true,
                                  hintText: 'Credit Card Number',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,

                                validator: (value) {
                                  if (value == null) {
                                    return 'Credit Card Number field cannot be empty';
                                  } else {
                                    String trimmedValue = value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return 'Credit Card Number field cannot be empty';
                                    }else{
                                      if(trimmedValue.length < 8 || trimmedValue.length > 19){
                                        return 'Credit Card Number format is wrong';
                                      }
                                    }
                                  }
                                  return null;
                                },

                                onSaved: (value) {
                                  if (value != null) {
                                    cardno = int.parse(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),

                        Row( //NAME FIELD
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: AppColors.background,
                                  filled: true,
                                  hintText: 'Name of the card owner',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.text,

                                validator: (value) {
                                  if (value == null) {
                                    return 'Name field cannot be empty';
                                  } else {
                                    String trimmedValue = value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return 'Name field cannot be empty';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  if (value != null) {
                                    namec = value.capitalize();
                                  }
                                },


                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),

                        Row( //DATE
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: AppColors.background,
                                  filled: true,
                                  hintText: 'Expiration Date',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.text,

                                validator: (value) {
                                  if (value == null) {
                                    return 'Expiration Date field cannot be empty';
                                  } else {
                                    String trimmedValue = value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return 'Expiration Date field cannot be empty';
                                    }else{
                                      if(trimmedValue.length != 5 || trimmedValue[2] != '/'){
                                        datebool = false;
                                        return 'Date format is wrong';
                                      }
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  if (value != null && datebool == true) {
                                    date = value.capitalize();
                                  }
                                },


                              ),
                            ),
                            SizedBox(width: 30,),
                            Expanded( // CVC VALUE
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: AppColors.background,
                                  filled: true,
                                  hintText: 'CVC code',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,

                                validator: (value) {
                                  if (value == null) {
                                    return 'CVC code field cannot be empty';
                                  } else {
                                    String trimmedValue = value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return 'CVC code field cannot be empty';
                                    }else{
                                      if(trimmedValue.length != 3){
                                        return 'CVC must be 3 digit number';
                                      }
                                    }
                                  }
                                  return null;
                                },

                                onSaved: (value) {
                                  if (value != null) {
                                    security = int.parse(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                      ]
                  ),

                ),
              ),



              SizedBox(height: 16,),

              OutlinedButton(
                onPressed: () async {
                  if (widget.formKey.currentState!.validate()) {
                    widget.formKey.currentState!.save();
                    print(namec + " " + cardno.toString() + " " + date + " " + security.toString());
                    widget.formKey.currentState!.reset();

                    for (Product prod in myPosts){
                      String productKey = prod.name! + prod.seller!;
                      await addBoughtProd(widget.myUser!.email!, productKey);
                      await updatePrevSales(prod.sellerMail!, productKey);
                      await addNotificaitonToUser(prod.sellerMail!, "Your product has been bought by a user.");

                    }
                    await cleanCart(widget.myUser!.email!);

                    await addNotificaitonToUser(widget.myUser!.email!, "You have made a purchase successfully.");
                    await showAlertDialog("Purchase Successful" , "Your prdoduct/products will be delivered soon!");

                    setState(() {
                      asyncMethod();
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0),
                  child: Text("Purchase Items",
                    style: loginButtonTextStyle,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.purchaseAndAdd,
                ),
              ),
              OutlinedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FeedView(myUser: widget.myUser!)
                      )
                  );
                },
                child: Text("Return to Main Page", style:TextStyle(color: AppColors.primary)),
              ),
            ]
        ),
      ),


    );
  }
}
