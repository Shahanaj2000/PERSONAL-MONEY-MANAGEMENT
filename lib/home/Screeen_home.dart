
import 'package:flutter/material.dart';
import 'package:p_m_m/Screens/category/Screen_category.dart';
import 'package:p_m_m/Screens/category/category_add_popup.dart';
import 'package:p_m_m/home/widgets/bottom_nav.dart';
import 'package:p_m_m/Screens/transactions/Screen_transaction.dart';


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
      appBar: AppBar(
        title: const Text('MONEY MANAGEMENT'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, Widget? _) {
            return _pages[updateIndex];
          },
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add Transaction');
          } else {
            print("Add Categorey");
            
            showCategoryAddPopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const MoneyManagementBottomNavigation(),
    );
  }
}