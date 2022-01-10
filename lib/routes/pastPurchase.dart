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
  @override
  Widget build(BuildContext context) {

    UserFirebase myUser;

    List<Product> myPosts = [];

    Future<List<Product>> getPosts() async {
      List<Product> myPostsPrev = [];
      myUser = await getUserWithMail(widget.userMail);
      List<dynamic> myKeys = myUser.bought_products!;
      Product current;
      for(String key in myKeys)
      {
        current = await getProdcutWithUrl(key);
        myPostsPrev.add(current);
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
      asyncMethod();
    }

    return Scaffold(
      body: SingleChildScrollView(
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
                  trailing: RatingBarIndicator( //-0000.1
                    rating: myPosts[index].rating!,
                    itemBuilder: (context, index) => Icon(
                      Icons.local_pizza_outlined,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ),
              );
            })
      ),
    );
  }
}
