import 'package:bid_here/Funtions/logOut.dart';
import 'package:bid_here/Models/user_model.dart';
import 'package:bid_here/Routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BidHereDrawer extends StatefulWidget {
  const BidHereDrawer({Key? key}) : super(key: key);

  @override
  State<BidHereDrawer> createState() => _BidHereDrawerState();
}

class _BidHereDrawerState extends State<BidHereDrawer> {
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
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.purple,
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${loggedInUser.firstName}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${loggedInUser.lastName}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${loggedInUser.email}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 30,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(profileRoute);
            },
          ),
          const ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
            ),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 30,
            ),
            title: const Text(
              'LogOut',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
