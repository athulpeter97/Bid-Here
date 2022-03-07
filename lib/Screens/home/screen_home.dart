import 'package:bid_here/Screens/Buyer/screen_buyer.dart';
import 'package:bid_here/Screens/Seller/screen_seller.dart';
import 'package:bid_here/Screens/home/Home%20Widgets/bottom_navigation_bar.dart';
import 'package:bid_here/Screens/home/Home%20Widgets/drawer.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final screens = const [
    ScreenBuyer(),
    ScreenSeller(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BidHereDrawer(),
      appBar: AppBar(
        title: const Text('Bid Here'),
      ),
      bottomNavigationBar: const BidHereBottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (BuildContext context,int updatedIndex,_){
          return screens[updatedIndex];
        }
      )),
    );
  }
}
