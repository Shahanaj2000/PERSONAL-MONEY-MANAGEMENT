import 'package:flutter/material.dart';
import 'package:p_m_m/db/category/category_db.dart';
import 'package:p_m_m/models/category/category_model.dart';


class ScreenAddTransaction extends StatefulWidget {

  static const routeName = 'add-transactions';

  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCatogoryType;
  CategoryModel? _selectedCategoryModel;
  //! Data for Transaction

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              //if (_selectedDate == null)
              TextButton.icon(
                onPressed: () async{
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label:  Text( _selectedDate == null ?'Select Data' : _selectedDate!.toString()),
              ), //else
               // Text(_selectedDate.toString()),
                
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

              const SizedBox(height: 10,),
              DropdownButton(
                hint: const Text("Select Category"),
                items: CategoryDB().expenseCategoryListListner.value.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),

                onChanged: (selectedValue) {
                  print(selectedValue);
                },
              ),
              const SizedBox(height: 10,),
              //! Submit Button

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Submit'),
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