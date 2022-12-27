import 'package:hive_flutter/adapters.dart';
import 'package:p_m_m/models/category/category_model.dart';


//DB name for category

const CATEGORY_DB_NAME = "category-database";
abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategoreies();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel value) async{
    // TODO: implement insertCategory
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.add(value);
  }
  
  @override
  Future<List<CategoryModel>> getCategoreies() async {
    // TODO: implement getCategoreies
   final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
   return _categoryDB.values.toList();
  }

}