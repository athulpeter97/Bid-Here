import 'dart:io';

import 'package:bid_here/Models/product_model.dart';
import 'package:bid_here/Models/user_model.dart';
import 'package:bid_here/Routes/routes.dart';
import 'package:bid_here/Widgets/date_range_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenAddProcucts extends StatefulWidget {
  String? userId;
  String? productId;

  ScreenAddProcucts({Key? key, this.userId}) : super(key: key);

  @override
  State<ScreenAddProcucts> createState() => _ScreenAddProcuctsState();
}

class _ScreenAddProcuctsState extends State<ScreenAddProcucts> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURl;

  ProductList productList = ProductList();
 final TextEditingController _productName =  TextEditingController();
  final TextEditingController _productDescription =  TextEditingController();
  final TextEditingController _productPrice =  TextEditingController();
  final TextEditingController _serialNumber =  TextEditingController();

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
  void dispose() {
    _productName.dispose();
    _productDescription.dispose();
    _productPrice.dispose();
    _serialNumber.dispose();
    super.dispose();
  }

  //image picker

  Future imagePickerMethod() async {
// picking image
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(
      () {
        if (pick != null) {
          _image = File(pick.path);
        } else {
          showSnackBar(
            'No file selected',
            const Duration(
              seconds: 5,
            ),
          );
        }
      },
    );
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// uploading images to firebase

  Future addProduct() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    if (_image != null) {
      final postId = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("${widget.userId}/Images")
          .child("post_$postId");
      await ref.putFile(_image!);
      downloadURl = await ref.getDownloadURL();

      print(downloadURl);

      //getting document id very important
      
      DocumentReference doc_ref = FirebaseFirestore.instance
          .collection("product")
          .doc(loggedInUser.userId)
          .collection("product_list")
          .doc();
      DocumentSnapshot docSnap = await doc_ref.get();
      var docId = docSnap.reference.id;
      // uploading to firestore
      productList.userId = loggedInUser.userId;
      productList.productName = _productName.text;
      productList.productDescription = _productDescription.text;
      productList.price = _productPrice.text;
      productList.imageUrl = downloadURl;
      productList.serialNumber = _serialNumber.text;
      productList.productId = docId;

      await firebaseFirestore
          .collection("product")
          .doc(productList.userId)
          .collection('product_list')
          .doc(docId)
          .set(productList.toMap())
          .whenComplete(
            () => showSnackBar(
              'Product added',
              const Duration(seconds: 5),
            ),
          );
      setState(() {
        _productName.clear();
        _productDescription.clear();
        _productPrice.clear();
        _serialNumber.clear();
        _image = null;
      });
    } else {
      showSnackBar(
        'No image selected',
        const Duration(
          seconds: 5,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Add Products',
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.transparent,
                      ),
                      child: _image == null
                          ? const Center(
                              child: Text('No image selected'),
                            )
                          : Image.file(_image!),
                    ),
                    Positioned(
                      right: 20,
                      top: 5,
                      child: IconButton(
                        onPressed: () {
                          imagePickerMethod();
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product serial number';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _serialNumber.text = value!;
                  },
                  controller: _serialNumber,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Enter product serial number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _productName.text = value!;
                  },
                  controller: _productName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Enter product name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productDescription.text = value!;
                  },
                  controller: _productDescription,
                  textInputAction: TextInputAction.next,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Enter product description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productPrice.text = value!;
                  },
                  controller: _productPrice,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Date Range',
                ),
                const SizedBox(
                  height: 15,
                ),
                const DateRangeWidget(),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await addProduct();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      Text(
                        'Add  Product',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
