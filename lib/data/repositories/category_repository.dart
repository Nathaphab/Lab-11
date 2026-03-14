import '../db/database_helper.dart';
import '../models/category_model.dart';

class CategoryRepository {

  Future<int> insert(CategoryModel category) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert("categories", category.toMap());
  }

  Future<List<CategoryModel>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query("categories");
    return result.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<int> update(CategoryModel category) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      "categories",
      category.toMap(),
      where: "id=?",
      whereArgs: [category.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;

    return await db.delete(
      "categories",
      where: "id=?",
      whereArgs: [id],
    );
  }
}