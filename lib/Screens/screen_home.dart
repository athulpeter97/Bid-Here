import 'package:bid_here/Screens/screen_buyer.dart';
import 'package:bid_here/Screens/screen_seller.dart';
import 'package:bid_here/Widgets/bottom_navigation.dart';
import 'package:bid_here/Widgets/drawer.dart';
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
      appBar: AppBar(
        title: const Text('Bid Here'),
        backgroundColor: Colors.purple,
      ),
      drawer: const BidHereDrawer(),
      bottomNavigationBar: const BidHereBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (BuildContext context, int updatedIndex, _) {
            return screens[updatedIndex];
          },
        ),
      ),
    );
  }
}
