import 'package:models/categories_models.dart';
import 'package:services/data_models/dbCategories.dart';
import 'package:services/database.dart';


class CategoriesRepository {

  Future<void> addCategory(CategoriesModel category) async {
    await DBProvider.db.addCategory(DBCategories(
      id: category.id,
      indexCategory: category.indexCategory,
      title: category.title,
      time: category.time,
      color: category.color,
      icon: category.icon,
      type: category.type,
      min: category.min,
      max: category.max
    ));
  }

  Future<List<CategoriesModel>> getAllCategories() async {
    final list = await DBProvider.db.getAllCategories();
    return list.map((e) => CategoriesModel(
        id: e.id,
        indexCategory: e.indexCategory,
        title: e.title,
        time: e.time,
        color: e.color,
        icon: e.icon,
        type: e.type,
        min: e.min,
        max: e.max
    )).toList();
  }

  Future editCategory(CategoriesModel categories) async {
    final result = await DBProvider.db.editCategory(DBCategories(
        id: categories.id,
        indexCategory: categories.indexCategory,
        title: categories.title,
        time: categories.time,
        color: categories.color,
        icon: categories.icon,
        type: categories.type,
        min: categories.min,
        max: categories.max)
    );
    return result;
  }

  Future<void> deleteCategoryId(int id) async {
    await DBProvider.db.deleteCategory(id);
  }
}