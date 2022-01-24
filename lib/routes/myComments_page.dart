import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_step3/routes/edit_profile.dart';
import 'package:cs310_step3/routes/pastPurchase.dart';
import 'package:cs310_step3/routes/seller_profile.dart';
import 'package:cs310_step3/utils/commentClass.dart';
import 'package:cs310_step3/utils/prodcutPage.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'commentReqs.dart';
import 'login_page.dart';
import '/services/authentication_file.dart';

class MyCommentsPage extends StatefulWidget {
  @override
  State<MyCommentsPage> createState() => _MyCommentsPageState();
  MyCommentsPage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;
  late Product thisProduct;

}
String theUser = "";

class  _MyCommentsPageState extends State<MyCommentsPage> {
  late UserFirebase? theUser;
  late List<Comment> myComments = [];

  Future<List<Comment>> getPosts() async {
    List<Comment> myPostsPrev = [];
    theUser = await getUserWithMail(widget.myUser!.email!);
    List<dynamic> myKeys = theUser!.comments!;

    for(Comment myKey in myKeys){
      myPostsPrev.add(myKey);
    }
    return myPostsPrev;
  }

  void asyncMethod() async {
    myComments = await getPosts();
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    myComments = [];
    asyncMethod();
  }


  @override
  Widget build(BuildContext context) {

    if(myComments.length > 0){
      return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.primary),
        body: SingleChildScrollView(
            child:  ListView.builder(
                itemCount: myComments.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    semanticContainer: true,
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ListTile(
                      subtitle: Column(
                        children: [

                          Text(myComments[index].data!, style: TextStyle(color: Colors.black)),
                          Text(myComments[index].date!.toString(), style: TextStyle(fontSize: 8, color: Colors.blueGrey)),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          RatingBarIndicator(
                            rating: myComments[index]!.rating!.toDouble(),
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rate_outlined,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 5.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                  );
                })
        ),
      );
    }
    else{
      return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.primary),

        body: Container(
          padding: const EdgeInsets.only(top:50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You currently have no comments or ratings to show."),
            ],
          ),
        ),
      );
    }
  }
}