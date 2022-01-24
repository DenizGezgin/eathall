import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_step3/routes/addProduct.dart';
import 'package:cs310_step3/routes/anonMockPaymentPage.dart';
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

class ShoppingCartPage extends StatefulWidget {
  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
  ShoppingCartPage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;
}



class  _ShoppingCartPageState extends State<ShoppingCartPage>{

  List<Product> myPosts = [];
  List<Product> myBookmarks = [];

  Future<void> asyncMethod() async {
    myPosts = await getPosts();
    myBookmarks = await getBookmarks();
    setState(() {

    });
  }

  @override
  void initState() {
    asyncMethod();
    super.initState();

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

  Future<List<Product>> getBookmarks() async {
    List<Product> myPostsPrev = [];
    widget.myUser = await getUserWithMail(widget.myUser!.email!);
    List<dynamic> myKeys = widget.myUser!.bookmarks!;
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
    return Scaffold(
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
            Text("🛒 MY SHOPPING CART 🛒", style: TextStyle(
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
                              removeFromCard(widget.myUser!.email!, product.name! + product.seller!);
                              asyncMethod();
                            });
                          },)
                ).toList(),
              ),
            ),
            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),

            Text(
              '🔖 My Bookmarks 🔖',
              style: smallTitleBlackTextStyle,
            ),

            Divider(
              color: AppColors.primary,
              thickness: 1,
            ),

            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: myBookmarks.map(
                  (product) =>
                    CartBookmarkTile(
                      product: product,
                      addToCart: () {
                        print("Added to the Cart");
                        updateCard(widget.myUser!.email!, product.name! + product.seller!);
                        asyncMethod();
                    },)
                ).toList(),
              ),
            ),

            SizedBox(height: 16,),

            OutlinedButton(
                onPressed: () {

                  if(widget.myUser == null){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => anonMockPaymentPage()
                        ));
                  }else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MockPaymentPage(myUser: widget.myUser,)
                        ));
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


          ]
        ),
      ),


    );
  }
}

