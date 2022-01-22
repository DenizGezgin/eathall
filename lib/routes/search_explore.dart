import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:cs310_step3/utils/prodcutPage.dart';
import 'package:cs310_step3/utils/user.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import  '/utils/productDetails.dart';
import 'package:cs310_step3/utils/productClass.dart';

class SearchFeed extends StatefulWidget {
  SearchFeed({Key? key, this.myUser}) : super(key: key);
  UserFirebase? myUser;

  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  List<String> searchTypes = ["sellerDisplayName", "displayName"];
  late int currentSearchType;
  late String currentFilter;

  @override
  void initState(){
    super.initState();
    currentSearchType = 0;
    currentFilter = "alphabetical";
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     body: FirestoreSearchScaffold(
       appBarBackgroundColor: AppColors.primary,
       firestoreCollectionName: 'products',
       searchBy: searchTypes[currentSearchType],
       scaffoldBody: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
         child: Column(
           children: [Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text("Search by: "),
                 OutlinedButton(onPressed: (){
                   setState(() {
                     currentSearchType = 0;
                   });
                 }, child: Text("Seller")),
                 OutlinedButton(onPressed: (){
                   setState(() {
                     currentSearchType = 1;
                   });
                 }, child: Text("Name")),

                 PopupMenuButton<String>(
                   icon: Icon(Icons.filter_alt),
                   onSelected: (String result) {
                     switch (result) {
                       case 'alphabetical':
                         print('filter 1 clicked');
                         setState(() {
                           currentFilter = "alphabetical";
                         });
                         break;
                       case 'lowToHigh':
                         print('filter 2 clicked');
                         setState(() {
                           currentFilter = "lowToHigh";
                         });
                         break;
                       case 'highToLow':
                         print('filter 3 clicked');
                         setState(() {
                           currentFilter = "highToLow";
                         });
                         break;
                       default:
                     }
                   },
                   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                     const PopupMenuItem<String>(
                       value: 'alphabetical',
                       child: Text('Sort names alphabetical.'),
                     ),
                     const PopupMenuItem<String>(
                       value: 'lowToHigh',
                       child: Text('Sort by price lower to higher.'),
                     ),
                     const PopupMenuItem<String>(
                       value: 'highToLow',
                       child: Text('Sort by price higher to lower.'),
                     ),
                   ],
                 ),



               ]
           ),
           Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
             Text("Search items to see results")])]
         ),),
       dataListFromSnapshot: DataModel().dataListFromSnapshot,
       builder: (context, snapshot) {

         if (snapshot.hasData) {
           final List<DataModel> dataList = snapshot.data;

           Map<String?, List<DataModel>> allCategories = {};
           List<String?> categoryList = [];

           for(DataModel item in dataList)
             {
               if(item.category != null)
                 {
                   if(categoryList.contains(item.category))
                   {
                     allCategories[item.category]!.add(item);
                   }
                   else
                   {
                     allCategories[item.category] = [item];
                     categoryList.add(item.category);
                   }
                 }
             }
           //Apply fiters
           categoryList.sort();
           for(String? currentCategory in categoryList)
             {
               if(currentFilter == "alphabetical")
                 {
                   allCategories[currentCategory]!.sort((a, b) => a.name!.compareTo(b.name!));
                 }
               if(currentFilter == "lowToHigh")
               {
                 allCategories[currentCategory]!.sort((a, b) => a.price!.compareTo(b.price!));
               }
               if(currentFilter == "highToLow")
               {
                 allCategories[currentCategory]!.sort((a, b) => b.price!.compareTo(a.price!));
               }

             }

           return Column(
           children: [
             Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
               child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Text("Search by: "),
                     OutlinedButton(onPressed: (){
                       setState(() {
                         currentSearchType = 0;
                       });
                     }, child: Text("Seller")),
                     OutlinedButton(onPressed: (){
                       setState(() {
                         currentSearchType = 1;
                       });
                     }, child: Text("Name")),
                     PopupMenuButton<String>(
                       icon: Icon(Icons.filter_alt),
                       onSelected: (String result) {
                         switch (result) {
                           case 'alphabetical':
                             print('filter 1 clicked');
                             setState(() {
                               currentFilter = "alphabetical";
                             });
                             break;
                           case 'lowToHigh':
                             print('filter 2 clicked');
                             setState(() {
                               currentFilter = "lowToHigh";
                             });
                             break;
                           case 'highToLow':
                             print('filter 3 clicked');
                             setState(() {
                               currentFilter = "highToLow";
                             });
                             break;
                           default:
                         }
                       },
                       itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                         const PopupMenuItem<String>(
                           value: 'alphabetical',
                           child: Text('Sort names alphabetical.'),
                         ),
                         const PopupMenuItem<String>(
                           value: 'lowToHigh',
                           child: Text('Sort by price lower to higher.'),
                         ),
                         const PopupMenuItem<String>(
                           value: 'highToLow',
                           child: Text('Sort by price higher to lower.'),
                         ),
                       ],
                     ),

                   ]
               ),),
           SingleChildScrollView(
             scrollDirection: Axis.vertical,
             physics: AlwaysScrollableScrollPhysics(),
             child: Container(
               height: 479,
               //margin: EdgeInsets.only(top: 20),
               child: ListView.builder(
               itemCount: categoryList.length,
                   shrinkWrap: true,
         physics: AlwaysScrollableScrollPhysics(),

         scrollDirection: Axis.vertical,

                   itemBuilder: (context, index) {


                     final String? cur = categoryList[index];

                     return Column(
                       children: [
                         Text(cur!,
                           style: Theme.of(context).textTheme.headline6,
                         ),
                         SizedBox(),
                         ListView.builder(
                             shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),

                             //scrollDirection: Axis.horizontal,
                             itemCount: allCategories[cur]?.length ?? 0,
                             itemBuilder: (context, i)
                             {
                               final DataModel data = allCategories[cur]![i];
                               return Row(
                                 children: [
                                   Flexible(
                                     child: ConstrainedBox(
                                         constraints: BoxConstraints(maxWidth: 400),
                                         child: Padding(
                                           padding: EdgeInsets.only(left: 10.0),
                                           child: Container(
                                             height: 100,
                                             child: Card(
                                               semanticContainer: true,
                                               elevation: 2,
                                               clipBehavior: Clip.antiAliasWithSaveLayer,
                                               child: ListTile(
                                                 title: Text('${data.name}', style: Theme.of(context).textTheme.headline6,),
                                                 subtitle: Text('${data.seller}' + "\n" + "${data.price}" + "TL"),
                                                 leading: Image.network(data.photoUrl!,
                                                     fit: BoxFit.fill,
                                                 ),
                                                 trailing: FlatButton(
                                                   child: Text("Go to Product"),
                                                   onPressed: () async{
                                                     Product serachFind = await getProdcutWithUrl(data.name! + data.seller!);
                                                     Navigator.push(
                                                         context,
                                                         MaterialPageRoute(
                                                             builder: (context) => productPage(myUser: widget.myUser,myProduct: serachFind),
                                                         ));
                                                   },
                                                 ),
                                               ),
                                             ),
                                           ),
                                         )
                                     ),
                                   ),
                                 ],
                               );
                             }
                         ),
                         Divider(thickness: 0,),
                       ],
                     );
                   }),
             ),
           ),
           ],
           );
         }


         if (snapshot.connectionState == ConnectionState.done) {
           final List<DataModel>? dataList = snapshot.data;

           if (!snapshot.hasData){
             return const Center(child: Text('No Results Returned'),);
           }
         }
         return const Center(
           child: CircularProgressIndicator(),
         );
       },
     ),

   );
  }
}


