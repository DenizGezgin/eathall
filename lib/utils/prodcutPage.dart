import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/productClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';

class productPage extends StatefulWidget {
  const productPage({Key? key, required this.myProduct}) : super(key: key);
  final Product myProduct;

  @override
  _productPageState createState() => _productPageState();
}

class _productPageState extends State<productPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF973333),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        height: 200.0,
        child: ClipRect(
          child: PhotoView(
            imageProvider: NetworkImage(widget.myProduct.photoUrl!),
            maxScale: PhotoViewComputedScale.covered * 2.0,
            minScale: PhotoViewComputedScale.contained * 0.8,
            initialScale: PhotoViewComputedScale.covered,
          ),
        ),
    ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(widget.myProduct.name!,
              style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 28),)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (){},
                  child: Text(widget.myProduct.seller!,
                    style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey,
                        fontSize: 18),),
                )
              ],),
            RatingBarIndicator(
              rating: widget.myProduct.rating!,
              itemBuilder: (context, index) => Icon(
                Icons.local_pizza_outlined,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 50.0,
              direction: Axis.horizontal,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 370.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white)

                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                        widget.myProduct.description!,
                        style: TextStyle(
                          fontFamily: 'Arial',
                          color: Colors.grey,
                          fontSize: 18,
                          height: 1,
                        ),
                      ),
                  ),
                  ),
              ],),
            SizedBox(height: 2,),
             Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${widget.myProduct.price} TL",
                    style: TextStyle(
                      fontFamily: 'Arial',
                      color: AppColors.primary,
                      fontSize: 18,
                      height: 1,
                    ),),
                  Row(
                      children: [
                        Text("Add to Cart",
                          style: TextStyle(
                            fontFamily: 'Arial',
                            color: Colors.green,
                            fontSize: 18,
                            height: 1,
                          ),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart, color: Colors.green,))], ),

                ],
              ),
            ),
            Divider(),
            ListView.builder(
                itemCount: widget.myProduct.comments!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
              return Card(
                  semanticContainer: true,
                  elevation: 2,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ListTile(
                    title: Text(
                        widget.myProduct.comments![index]["user"],
                    ),
                    subtitle: Text(
                      widget.myProduct.comments![index]["data"],
                    ),
                    trailing: RatingBarIndicator( //-0000.1
                      rating: widget.myProduct.comments![index]["rating"],
                      itemBuilder: (context, index) => Icon(
                        Icons.local_pizza_outlined,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ),
                );
            })


          ],





        ),
      ),
    );
  }
}



