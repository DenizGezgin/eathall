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
  late String photoUrl;
  int emptyCount = 0;
  String newProductName = "";
  String newCategoryName = "";
  int newPrice = 0;
  String newDescription = "";
  String newPhotoUrl = "";


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
      body: Column(
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
                  updateProductName(widget.myProduct.name! + widget.myProduct.seller!, newProductName);
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
                  updateProductCategory(widget.myProduct.name! + widget.myProduct.seller!, newCategoryName);
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
                hintText: 'Price of the Product',
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
                  var one = int.parse(value);
                  newPrice = one;
                  updateProductPrice(widget.myProduct.name! + widget.myProduct.seller!, newPrice);
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
                  updateProductDescription(widget.myProduct.name! + widget.myProduct.seller!, newDescription);
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("This product is on sale.", style: TextStyle(color: Colors.black)),
                OutlinedButton(
                  onPressed: (){
                    //removing product
                  },
                  child: Text("Remove Product"),
                ),
              ],
            ),
          ),
          Padding(

            padding: const EdgeInsets.all(2),
            child: OutlinedButton(
              child: Text("Save Changes", textAlign: TextAlign.center, style: loginSignupOrContinueSmallTextStyleBlack),
              onPressed: () async {
                print(photoUrl);
                if(photoUrl != "" )
                {
                  await updateProductPhotoUrl(widget.myProduct.name! + widget.myProduct.seller!, photoUrl);
                }
                //save changes
                setState(() {});
              },
            ),

          ),
        ],
      ),
    );
  }
}
