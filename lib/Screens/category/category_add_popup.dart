import 'package:flutter/material.dart';
import 'package:p_m_m/db/category/category_db.dart';
import 'package:p_m_m/models/category/category_model.dart';

//! To change the UI for (Radio Button) to set default income category 

ValueNotifier<CategoryType> selectedCategoyNotifier = ValueNotifier(CategoryType.income);



Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add Category'),
        children: [
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: TextFormField(
              controller: _nameEditingController,
              decoration: const InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder()
              ),
             ),
           ),

            Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: const[
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
            
          ),

           Padding(
             padding: const EdgeInsets.all(20.0),
             child: ElevatedButton(
              onPressed: () {
                final _name = _nameEditingController.text;
                if (_name.isEmpty) {
                  return;
                }

                final _type = selectedCategoyNotifier.value;

                final _categoey =
                    CategoryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _name,
                  type: _type,
                );

                CategoryDB().insertCategory(_categoey);
                Navigator.of(ctx).pop();
              },
              child: const Text('Add'),
          ),
           ),
        ],
      );
    },
  );
}

//! Crating the radio button 
class RadioButton extends StatelessWidget {
  //
  final String  title;
  final CategoryType type;

  const RadioButton({
    super.key,
    required this.title,
    required this.type,
  });

 
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoyNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget?_) {
            return Radio<CategoryType>(
          value: type,
          groupValue: newCategory ,
          onChanged: (value) {
            if (value == null) {
              return; 
            }
            selectedCategoyNotifier.value =  value;
            selectedCategoyNotifier.notifyListeners();
          },
        ); 
          },
        ),
        Text(title),
      ],
    );
  }
}