import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/database_model/category_model/category_model.dart';

const CATEGORY_DB_NAME = "category-database";

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> delect(String categoryId);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb.internal();
  static CategoryDb instance = CategoryDb.internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenceList = ValueNotifier([]);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return CategoryDB.values.toList();
  }

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    CategoryDB.put(value.id,value);
    refreshUi();
  }

  Future<void> refreshUi() async {
    final allcategories = await getCategories();
    incomeList.value.clear();
    expenceList.value.clear();
    await Future.forEach(allcategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeList.value.add(category);
      } else {
        expenceList.value.add(category);
      }
    });
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incomeList.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expenceList.notifyListeners();
  }

  @override
  Future<void> delect(String categoryId) async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await CategoryDB.delete(categoryId);
    refreshUi();
  }
}
