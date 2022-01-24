import 'dart:typed_data';
import 'package:cs310_step3/services/authentication_file.dart';
import 'package:cs310_step3/utils/prodcutPage.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cs310_step3/routes/edit_profile.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'package:cs310_step3/utils/styles.dart';

import 'login_page.dart';


class SellerProfileBuyerPage extends StatefulWidget {
  @override
  State<SellerProfileBuyerPage> createState() => _SellerProfileBuyerPageState();
  SellerProfileBuyerPage({Key? key, this.mySeller, this.myUser}) : super(key: key);
  UserFirebase? myUser;
  UserFirebase? mySeller;
}
String theUser = "";
String theSeller = "";


class  _SellerProfileBuyerPageState extends State<SellerProfileBuyerPage> {


  List<Product> sellersProductsOnSale = [];

  void asyncMethod() async {
    sellersProductsOnSale = await getProductsOnSale();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  Future<List<Product>> getProductsOnSale() async {
    List<Product> myPostsPrev = [];
    //widget.mySeller = await getUserWithMail(widget.mySeller!.email!);
    List<dynamic> myKeys = widget.mySeller!.products_onsale!;
    Product current;
    for(String key in myKeys)
    {
      current = await getProdcutWithUrl(key);
      myPostsPrev.add(current);
    }
    return myPostsPrev;
  }


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    Future<String?> getUsername(User user) async {
      if (user == null) {
        return "no user";
      }
      else {
        user.displayName;
      }
    }

    if (user != null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.primary),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      color: Colors.black,
                      width: 30,
                      height: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 5, top: 20, bottom: 10, left: 5),
                    child: CircleAvatar(
                      radius: 40,
                      child: ClipOval(

                        child: Image.network(widget.mySeller!.photoUrl!,
                          //'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.nicepng.com%2Fpng%2Fdetail%2F933-9332131_profile-picture-default-png.png&imgrefurl=https%3A%2F%2Fwww.nicepng.com%2Fourpic%2Fu2y3a9e6t4o0a9w7_profile-picture-default-png%2F&tbnid=bLv2FccUvqriEM&vet=12ahUKEwjjs6SAgqL1AhWO4bsIHRIjD48QMygRegUIARCCAg..i&docid=-E5pvHnffveX2M&w=820&h=719&q=default%20profile%20picture&ved=2ahUKEwjjs6SAgqL1AhWO4bsIHRIjD48QMygRegUIARCCAg',
                          fit: BoxFit.fill, height: 200, width: 100,),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 12),
                        child:Text("Seller Profile",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Sansita_Swashed',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.7,
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Container(
                          color: Colors.black,
                          width: 267.5,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(widget.mySeller!.name! + " " + widget.mySeller!.surname!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            letterSpacing: -0.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 25,),
                  RatingBarIndicator(
                    rating: widget.mySeller!.averageRating!,
                    itemBuilder: (context, index) => Icon(
                      Icons.star_rate_outlined,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              //scrollable column of products, connected to product page
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 10),
                          child: Text("Products on Sale"))
                    ],
                  ),
                  Container(

                    child: SingleChildScrollView(
                      child:  OutlinedButton(
                        child: ListView.builder(
                            itemCount: sellersProductsOnSale.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                semanticContainer: true,
                                elevation: 2,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: ListTile(
                                  title: Text(
                                    sellersProductsOnSale[index].displayName!,
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "${sellersProductsOnSale[index].price!}" + "TL    ",
                                      ),
                                      Text(sellersProductsOnSale[index].category!, style: TextStyle(color: AppColors.primary, fontStyle: FontStyle.italic)),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.arrow_forward_outlined,
                                        color: AppColors.primary),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                productPage(myUser: widget.myUser,
                                                    myProduct: sellersProductsOnSale[index]),
                                          ));
                                    },
                                  ),
                                ),
                              );
                            }),
                        onPressed: (){

                        },
                      )
                    ),
                  ),
                ],
              ),//for the products on sale
              //scrollable column of comments
            ],
          ),
        ),
      );
    }
    else {
      return Scaffold(

      );
    }
  }
}