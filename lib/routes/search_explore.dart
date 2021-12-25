import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_step3/utils/color.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import  '/utils/productDetails.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({Key? key}) : super(key: key);

  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  List<String> searchTypes = ["seller", "name"];
  late int currentSearchType;

  @override
  void initState(){
    super.initState();
    currentSearchType = 0;
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     body: FirestoreSearchScaffold(
       appBarBackgroundColor: AppColors.primary,
       firestoreCollectionName: 'products',
       searchBy: searchTypes[currentSearchType],
       scaffoldBody: Padding(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                     case 'filter1':
                       print('filter 1 clicked');
                       break;
                     case 'filter2':
                       print('filter 2 clicked');
                       break;
                     case 'alphabetical':
                       print('Clear filters');
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
                     value: 'filter2',
                     child: Text('Sort by price lower to higher.'),
                   ),
                   const PopupMenuItem<String>(
                     value: 'alphabetical',
                     child: Text('Sort by price lower to higher.'),
                   ),
                   const PopupMenuItem<String>(
                     value: 'alphabetical',
                     child: Text('Sort by ratings lower to higher.'),
                   ),
                   const PopupMenuItem<String>(
                     value: 'alphabetical',
                     child: Text('Filter items with rating.'),
                   ),
                   const PopupMenuItem<String>(
                     value: 'alphabetical',
                     child: Text('Sort by ratings lower to higher.'),
                   ),
                   const PopupMenuItem<String>(
                     value: 'alphabetical',
                     child: Text('Sort by ratings lower to higher.'),
                   ),
                 ],
               ),



             ]
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
               allCategories[currentCategory]!.sort((a, b) => a.name!.compareTo(b.name!));
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
                     }, child: Text("Name"))

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
                                         constraints: BoxConstraints(maxWidth: 380),
                                         child: Padding(
                                           padding: EdgeInsets.only(left: 30.0),
                                           child: Container(
                                             height: 100,
                                             child: Card(
                                               semanticContainer: true,
                                               elevation: 2,
                                               clipBehavior: Clip.antiAliasWithSaveLayer,
                                               child: ListTile(
                                                 title: Text('${data.name}', style: Theme.of(context).textTheme.headline6,),
                                                 subtitle: Text('${data.seller}' + "\n" + "${data.price}" + "TL"),
                                                 leading: Image.network("https://firebasestorage.googleapis.com/v0/b/eathall-ea871.appspot.com/o/product_images%2Findir.jpg?alt=media&token=ddbe3da4-f157-475e-b1fa-297dcbbeb684",
                                                     fit: BoxFit.fill,
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
           icon: Icon(Icons.favorite, color: Colors.white,),
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


