import 'package:bid_here/Models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenBuyer extends StatefulWidget {
  const ScreenBuyer({Key? key}) : super(key: key);

  @override
  State<ScreenBuyer> createState() => _ScreenBuyerState();
}

class _ScreenBuyerState extends State<ScreenBuyer> {
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
      child: Text('screen buyer'),
    );
  }
}
