import 'package:bid_here/Models/user_model.dart';
import 'package:bid_here/Routes/routes.dart';
import 'package:bid_here/Screens/screen_add_products.dart';
import 'package:bid_here/Screens/screen_add_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenSeller extends StatefulWidget {
  const ScreenSeller({Key? key}) : super(key: key);

  @override
  State<ScreenSeller> createState() => _ScreenSellerState();
}

class _ScreenSellerState extends State<ScreenSeller> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then(
      (value) {
        loggedInUser = UserModel.fromMap(
          value.data(),
        );
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(25),
            ),
            width: 175,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 1,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenAddProcucts(userId: loggedInUser.userId,),
                      ),
                    );
                  },
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(25),
            ),
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 1),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(myProductRoute);
                  },
                  child: const Text(
                    ' My Products',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}