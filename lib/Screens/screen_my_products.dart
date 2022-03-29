import 'dart:html';

import 'package:bid_here/Models/product_model.dart';
import 'package:bid_here/Models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenMyPRoducts extends StatefulWidget {
  const ScreenMyPRoducts({Key? key}) : super(key: key);

  @override
  State<ScreenMyPRoducts> createState() => _ScreenMyPRoductsState();
}

class _ScreenMyPRoductsState extends State<ScreenMyPRoducts> {
  ProductList productList = ProductList();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('product')
        .doc(user!.uid)
        .collection('product list')
        .doc()
        .get()
        .then(
      (value) {
        productList = ProductList.fromMap(
          value.data(),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ));
     
          // return GridView.builder(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 1,
          //       childAspectRatio: 3 / 2,
          //       mainAxisSpacing: 30),
          //   itemBuilder: (context, index) {
//               return Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 2.75,
//                     decoration: BoxDecoration(
//                       color: Colors.amber,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Row(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: 175,
//                                 height: 224,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black38,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: ,
//                               )
//                             ],
//                           ),
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   child: Center(
//                                     child: Column(
//                                       children: const [
//                                         Text(
//                                           'S.No:',
//                                           textAlign: TextAlign.start,
//                                         ),
//                                         SizedBox(
//                                           height: 25,
//                                         ),
//                                         Text(
//                                           ' Name:',
//                                           textAlign: TextAlign.start,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
   }
 }
