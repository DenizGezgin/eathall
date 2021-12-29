import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_step3/routes/addProduct.dart';
import 'package:cs310_step3/routes/profile_page.dart';
import 'package:cs310_step3/routes/redirection_page.dart';
import 'package:cs310_step3/routes/search_explore.dart';
import 'package:cs310_step3/routes/shopping_cart_page.dart';
import 'package:cs310_step3/routes/welcome_page.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/productDetails.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import '/services/authentication_file.dart';
import '/services/db.dart';

List<Widget> createNavBar(UserFirebase? user)
{
  if(user == null)
  {
    return <Widget>
    [

      MainFeedView(),
      SearchFeed(),
      RedirectionPage(),
      ShoppingCartPage(),
      RedirectionPage(),
    ];
  }
  else if(user.email == "NULL_NAME")
    {
      return <Widget>
      [

        MainFeedView(),
        SearchFeed(),
        RedirectionPage(),
        ShoppingCartPage(),
        RedirectionPage(),
      ];
    }
    return <Widget>
    [

      MainFeedView(),
      SearchFeed(),
      addProductPage(),
      ShoppingCartPage(),
      ProfilePage(myUser: user!,),
    ];
}

class FeedView extends StatefulWidget {
  FeedView({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  AuthService auth = AuthService();

  late int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _widgetOptions = createNavBar(widget.myUser);
    if(widget.myUser != null)
      {
        print(widget.myUser!.surname);
      }
  }


  late List<Widget> _widgetOptions;
  PageController pageController = PageController();
  //int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('products');

    Product sa;
   //List<Product> allProducts = await getAllData();
  // print(allProducts[1].seller);


    return Scaffold(
      backgroundColor: AppColors.loginToContinueBackGround,
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
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        backgroundColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        fixedColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_headline, color: Colors.white),
            //label: "Home",

            title: SizedBox(
              height: 0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white,),

            title: SizedBox(
              height: 0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, color: Colors.white, ),
            title: SizedBox(
              height: 0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white,),
            title: SizedBox(
              height: 0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white,),
            title: SizedBox(
              height: 0,
            ),
          ),
        ],
        currentIndex: selectedIndex,
              onTap: (int index){
                setState(() {
                  selectedIndex = index;
                });
              }
      ),
    );
  }
}

class MainFeedView extends StatefulWidget {
  const MainFeedView({Key? key}) : super(key: key);

  @override
  _MainFeedViewState createState() => _MainFeedViewState();
}

class _MainFeedViewState extends State<MainFeedView> {

  List<Product> allProducts = [];

  void asyncMethod() async {
    allProducts = await getAllData();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  @override
  Widget build(BuildContext context) {
    if(allProducts.length == 0)
      {return  Center(
        child: CircularProgressIndicator(),
      );}
    else {return Scaffold(

        body: SingleChildScrollView(
          child: Column(

            children: [
              Divider(
                color: AppColors.primary,
                thickness: 1,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRect(
                      child: Image.asset("assets/images/add_banner.png", fit: BoxFit.fill, height: 110, width: 330,),
                    ),
                  ),
                ],
              ),

              Text("Products", style: loginSignupOrContinueSmallTextStyleBlack,),
              Divider(
                color: AppColors.primary,
                thickness: 1,
              ),
              SizedBox(
                width: 5,
                height: 7,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: allProducts.length,
                    physics: NeverScrollableScrollPhysics(),
                    //scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        //color: AppColors.primary,
                        decoration: BoxDecoration(border: Border.all(color: AppColors.primary)),
                        child: IconButton(
                          icon: Image.network(allProducts[index].photoUrl!, fit: BoxFit.fill, height: 200, width: 200,),
                          onPressed: () {print("menemen");},
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      );}

  }
}



