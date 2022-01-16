import 'package:flutter/material.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';




class ApproveComments extends StatefulWidget {
  ApproveComments({Key? key,  required this.userMail}) : super(key: key);
  String userMail;

  @override
  _ApproveCommentsState createState() => _ApproveCommentsState();
}

class _ApproveCommentsState extends State<ApproveComments> {
  late UserFirebase? myUser;
  late List<dynamic> myPosts;

  Future<List<dynamic>> getPosts() async {
    List<dynamic> myPostsPrev = [];
    myUser = await getUserWithMail(widget.userMail);
    List<dynamic> myKeys = myUser!.comment_approves!;
    Product current;
    for(dynamic key in myKeys)
    {
      myPostsPrev.add(key);
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
      appBar: AppBar(backgroundColor: AppColors.primary,),
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
                              myPosts[index]["user"],
                            ),
                            subtitle: Text(
                              myPosts[index]["data"],
                            ),
                            leading: IconButton(onPressed: (){
                              addAprrovedComment(myPosts[index]["userMail"],myPosts[index]);
                              addCommentProduct(myPosts[index]["productKey"], myPosts[index]);
                            }, icon: Icon(Icons.check_box, color: Colors.green, )),
                            trailing: RatingBarIndicator(
                              rating: myPosts[index]["rating"],
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
              ),
            ]
        ),
      ),
    );
  }
}


