import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext ctx, int index) {
        return Card(
          elevation: 0,
          color: Colors.grey[100],
          child: ListTile(
            leading: Text('Expense Category $index'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.red,),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext ctx, index) {
        return const SizedBox(height: 10,);
      },
      itemCount: 100,
    );
  }
}