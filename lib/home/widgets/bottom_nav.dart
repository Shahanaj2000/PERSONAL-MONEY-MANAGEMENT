import 'package:flutter/material.dart';
import 'package:p_m_m/home/Screeen_home.dart';


class MoneyManagementBottomNavigation extends StatelessWidget {
  const MoneyManagementBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: updatedIndex,
        onTap: (newIndex) {
          ScreenHome.selectedIndexNotifier.value = newIndex;
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Transaction'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories')
        ],
      );
      },
    );
  }
}