import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'login_page.dart';
import 'package:path/path.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class  _EditProfilePageState extends State<EditProfilePage>{
  String nameUser = "";
  String surnameUser = "";
  String addressUser = "";
  int emptyCount = 0;
  late String photoUrl;

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('product_images/$fileName');
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      photoUrl = (await firebaseStorageRef.getDownloadURL()).toString();
      print("URI::::   "+ photoUrl);
      print("Upload complete");
    } on FirebaseException catch(e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {

    Future<void> showAlertDialog(String title, String message) async {
      return showDialog(context: context,
          barrierDismissible: false, //must take action
          builder: (BuildContext context) {
            if(isIOS) {
              return CupertinoAlertDialog( //styling is not always auto adjusted
                title: Text(title),
                content: SingleChildScrollView(
                  child: Text(message),
                ),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(); //pop the current alert view
                  },
                      child: Text("OK"))
                ],
              );
            }
            else{
              return AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(
                  child: Text(message),
                ),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop(); //pop the current alert view
                  },
                      child: Text("OK"))
                ],
              );
            }
          }
      );
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(

                  padding:const EdgeInsets.all(10),
                  child:CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Image.asset("assets/images/default_profile_picture.png",
                        fit: BoxFit.fill, height: 200, width: 100,),
                    ),
                  ),
                ),
                Padding(

                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(
                    child: Text("Change Profile Picture", textAlign: TextAlign.center, style: loginSignupOrContinueSmallTextStyleBlack),
                    onPressed: (){
                      //save changes
                      setState(() {
                        uploadImageToFirebase(context);
                      });

                    },
                  ),

                ),
              ],
            ),
            Container(
                padding: EdgeInsets.all(5),
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
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,

                  validator: (value) {
                    if (value == null) {
                      emptyCount++;
                    } else {
                      String trimmedValue = value.trim();
                      if (trimmedValue.isEmpty) {
                        emptyCount++;
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
                padding: EdgeInsets.all(5),
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
                  obscureText: false,
                  enableSuggestions: false,
                  autocorrect: false,

                  validator: (value) {
                    if (value == null) {
                      emptyCount++;
                    } else {
                      String trimmedValue = value.trim();
                      if (trimmedValue.isEmpty) {
                        emptyCount++;
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
                 padding: EdgeInsets.all(5),
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
                      emptyCount++;
                    } else {
                      String trimmedValue = value.trim();
                      if (trimmedValue.isEmpty) {
                        //return 'Password field cannot be empty';
                        emptyCount++;
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
              padding: EdgeInsets.all(5),
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
                obscureText: false,
                enableSuggestions: false,
                autocorrect: false,

                validator: (value) {
                  if (value == null) {
                    emptyCount++;
                  } else {
                    String trimmedValue = value.trim();
                    if (trimmedValue.isEmpty) {
                      emptyCount++;
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
                onPressed: () {
                  //save changes
                  setState(() {
                    if(emptyCount == 4){
                      showAlertDialog("Invalid Input", "At least one of the fields should not be empty.");
                    }
                    else{

                    }
                  });
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