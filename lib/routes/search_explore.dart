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
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: FirestoreSearchScaffold(
       appBarBackgroundColor: AppColors.primary,
       firestoreCollectionName: 'products',
       searchBy: 'seller',
       scaffoldBody: const Center(child: Text('Product search')),
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
                     print(item.category);
                   }
                   else
                   {
                     allCategories[item.category] = [item];
                     categoryList.add(item.category);
                   }
                 }
             }

           return ListView.builder(
               itemCount: categoryList.length,
               shrinkWrap: true,
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
                         //scrollDirection: Axis.horizontal,
                         itemCount: allCategories[cur]?.length ?? 0,
                         itemBuilder: (context, i)
                         {
                           final DataModel data = allCategories[cur]![i];
                           return Row(
                             children: [
                               Flexible(
                                 child: ConstrainedBox(
                                   constraints: BoxConstraints(maxWidth: 360),
                                   child: Card(
                                     child: ListTile(
                                       title: Text('${data.name}', style: Theme.of(context).textTheme.headline6,),
                                       subtitle: Text('${data.seller}' + "\n" + "${data.price}" + "TL"),
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           );
                         }
                     ),
                     Divider(),
                   ],
                 );
               });
         }
           /*
           return ListView.builder(
               itemCount: dataList?.length ?? 0,
               itemBuilder: (context, index) {
                 final DataModel data = dataList![index];

                 return Column(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                         '${data.name}',
                         style: Theme.of(context).textTheme.headline6,
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(
                           bottom: 8.0, left: 8.0, right: 8.0),
                       child: Text('${data.seller}',
                           style: Theme.of(context).textTheme.bodyText1),
                     )
                   ],
                 );
               });
         }
            */


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