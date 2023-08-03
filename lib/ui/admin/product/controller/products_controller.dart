import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/service/storage_service/db_firestore.dart';
import 'package:ikea_store/utils/ui_utils/loadings.dart';
import 'package:uuid/uuid.dart';

class ProductsState {
  static List<ProductModel> products = [];
}

class ProductProvider extends ChangeNotifier {
  final DbFirestoreService _dbFirestoreService = DbFirestoreService();
  Uuid uuid = const Uuid();

  addProduct(BuildContext context, ProductModel product, File imageFile) async {
    product = product.copyWith(id: uuid.v4());
    LoaderDialog.showLoadingDialog(context);
    await _dbFirestoreService.addProduct(product, imageFile);
    LoaderDialog.hideLoadingDialog(context);
    Navigator.pop(context);
  }

  addCategory(BuildContext context, CategoryModel category, File imageFile) async {
    category = category.copyWith(id: uuid.v4());
    LoaderDialog.showLoadingDialog(context);
    await _dbFirestoreService.addCategory(category, imageFile);
    LoaderDialog.hideLoadingDialog(context);
    Navigator.pop(context);
  }

  deleteProduct(BuildContext context, ProductModel product) async {
    LoaderDialog.showLoadingDialog(context);
    await _dbFirestoreService.deleteProduct(product);
    LoaderDialog.hideLoadingDialog(context);
    Navigator.pop(context);
  }

  deleteCategory(BuildContext context, CategoryModel category) async {
    await _dbFirestoreService.deleteCategory(category);
  }

  updateProduct(BuildContext context, ProductModel product, File? imageFile) async {
    LoaderDialog.showLoadingDialog(context);
    await _dbFirestoreService.updateProduct(product, imageFile);
    LoaderDialog.hideLoadingDialog(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  updateCategory(BuildContext context, CategoryModel category, File? imageFile) async {
    LoaderDialog.showLoadingDialog(context);
    await _dbFirestoreService.updateCategory(category, imageFile);
    LoaderDialog.hideLoadingDialog(context);
    Navigator.pop(context);
    // Navigator.pop(context);
    // Navigator.popUntil(context, ModalRoute.withName(RouteNames.admin));
  }
}
