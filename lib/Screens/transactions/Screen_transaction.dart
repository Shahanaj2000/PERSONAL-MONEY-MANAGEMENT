
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:p_m_m/db/category/category_db.dart';
import 'package:p_m_m/db/transaction/transaction_db.dart';
import 'package:p_m_m/models/category/category_model.dart';
import 'package:p_m_m/models/transaction/transaction_model.dart';


class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUI();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget?_) {
        return ListView.separated(
      padding: const EdgeInsets.all(13),
      //!Values
      itemBuilder: (BuildContext ctx, int index) {
        final _value = newList[index];
          return  Slidable(
            key: Key(_value.id!),
            startActionPane:  ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (ctx){
                    TransactionDB.instance.deleteTransaction(_value.id!);
                  },
                  icon: Icons.delete,
                  label: 'Delete',
                  backgroundColor: Colors.red,
                  //foregroundColor: Colors.red[400],
                ),
              ],
            ),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  child: Text(
                    parseDate(_value.date),
                    textAlign: TextAlign.center,
                  ),
                  //! to give color depends on income or category
                  backgroundColor: _value.type == CategoryType.income 
                    ? Colors.green 
                    : Colors.red,
                ),
                title: Text('₹${_value.amount}'),
                subtitle: Text(_value.category.name), //Category Model
              ),
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
   //! UI change for date
    String parseDate(DateTime date) {
      final _date = DateFormat.MMMd().format(date);
      //! Split the Date i want date in this ways 26 Dec
      final _splitDate = _date.split(' ');
      return '${_splitDate.last} \n ${_splitDate.first}';
      //return '${date.day}\n${date.month}';
    }
}