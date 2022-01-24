import 'package:cs310_step3/routes/profile_page.dart';
import 'package:cs310_step3/routes/search_explore.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'addProduct.dart';
import 'feedView.dart';
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
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
  EditProfilePage({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;
}

class  _EditProfilePageState extends State<EditProfilePage>{
  final formKey = GlobalKey<FormState>();
  String nameUser = "";
  String surnameUser = "";
  String addressUser = "";
  String passUser = "";
  int emptyCount = 0;
  bool isChanged = false;

  PageController pageController = PageController();
  late String photoUrl;

  @override
  void initState() {
    super.initState();
    photoUrl = "";
  }

  @override
  Widget build(BuildContext context) {

    final ImagePicker _picker = ImagePicker();
    XFile? _image;

    Future uploadImageToFirebase(BuildContext context) async {
      String fileName = basename(_image!.path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('userData/$fileName');
      try {
        await firebaseStorageRef.putFile(File(_image!.path));
        photoUrl = (await firebaseStorageRef.getDownloadURL()).toString();
        print("URI::::   "+ photoUrl!);
        print("Upload complete");
      } on FirebaseException catch(e) {
        print('ERROR: ${e.code} - ${e.message}');
      } catch (e) {
        print(e.toString());
      }
    }

    Future pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = pickedFile;
      });
      uploadImageToFirebase(context);
    }

    final user = Provider.of<User?>(context);

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
                      child: Text("OK", style: TextStyle(color: AppColors.purchaseAndAdd)))
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
      ),
      body: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(

                    padding:const EdgeInsets.all(10),
                    child:CircleAvatar(
                      radius: 25,
                      child: ClipOval(
                        child: Image.network(widget.myUser!.photoUrl!,
                          fit: BoxFit.fill, height: 200, width: 100,),
                      ),
                    ),
                  ),
                  Padding(

                    padding: const EdgeInsets.all(10),
                    child: OutlinedButton(
                      child: Text("Change Profile Picture", textAlign: TextAlign.center, style: loginSignupOrContinueSmallTextStyleBlack),
                      onPressed: () async {
                        await pickImage();
                        setState(() {

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
                        passUser = value;
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
                      addressUser = value;

                    }
                  },
                ),
              ),

              Padding(

                padding: const EdgeInsets.all(2),
                child: OutlinedButton(
                  child: Text("Save Changes", textAlign: TextAlign.center, style: TextStyle(color: AppColors.purchaseAndAdd)),
                  onPressed: () async {
                    print(photoUrl + "  photo url");
                    print("********************here*******************");
                    formKey.currentState!.save();

                    if(photoUrl != "" )
                    {
                      isChanged = true;
                      await updateUserPic(widget.myUser!.email!,photoUrl);
                      widget.myUser!.photoUrl = photoUrl;
                    }
                    if(nameUser != ""){
                      isChanged = true;
                      print("ife girdi");
                      await updateUserName(widget.myUser!.email!, nameUser);
                    }
                    if(surnameUser != ""){
                      isChanged = true;
                      await updateUserSurname(widget.myUser!.email!, surnameUser);
                    }
                    if(addressUser != ""){
                      isChanged = true;
                      await updateUserAddress(widget.myUser!.email!, addressUser);
                    }
                    if(passUser != ""){
                      isChanged = true;
                      await changePassword(passUser);
                      auth.signOut();
                      Navigator.pushNamed(context, "/Welcome");
                    }

                    //save changes
                    setState((){
                    });
                    if(isChanged){
                      await addNotificaitonToUser(widget.myUser!.email!, "You have edited your profile successfully.");
                      await showAlertDialog("Success", "Your changes have been saved successfully. Please login again to see your changes.");
                      auth.signOut();
                      Navigator.pushNamed(context, "/Welcome");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}