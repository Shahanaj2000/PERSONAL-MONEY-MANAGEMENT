
import 'package:flutter/material.dart';
import 'package:p_m_m/db/category/category_db.dart';
import 'package:p_m_m/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryListListner,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget?_) {
        return ListView.separated(
      itemBuilder: (BuildContext ctx, int index) {
        final category = newList[index];
        return Card(
          elevation: 0,
          color: Colors.grey[100],
          child: ListTile( 
            leading: Text(category.name),
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
      itemCount: newList.length,
    );
      },
    );
  }
}