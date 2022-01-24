import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photo_view/photo_view.dart';

class pastPurchese extends StatefulWidget {
  pastPurchese({Key? key,  required this.userMail}) : super(key: key);
  String userMail;

  @override
  _pastPurcheseState createState() => _pastPurcheseState();
}

class _pastPurcheseState extends State<pastPurchese> {
  late UserFirebase? myUser;
  late List<Product> myPosts;

  Future<List<Product>> getPosts() async {
    List<Product> myPostsPrev = [];
    myUser = await getUserWithMail(widget.userMail);
    List<dynamic> myKeys = myUser!.bought_products!;
    Product current;
    for(dynamic key in myKeys)
    {
      current = await getProdcutWithUrl(key["productKey"]);
      myPostsPrev.add(current);
      print(current.seller!);
    }
    return myPostsPrev;
  }

  void asyncMethod() async {
    myPosts = await getPosts();
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    myPosts = [];
    asyncMethod();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: AppColors.primary)
      ,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  asyncMethod();
                  print(myPosts.length);
                }, icon: Icon(Icons.refresh, color: AppColors.primary,))
              ],
            ),
            SingleChildScrollView(
                child:  ListView.builder(
                    itemCount: myPosts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        semanticContainer: true,
                        elevation: 2,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ListTile(
                          title: Text(
                            myPosts[index].name!,
                          ),
                          subtitle: Text(
                            "${myPosts[index].seller!}",
                          ),
                          leading: Image.network(myPosts[index].photoUrl!,fit: BoxFit.fill,),
                          trailing: myUser!.bought_products![index]["isAlreadyRated"] ? RatingBarIndicator( //-0000.1
                            rating: myPosts[index].rating!,
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rate_outlined,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ) : FlatButton(onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RateOnItemPage(productKey:  myUser!.bought_products![index]["productKey"],
                                                                        buyerMail: widget.userMail,
                                                                          sellerMail:myPosts[index].sellerMail!, url:myPosts[index].photoUrl!, productName:myPosts[index].name!, seller:myPosts[index].seller! , index: index),
                                ));

                          }, child: Container(
                              child: Text("Rate and\nComment", textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:AppColors.purchaseAndAdd,
                                  )),
                            padding: const EdgeInsets.only(left:3, right:3),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.purchaseAndAdd),
                            ),
                          ),),
                        ),
                      );
                    })
            ),
          ]
        ),
      ),
    );
  }
}


class RateOnItemPage extends StatefulWidget {
  RateOnItemPage({Key? key, required this.productKey, required this.buyerMail, required this.sellerMail, required this.url, required this.productName,required this.seller, required this.index}) : super(key: key);

  String productKey;
  String buyerMail;
  String sellerMail;
  String url;
  String productName;
  String seller;
  int index;
  final formKey = GlobalKey<FormState>();

  @override
  _RateOnItemPageState createState() => _RateOnItemPageState();
}

class _RateOnItemPageState extends State<RateOnItemPage> {

  Product? myProduct;
  UserFirebase? myBuyer;
  UserFirebase? mySeller;
  String commentData = "";
  double final_rating = 2.9999;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: AppColors.primary,),
      body: Form(
        key: widget.formKey,
        child: Column(
          children: [

            //Image.network(widget.url),
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
                    imageProvider: NetworkImage(widget.url),
                    maxScale: PhotoViewComputedScale.covered * 2.0,
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    initialScale: PhotoViewComputedScale.covered,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(widget.productName!,
              style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 28),),
            SizedBox(height: 10,),
            Text(
              widget.seller!,
              style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.grey,
                  fontSize: 18),
            ),
          SizedBox(height: 35,),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star_rate_outlined,
              color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            final_rating = rating - 0.0001;
            print(rating);
          },
        ),
            SizedBox(height: 75,),
            Row( //Comment data.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: AppColors.background,
                      filled: true,
                      hintText: 'Add a comment',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    maxLines: 5,
                    minLines: 3,
                    keyboardType: TextInputType.text,


                    onSaved: (value) {
                      print("AAAAAAGH");
                      if (value != null) {
                        commentData = value;
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            OutlinedButton(onPressed: () async{

              //commentFields: USER + DATA + RATING + ISAPPROVED
              widget.formKey.currentState!.save();

              //update ratings
              await updateProductRating(widget.productKey, final_rating);
              await updateUserRating(widget.sellerMail, final_rating);
              //put comment to seller approve box
              await addPendingComment(widget.sellerMail, commentData, final_rating, widget.index, widget.productKey, widget.buyerMail);
              //put comment to user comment box
              await addNotificaitonToUser(widget.buyerMail, "You have made a comment or/and a rating to a product.");
              await addNotificaitonToUser(widget.sellerMail, "You have recieved a pending comment for your product.");
              Navigator.pop(context);

              setState(() {

              });
            }, child: Text("Send", style: TextStyle(color: Colors.green))),
          ],
        ),
      ),
    );
  }
}




