//! Create DB name
import 'package:hive_flutter/adapters.dart';
import 'package:p_m_m/models/category/category_model.dart';
import 'package:p_m_m/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

//! Abstract class for creating the method
abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel transaction); //TimeConsuming Task thats why we did it has future
}


class TransactionDB implements TransactionDbFunction {

  //!Singleto Cons (To Use this obj from evey where)
  TransactionDB._internals(); //? We create the named Cons
  
  static TransactionDB instance = TransactionDB._internals(); //? We assign that named const here

  factory TransactionDB() {
    return instance;
  }



  @override
  Future<void> addTransaction(TransactionModel transaction) async{
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(transaction.id, transaction);
    
  }

}