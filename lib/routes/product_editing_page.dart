import 'package:cs310_step3/utils/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '/utils/color.dart';
import '/utils/styles.dart';
import 'login_page.dart';
import 'package:path/path.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:cs310_step3/utils/productClass.dart';


class ProductEditingPage extends StatefulWidget {

  ProductEditingPage({Key? key, required this.myProduct, this.myUser}) : super(key: key);
  final Product myProduct;
  UserFirebase? myUser;
  //int emptyCount = 0;

  @override
  _ProductEditingPageState createState() => _ProductEditingPageState();
}

class _ProductEditingPageState extends State<ProductEditingPage> {

  PageController pageController = PageController();
  final formKey = GlobalKey<FormState>();
  late String photoUrl;
  int emptyCount = 0;
  String newProductName = "";
  String newCategoryName = "";
  late int newPrice;
  String newDescription = "";
  String newPhotoUrl = "";
  String priceSeyi = "EMPTY_FIELD";
  bool isChanged = false;


  @override
  void initState() {
    super.initState();
    photoUrl = "";
  }

  @override
  Widget build(BuildContext context) {



    Future<void> showAlertDialog(String title, String message) async {
      return showDialog(context: context,
          barrierDismissible: false, //must take action
          builder: (BuildContext context) {
            if (isIOS) {
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

                    Navigator.of(context).pop();
                  },
                      child: Text("OK"))
                ],
              );
            }
          }
      );
    }


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

    bool isNumeric(String s) {
      if(s == null) {
        return false;
      }
      return int.tryParse(s) != null;
    }

    Future pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = pickedFile;
      });
      uploadImageToFirebase(context);
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: AppColors.primary,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Padding(

                  padding:const EdgeInsets.all(10),
                  child:CircleAvatar(
                    radius: 25,
                    child: ClipOval(
                      child: Image.network(widget.myProduct!.photoUrl!,
                        fit: BoxFit.fill, height: 200, width: 100,),
                    ),
                  ),
                ),
                Padding(

                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(
                    child: Text("Change Product Picture", textAlign: TextAlign.center, style: loginSignupOrContinueSmallTextStyleBlack),
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
                  hintText: 'Name of Product',
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
                    newProductName = value;

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
                  hintText: 'Category of the Product',
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
                    newCategoryName = value;
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
                  hintText: 'Price of the Product (Please only enter integers)',
                  errorStyle: loginErrorStyle,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                //text from field passwords

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
                    priceSeyi = value;
                    var one = int.tryParse(priceSeyi);
                    if(one != null){
                      newPrice = one;
                    }
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
                  hintText: 'Description about the Product',
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
                    newDescription = value;
                  }
                },
              ),
            ),
            Padding(

              padding: const EdgeInsets.all(2),
              child: OutlinedButton(
                child: Text("Save Changes", textAlign: TextAlign.center, style: loginSignupOrContinueSmallTextStyleBlack),
                onPressed: () async {
                  //

                  formKey.currentState!.save();
                  print("ASAGDA");
                  print("URI" + photoUrl);

                  if(photoUrl != "" )
                  {
                    await updateProductPhotoUrl(widget.myProduct.name! + widget.myProduct.seller!, photoUrl);
                    isChanged = true;
                  }
                  if(newProductName != ""){
                    updateProductName(widget.myProduct.name! + widget.myProduct.seller!, newProductName);
                    isChanged = true;
                  }
                  if(newDescription != ""){
                    updateProductDescription(widget.myProduct.name! + widget.myProduct.seller!, newDescription);
                    isChanged = true;
                  }
                  if(priceSeyi != "EMPTY_FIELD" && priceSeyi != ""){ //this is problematic
                    updateProductPrice(widget.myProduct.name! + widget.myProduct.seller!, newPrice);
                    isChanged = true;
                  }
                  if(newCategoryName != ""){
                    updateProductCategory(widget.myProduct.name! + widget.myProduct.seller!, newCategoryName);
                    isChanged = true;
                  }


                  if(isChanged){
                    addNotificaitonToUser(widget.myUser!.email!, "You have edited your product successfully.");
                    showAlertDialog("Success", "Your changes have been saved successfully.");
                  }

                  setState(() {});

                },
              ),

            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:10),
                  child: Column(
                    children: [
                      Text("This product is currently on sale."),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:10),
                  child: Row(
                    children: [
                      OutlinedButton(
                        onPressed: (){
                          //removing product
                          removeFromProductList(widget.myUser!.email!, widget.myProduct.name! + widget.myProduct.seller!);
                          deleteProduct(widget.myProduct.name! + widget.myProduct.seller!);
                          print("****************************here***********************");
                          showAlertDialog("Success", "Your product has been deleted successfully.");
                          setState(() {});

                        },
                        child: Row(children: [
                          Text("Remove Product", style: TextStyle(color: Colors.red)),
                          Icon(Icons.delete, color: Colors.red),

                        ],),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
