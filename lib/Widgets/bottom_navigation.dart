import 'package:bid_here/Screens/screen_home.dart';
import 'package:flutter/material.dart';

class BidHereBottomNavigation extends StatelessWidget {
  const BidHereBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndex,
      builder: (BuildContext ctx, int updatedIndex, _) {
        return ValueListenableBuilder(
          valueListenable: ScreenHome.selectedIndex,
          builder: (BuildContext context, int updatedIndex, _) {
            return BottomNavigationBar(
              selectedItemColor: Colors.purple,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              currentIndex: updatedIndex,
              onTap: (newIndex) {
                ScreenHome.selectedIndex.value = newIndex;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                    label: 'Buyer'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.attach_money,
                    ),
                    label: 'Seller'),
              ],
            );
          },
        );
      },
    );
  }
}
