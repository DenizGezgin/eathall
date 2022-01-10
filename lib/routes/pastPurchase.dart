import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              OutlinedButton(onPressed: (){
                asyncMethod();
                print(myPosts.length);
              }, child: Text("Refresh"))
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
                          "${myPosts[index].price!}",
                        ),
                        trailing: myUser!.bought_products![index]["isAlreadyRated"] ? RatingBarIndicator( //-0000.1
                          rating: myPosts[index].rating!,
                          itemBuilder: (context, index) => Icon(
                            Icons.local_pizza_outlined,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ) : OutlinedButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RateOnItemPage(productKey:  myUser!.bought_products![index]["productKey"],
                                                                      buyerMail: widget.userMail,
                                                                        sellerMail:myPosts[index].sellerMail! , index: index),
                              ));
                        }, child: Text("Rate and Comment")),
                      ),
                    );
                  })
          ),
        ]
      ),
    );
  }
}


class RateOnItemPage extends StatefulWidget {
  RateOnItemPage({Key? key, required this.productKey, required this.buyerMail, required this.sellerMail, required this.index }) : super(key: key);

  String productKey;
  String buyerMail;
  String sellerMail;
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
      appBar: AppBar(),
      body: Form(
        key: widget.formKey,
        child: Column(
          children: [
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            final_rating = rating - 0.0001;
            print(rating);
          },
        ),
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
            OutlinedButton(onPressed: (){
              //commentFields: USER + DATA + RATING + ISAPPROVED
              widget.formKey.currentState!.save();

              //update ratings
              updateProductRating(widget.productKey, final_rating);
              updateUserRating(widget.sellerMail, final_rating);
              //put comment to seller approve box
              addPendingComment(widget.sellerMail, commentData, final_rating, widget.index, widget.productKey, widget.buyerMail);
              //put comment to user comment box

              Navigator.pop(context);

            }, child: Text("Done"))
          ],
        ),
      ),
    );
  }
}




