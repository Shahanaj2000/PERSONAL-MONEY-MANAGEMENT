//! Create DB name
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:p_m_m/models/category/category_model.dart';
import 'package:p_m_m/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

//! Abstract class for creating the method
abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel transaction); //TimeConsuming Task thats why we did it has future
  Future<List<TransactionModel>> getAllTransaction();
}


class TransactionDB implements TransactionDbFunction {

  //!Singleto Cons (To Use this obj from evey where)
  TransactionDB._internals(); //? We create the named Cons
  
  static TransactionDB instance = TransactionDB._internals(); //? We assign that named const here

  factory TransactionDB() {
    return instance;
  }

  //! To Change the Transaction UI 
  ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel transaction) async{
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(transaction.id, transaction);
    
  }

  //refresh UI
  Future<void> refreshUI() async {
    final _list = await getAllTransaction();
    _list.sort((first, second) => second.date.compareTo(first.date)); 
    transactionListNotifier.value.clear();
    
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
    // if we want to display
  }
  
  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

}