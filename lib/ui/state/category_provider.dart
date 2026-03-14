import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/category_repository.dart';


class CategoryProvider extends ChangeNotifier {

  final CategoryRepository repository = CategoryRepository();

  List<CategoryModel> categories = [];

  Future loadCategories() async {
    categories = await repository.getAll();
    notifyListeners();
  }

  Future addCategory(CategoryModel category) async {
    await repository.insert(category);
    await loadCategories();
  }

  Future updateCategory(CategoryModel category) async {
    await repository.update(category);
    await loadCategories();
  }

  Future deleteCategory(int id) async {
    await repository.delete(id);
    await loadCategories();
  }

}