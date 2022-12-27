import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(13),
      itemBuilder: (BuildContext ctx, int index) {
        return Card(
          color: Colors.grey[100],
          elevation: 0,
          child: ListTile(
            title: Text('Income Category $index'),
            trailing: IconButton(
              onPressed: () {
        
            },
            icon: const Icon(Icons.delete, color: Colors.red,)
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