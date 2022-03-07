import 'package:bid_here/Screens/home/screen_home.dart';
import 'package:flutter/material.dart';

class BidHereBottomNavigation extends StatelessWidget {
  const BidHereBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndex,
      builder: (BuildContext context, int updatedIndex, Widget? _) {
        return BottomNavigationBar(elevation: 0,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
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
              label: 'Buyer',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.attach_money,
              ),
              label: 'Seller',
            ),
          ],
        );
      },
    );
  }
}
