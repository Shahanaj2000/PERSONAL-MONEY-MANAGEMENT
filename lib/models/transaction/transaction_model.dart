import 'package:hive_flutter/hive_flutter.dart';
import 'package:p_m_m/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  final String puspose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;

  TransactionModel({
   required this.puspose,
   required this.amount,
   required this.date,
   required this.type,
   required this.category,
  }); 
}