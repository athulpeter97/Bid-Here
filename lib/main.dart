import 'package:bid_here/Routes/routes.dart';
import 'package:bid_here/Screens/Buyer/screen_buyer.dart';
import 'package:bid_here/Screens/Seller/screen_seller.dart';
import 'package:bid_here/Screens/home/Drawer%20Pages/profile.dart';
import 'package:bid_here/Screens/home/screen_home.dart';
import 'package:bid_here/Screens/screen_login.dart';
import 'package:bid_here/Screens/screen_signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bid Here',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // ignore: deprecated_member_use
      ),
      home: const ScreenLogin(),
      routes: {
        loginRoute: (context) => const ScreenLogin(),
        registerRoute: (context) => const ScreenSignUp(),
        homeRoute: (context) =>const  ScreenHome(),
        buyerRoute: (context) => const ScreenBuyer(),
        sellerRoute: (context) => const ScreenSeller(),
        profileRoute: (context) => const ScreenProfile(),
      },
    );
  }
}
