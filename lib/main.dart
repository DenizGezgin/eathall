
import 'package:cs310_step3/routes/addProduct.dart';
import 'package:cs310_step3/routes/anonMockPaymentPage.dart';
import 'package:cs310_step3/routes/edit_profile.dart';
import 'package:cs310_step3/routes/feedView.dart';
import 'package:cs310_step3/routes/mockPaymentPage.dart';
import 'package:cs310_step3/routes/notifications_page.dart';
import 'package:cs310_step3/routes/profile_page.dart';
import 'package:cs310_step3/routes/redirection_page.dart';
import 'package:cs310_step3/routes/search_explore.dart';
import 'package:cs310_step3/routes/seller_profile.dart';
import 'package:cs310_step3/routes/shopping_cart_page.dart';
import 'package:cs310_step3/services/authentication_file.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '/routes/login_page.dart';
import '/routes/welcome_page.dart';
import '/routes/signup_page.dart';
import '/routes/walkthrough.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:is_first_run/is_first_run.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () => runApp(_FirebaseAppState()),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isLoggedIn = false;
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("isfirstRun")
        .then((value) => setState(() {
      isLoggedIn = value;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        routes: {
          "/feedView": (context) => FeedView(),
          "/SearchView": (context) => SearchFeed(),
          "/logPage": (context) => Login(observer: observer, analytics: analytics),
          "/signupPage": (context) => Signup(observer: observer, analytics: analytics),
          "/Welcome": (context) => Welcome(observer: observer, analytics: analytics),
          //"/profilePage": (context) => ProfilePage(),
          "/editProfilePage": (context) => EditProfilePage(),
          "/notificationsPage": (context) => NotificationsPage(),
          "/sellerProfile": (context) => SellerProfilePage(),
          "/addProductPage": (context) => addProductPage(),
          "/shoppingCart": (context) => ShoppingCartPage(),
          "/redirectionPage": (context) => RedirectionPage(),
          "/mockPaymentPage": (context) => MockPaymentPage(),
          "/anonMockPaymentPage": (context) => anonMockPaymentPage(),
        },
          debugShowCheckedModeBanner: false,
          navigatorObservers: <NavigatorObserver>[observer],
        home: isLoggedIn ? Welcome(analytics: analytics, observer: observer) : WalkThrough(analytics: analytics, observer: observer),
        //initialRoute:

      ),
    );
  }
}

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
  MySharedPreferences._privateConstructor();
  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }
}

class _FirebaseAppState extends StatefulWidget {
  const _FirebaseAppState({Key? key}) : super(key: key);

  @override
  _FirebaseAppStateState createState() => _FirebaseAppStateState();
}

class _FirebaseAppStateState extends State<_FirebaseAppState> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context,snapshot)
        {
          if(snapshot.hasError)
            {
                return MaterialApp(
                  home: Scaffold(
                    backgroundColor: AppColors.primary,
                    body: Center(
                      child: Wrap(
                        children: [Text("No connection to Firebase: ${snapshot.error.toString()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.7,
                          ),),]
                      ),

                    ),
                  ),
              );
            }
          if(snapshot.connectionState == ConnectionState.done)
            {
              return MyApp();
            }
          else
            {
              return MaterialApp(
                home: Scaffold(
                  backgroundColor: AppColors.primary,
                  body: Center(
                    child: Text("Connecting...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 69,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.7,
                      ),),

                  ),
                ),
              );
            }
        }
    );
  }
}


