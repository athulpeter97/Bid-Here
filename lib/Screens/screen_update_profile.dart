import 'dart:developer';

import 'package:bid_here/Models/user_model.dart';
import 'package:bid_here/Routes/routes.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenUpdateProfile extends StatefulWidget {
  const ScreenUpdateProfile({Key? key, required}) : super(key: key);

  @override
  State<ScreenUpdateProfile> createState() => _ScreenUpdateProfileState();
}

class _ScreenUpdateProfileState extends State<ScreenUpdateProfile> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  //text editing controllers

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressLine1Controller = TextEditingController();
  TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  @override
  void initState() {
    FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then(
      (value) {
        loggedInUser = UserModel.fromMap(
          value.data(),
        );

        setState(
          () {
            _firstnameController = TextEditingController(
              text: loggedInUser.firstName,
            );
            _lastNameController = TextEditingController(
              text: loggedInUser.lastName,
            );
            _addressLine1Controller = TextEditingController(
              text: loggedInUser.addressLine1,
            );
            _addressLine2Controller = TextEditingController(
              text: loggedInUser.addressLine2,
            );
            _cityController = TextEditingController(
              text: loggedInUser.city,
            );
            _stateController = TextEditingController(
              text: loggedInUser.state,
            );
            _pincodeController = TextEditingController(
              text: loggedInUser.pincode,
            );
          },
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastNameController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SafeArea(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _firstnameController.text = value!;
                        },
                        controller: _firstnameController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'First Name',
                        ),
                      ),
                      const SizedBox(height: 20),

                      //last name field

                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                        controller: _lastNameController,
                        onSaved: (value) {
                          _lastNameController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Last Name',
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _addressLine1Controller.text = value!;
                        },
                        controller: _addressLine1Controller,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          hintText: 'Address Line 1',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _addressLine2Controller.text = value!;
                        },
                        controller: _addressLine2Controller,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          hintText: 'Address Line 2',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city name';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _cityController.text = value!;
                        },
                        controller: _cityController,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          hintText: 'City',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your state';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _stateController.text = value!;
                        },
                        controller: _stateController,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          hintText: 'State',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your pincode';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        onSaved: (value) {
                          _pincodeController.text = value!;
                        },
                        controller: _pincodeController,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          hintText: 'Pincode',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await updateProfile();
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateProfile() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values

    userModel.email = user!.email;
    userModel.userId = user.uid;
    userModel.firstName = _firstnameController.text;
    userModel.lastName = _lastNameController.text;
    userModel.addressLine1 = _addressLine1Controller.text;
    userModel.addressLine2 = _addressLine2Controller.text;
    userModel.city = _cityController.text;
    userModel.state = _stateController.text;
    userModel.pincode = _pincodeController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update(userModel.toMap());

    Fluttertoast.showToast(msg: 'Profile Updated');
    Navigator.of(context)
        .pushNamedAndRemoveUntil(profileRoute, (route) => false);
  }
}
