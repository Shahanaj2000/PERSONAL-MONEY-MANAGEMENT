import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:p_m_m/models/category/category_model.dart';


//DB name for category

const CATEGORY_DB_NAME = "category-database";
abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategoreies();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunctions {
  //! create sigleTon cons
  CategoryDB._internals();
  static CategoryDB instance = CategoryDB._internals();


  //!Factoroy Cons
  factory CategoryDB() {
    return instance; 
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListner = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListner = ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async{
    // TODO: implement insertCategory
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.add(value);
    refreshUI();
  }
  
  @override
  Future<List<CategoryModel>> getCategoreies() async {
    // TODO: implement getCategoreies
   final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
   return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
  final _allCAtegories = await getCategoreies();
  incomeCategoryListListner.value.clear();
  expenseCategoryListListner.value.clear(); 
  await Future.forEach(_allCAtegories, (CategoryModel category) {
    if (category.type == CategoryType.income) {
      incomeCategoryListListner.value.add(category);
    } else {
      expenseCategoryListListner.value.add(category);
    }
  });
  incomeCategoryListListner.notifyListeners();
  expenseCategoryListListner.notifyListeners();
  }

}