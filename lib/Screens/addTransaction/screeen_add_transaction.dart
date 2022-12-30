import 'package:flutter/material.dart';
import 'package:p_m_m/db/category/category_db.dart';
import 'package:p_m_m/db/transaction/transaction_db.dart';
import 'package:p_m_m/models/category/category_model.dart';
import 'package:p_m_m/models/transaction/transaction_model.dart';


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

  String? _CategoryID; //To Display the selected categoory on that dropdown (selectedCategory)

  //!Controller for TextFeild
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _selectedCatogoryType = CategoryType.income; //default we set income
    super.initState();
  }
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
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Purpose',
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _amountTextEditingController,
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
                        groupValue: _selectedCatogoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCatogoryType = CategoryType.income;
                            _CategoryID = null;
                          });
                          
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
                        groupValue: _selectedCatogoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCatogoryType = CategoryType.expense;
                            _CategoryID =null;
                          });
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
                value: _CategoryID, //
                //! To display in Drowpdoown items if we select income it shows income categoreies else other
                items: (_selectedCatogoryType == CategoryType.income 
                    ? CategoryDB().incomeCategoryListListner
                    : CategoryDB().expenseCategoryListListner)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),

                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _CategoryID = selectedValue;
                  });
                },
              ),
              const SizedBox(height: 10,),
              //! Submit Button

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addTransaction();
                      
                    },
                    
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
  //! Submit Buttom Function
  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    //? Cheking if the value are there are not
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    /*if (_CategoryID == null) {
      return;
    }*/
    //! To check whether the typed amount is string or not / we want the amount in double
    final _parseAmount = double.tryParse(_amountText);

    if(_parseAmount == null) {
      return;
    }

    if (_selectedCategoryModel == null) {
      return;
    }

    //! Create Transaction Model
    final _model = TransactionModel (
      puspose: _purposeText,
      amount: _parseAmount,
      date: _selectedDate!,
      type: _selectedCatogoryType!,
      category: _selectedCategoryModel! ,
    );

    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refreshUI();
  }
}