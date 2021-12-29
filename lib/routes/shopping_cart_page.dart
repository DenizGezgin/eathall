import 'dart:math';

import 'package:cs310_step3/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class  _ShoppingCartPageState extends State<ShoppingCartPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text("this will be the shopping cart page.", style: loginSignupOrContinueSmallTextStyleBlack),

        ]
      )
    );
  }
}