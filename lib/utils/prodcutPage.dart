import 'package:cs310_step3/routes/seller_profile_buyers_see.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';

class productPage extends StatefulWidget {
  productPage({Key? key, required this.myProduct, this.myUser}) : super(key: key);
  final Product myProduct;
  UserFirebase? myUser;

  @override
  _productPageState createState() => _productPageState();
}
late final userSeller;

class _productPageState extends State<productPage> {
  @override
  Widget build(BuildContext context) {

    void foo(sellersMail) async {
      userSeller = await getUserWithMail(sellersMail);
    }

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
                    child: Text("Okey"))
              ],
            );
          }
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF973333),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        height: 200.0,
        child: ClipRect(
          child: InteractiveViewer(
            panEnabled: false, // Set it to false
            boundaryMargin: EdgeInsets.all(100),
            minScale: 0.5,
            maxScale: 2,
            child: PhotoView(
              imageProvider: NetworkImage(widget.myProduct.photoUrl!),
              maxScale: PhotoViewComputedScale.covered * 2.0,
              minScale: PhotoViewComputedScale.contained * 0.8,
              initialScale: PhotoViewComputedScale.covered,
            ),
          ),
        ),
    ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(widget.myProduct.name!,
              style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 28),)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  shape: StadiumBorder(
                    side: BorderSide(color: Colors.black, width: 0.5),
                  ),
                  onPressed: () {
                    foo(widget.myProduct.sellerMail!);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellerProfileBuyerPage(mySeller: userSeller, myUser: widget.myUser) //böyle bir şey denedim umarım çalışır
                        ));
                  },
                  child: Text(
                    widget.myProduct.seller!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.grey,
                        fontSize: 18),
                  ),
                ),
              ],),
            RatingBarIndicator(
              rating: widget.myProduct.rating!,
              itemBuilder: (context, index) => Icon(
                Icons.star_rate_outlined,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 50.0,
              direction: Axis.horizontal,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 370.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white)

                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                        widget.myProduct.description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Arial',
                          color: Colors.grey,
                          fontSize: 18,
                          height: 1,
                        ),
                      ),
                  ),
                  ),
              ],),
            SizedBox(height: 2,),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text("Price", style: TextStyle(
                        color: AppColors.primary,
                        fontFamily: 'Arial',
                        fontSize: 18,
                        height: 1,),
                      ),
                      SizedBox(height: 35),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(),
                            border: Border.all(color: AppColors.primary,
                            width: 0.5)
                        ),
                        child: Text("${widget.myProduct.price} TL",
                          style: TextStyle(
                            fontFamily: 'Arial',
                            color: AppColors.primary,
                            fontSize: 18,
                            height: 1,
                          ),),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Bookmark",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          color: Colors.yellow,
                          fontSize: 18,
                          height: 1,
                        ),),
                      SizedBox(height:10),
                      IconButton(
                        onPressed: (){
                          if(widget.myUser != null)
                          {
                            updateBookmark(widget.myUser!.email!, widget.myProduct.name! + widget.myProduct.seller!);
                            showAlertDialog("Sucsess", "Product is added to the bookmarks.");
                          }
                          else
                          {
                            showAlertDialog("Failed", "Anonymous users cant use bookmark feature.");
                          }

                        },
                        icon: Icon(Icons.bookmark,
                          color:  Colors.yellow),
                        highlightColor:  Colors.yellowAccent,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add to Cart",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          color: AppColors.purchaseAndAdd,
                          fontSize: 18,
                          height: 1,
                        ),),
                      SizedBox(height:10),
                      IconButton(
                          onPressed: (){
                            if(widget.myUser != null)
                              {
                                updateCard(widget.myUser!.email!, widget.myProduct.name! + widget.myProduct.seller!);
                                showAlertDialog("Sucsess", "Product is added to the card.");
                              }
                            else
                              {
                                print("NullUser");
                              }

                          },
                          icon: Icon(Icons.shopping_cart,
                              color: AppColors.purchaseAndAdd,),
                        highlightColor: Colors.greenAccent,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            ListView.builder(
                itemCount: widget.myProduct.comments!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
              return Card(
                  semanticContainer: true,
                  elevation: 2,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ListTile(
                    title: Text(
                        widget.myProduct.comments![index]["user"],
                    ),
                    subtitle: Text(
                      widget.myProduct.comments![index]["data"],
                    ),
                    trailing: RatingBarIndicator( //-0000.1
                      rating: widget.myProduct.comments![index]["rating"],
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rate_outlined,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ),
                );
            })


          ],





        ),
      ),
    );
  }
}




