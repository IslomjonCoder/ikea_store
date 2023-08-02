import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/result_model.dart';
import 'package:ikea_store/service/storage_service/db_firestore.dart';
import 'package:ikea_store/utils/ui_utils/loadings.dart';

class CategoryState {
  static File? imageFile;
  static String name = '';
  static String description = '';
  static String id = '';
}

class AdminCategoryController extends ChangeNotifier {
  final DbFirestoreService _dbFirestoreService = DbFirestoreService();

  // ProductsState state = ProductsState();
  set setImageFile(File? file) {
    CategoryState.imageFile = file;
    notifyListeners();
  }

  set setName(String name) {
    CategoryState.name = name;
    notifyListeners();
  }

  set setID(String id) {
    CategoryState.id = id;
    notifyListeners();
  }

  set setDescription(String desc) {
    CategoryState.description = desc;
    notifyListeners();
  }

  File? get imageFile => CategoryState.imageFile;

  String get name => CategoryState.name;

  String get desc => CategoryState.description;
  String get id => CategoryState.id;

  AdminProductsController() {
    categoryStream = _dbFirestoreService.getCategoryList();
  }

  Stream<Result<List<CategoryModel>>>? categoryStream;
  reset() {
    setName = '';
    setDescription = '';
    setImageFile = null;
  }

  addCategory(BuildContext context) async {
    showLoading(context);
    await _dbFirestoreService.addCategory(CategoryModel(name: name, description: desc), imageFile!);
    reset();
    notifyListeners();
    Navigator.pop(context);
    hideLoading(context);
  }

  updateCategory(BuildContext context, CategoryModel category) async {
    // print([name, desc]);
    showLoading(context);
    await _dbFirestoreService.updateCategory(
        category.copyWith(name: name, description: desc), imageFile);
    reset();
    notifyListeners();
    hideLoading(context);
    Navigator.pop(context);
  }

  deleteCategory(context, CategoryModel category) {
    showLoading(context);
    _dbFirestoreService.deleteCategory(category);
    hideLoading(context);
  }
}
