
import 'package:flutter/material.dart';
import 'package:p_m_m/category/Screen_category.dart';
import 'package:p_m_m/home/widgets/bottom_nav.dart';
import 'package:p_m_m/transactions/Screen_transaction.dart';


class ScreenHome extends StatelessWidget {

  //! To change the selected Value
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];
  

  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, Widget? _) {
            return _pages[updateIndex];
          },
        ),

      ),
      bottomNavigationBar: const MoneyManagementBottomNavigation(),
    );
  }
}