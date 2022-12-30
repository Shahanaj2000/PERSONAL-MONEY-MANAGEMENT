
import 'package:flutter/material.dart';
import 'package:p_m_m/db/transaction/transaction_db.dart';
import 'package:p_m_m/models/transaction/transaction_model.dart';


class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget?_) {
        return ListView.separated(
      padding: const EdgeInsets.all(13),
      //!Values
      itemBuilder: (BuildContext ctx, int index) {
        final _value = newList[index];
          return  Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 50,
                child: Text(
                  "01\nDec",
                  textAlign: TextAlign.center,
                ),
              ),
              title: Text('₹${_value.amount}'),
              subtitle: Text(_value.category.name), //Category Model
            ),
          );
      },
      separatorBuilder: (BuildContext ctx, int intex) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: newList.length,
    );
      },
    );
  }
}