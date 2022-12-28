import 'package:flutter/material.dart';
import 'package:p_m_m/models/category/category_model.dart';


class ScreenAddTransaction extends StatelessWidget {

  static const routeName = 'add-transactions';

  const ScreenAddTransaction({super.key});
  //! Data for Transaction
  /* 
  Pupose
  Date
  Amount
  Income/Expense
  CategoryType

  */

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Purpose',
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Amount',
                ),
              ),
              const SizedBox(height: 10,),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.calendar_today),
                label: const Text('Select Data'),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: CategoryType.income,
                        onChanged: (newValue) {

                        },
                      ),
                      const Text('Income'),
                    ],
                  ),

                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: CategoryType.expense,
                        onChanged: (newValue) {

                        },
                      ),
                      const Text('Expense'),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}