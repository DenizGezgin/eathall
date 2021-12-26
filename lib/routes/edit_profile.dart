import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'login_page.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class  _EditProfilePageState extends State<EditProfilePage>{
  String nameUser = "";
  String surnameUser = "";
  String addressUser = "";
  int emptyCount = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
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
      body: Scaffold(
        body: Column(
          children: [
            //burada foto degistirme olmalı storage vb
            Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: AppColors.background,
                    filled: true,
                    hintText: 'Name',
                    errorStyle: loginErrorStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  //text from field passwords
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,

                  validator: (value) {
                    if (value == null) {
                      return 'Name field cannot be empty';
                    } else {
                      String trimmedValue = value.trim();
                      if (trimmedValue.isEmpty) {
                        return 'Name field cannot be empty';
                      }
                    }
                    return null;
                  },

                  onSaved: (value) {
                    if (value != null) {
                      nameUser = value;
                    }
                  },
                ),
            ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: AppColors.background,
                    filled: true,
                    hintText: 'Surname',
                    errorStyle: loginErrorStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  //text from field passwords
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,

                  validator: (value) {
                    if (value == null) {
                      return 'Surname field cannot be empty';
                    } else {
                      String trimmedValue = value.trim();
                      if (trimmedValue.isEmpty) {
                        return 'Surname field cannot be empty';
                      }
                    }
                    return null;
                  },

                  onSaved: (value) {
                    if (value != null) {
                      surnameUser = value;
                    }
                  },
                ),
              ),
               Container(
                 padding: EdgeInsets.all(10),
                 child: TextFormField(
                   decoration: InputDecoration(
                     fillColor: AppColors.background,
                     filled: true,
                     hintText: 'Password',
                     errorStyle: loginErrorStyle,
                     border: OutlineInputBorder(
                       borderSide: BorderSide(
                         color: AppColors.primary,
                       ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  //text from field passwords
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,

                  validator: (value) {
                    if (value == null) {
                      return 'Password field cannot be empty';
                    } else {
                      String trimmedValue = value.trim();
                      if (trimmedValue.isEmpty) {
                        return 'Password field cannot be empty';
                      }
                      if (trimmedValue.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                    }
                    return null;
                  },

                  onSaved: (value) {
                    if (value != null) {
                      pass = value;
                    }
                  },
                ),
               ),Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: AppColors.background,
                  filled: true,
                  hintText: 'Address',
                  errorStyle: loginErrorStyle,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                //text from field passwords
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,

                validator: (value) {
                  if (value == null) {
                    return 'Address field cannot be empty';
                  } else {
                    String trimmedValue = value.trim();
                    if (trimmedValue.isEmpty) {
                      return 'Name field cannot be empty';
                    }
                  }
                  return null;
                },

                onSaved: (value) {
                  if (value != null) {
                    nameUser = value;
                  }
                },
              ),
            ),

            Padding(

              padding: const EdgeInsets.all(2),
              child: OutlinedButton(
                child: Text("Save Changes", textAlign: TextAlign.center, style: loginSignupOrContinueSmallTextStyleBlack),
                onPressed: (){
                  //save changes
                },
              ),

            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        fixedColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_headline, color: Colors.white),

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
      ),
    );
  }
}