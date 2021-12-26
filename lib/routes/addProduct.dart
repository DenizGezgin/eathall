import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:cs310_step3/utils/styles.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}


class addProductPage extends StatefulWidget {
  addProductPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  _addProductPageState createState() => _addProductPageState();
}

class _addProductPageState extends State<addProductPage> {


  late String category;
  late String namec;
  late String seller;
  late int price;
  late String photoUrl;
  late String description;

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
  void initState() {
    super.initState();
    category = "";
    namec = "";
    seller = "";
    price = 0;
    photoUrl = "";
    description = "";
  }

  @override
  Widget build(BuildContext context) {

    Future pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = pickedFile;
      });
      uploadImageToFirebase(context);
    }


    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row( //NAME FIELD
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
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
                          namec = value.capitalize();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row( //Category
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: AppColors.background,
                        filled: true,
                        hintText: 'Category',
                        errorStyle: loginErrorStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,

                      validator: (value) {
                        if (value == null) {
                          return 'Category field cannot be empty';
                        } else {
                          String trimmedValue = value.trim();
                          if (trimmedValue.isEmpty) {
                            return 'Category field cannot be empty';
                          }
                        }
                        return null;
                      },

                      onSaved: (value) {
                        if (value != null) {
                          category = value.capitalize();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row( //Seller
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: AppColors.background,
                        filled: true,
                        hintText: 'Seller',
                        errorStyle: loginErrorStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,

                      validator: (value) {
                        if (value == null) {
                          return 'Seller field cannot be empty';
                        } else {
                          String trimmedValue = value.trim();
                          if (trimmedValue.isEmpty) {
                            return 'Seller field cannot be empty';
                          }
                        }
                        return null;
                      },

                      onSaved: (value) {
                        if (value != null) {
                          seller = value.capitalize();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row( //price
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: AppColors.background,
                        filled: true,
                        hintText: 'Price(Must be int)',
                        errorStyle: loginErrorStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,

                      validator: (value) {
                        if (value == null) {
                          return 'Price field cannot be empty';
                        } else {
                          String trimmedValue = value.trim();
                          if (trimmedValue.isEmpty) {
                            return 'Price field cannot be empty';
                          }
                        }
                        return null;
                      },

                      onSaved: (value) {
                        if (value != null) {
                          price = int.parse(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row( //Descp.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: AppColors.background,
                        filled: true,
                        hintText: 'description',
                        errorStyle: loginErrorStyle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      maxLines: 5,
                      minLines: 3,
                      keyboardType: TextInputType.text,

                      validator: (value) {
                        if (value == null) {
                          return 'Description field cannot be empty';
                        } else {
                          String trimmedValue = value.trim();
                          if (trimmedValue.isEmpty) {
                            return 'Description field cannot be empty';
                          }
                        }
                        return null;
                      },

                      onSaved: (value) {
                        print("AAAAAAGH");
                        if (value != null) {
                          print(description);
                          description = value;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Container(
                height: 150,
                margin: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: _image != null
                        ? Image.file(File(_image!.path)) : TextButton(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 100,
                        color: Colors.white,
                      ),

                      onPressed: pickImage,
                    )
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          if (widget.formKey.currentState!.validate()) {
                            widget.formKey.currentState!.save();
                            print(namec + " " + category + " " + seller + " " + price.toString() + " " + description + " " + photoUrl);
                            addProduct(namec, category, seller, price, description, photoUrl);
                          }
                          else {}
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0),
                          child: Text("Add Product",
                            style: loginButtonTextStyle,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}
