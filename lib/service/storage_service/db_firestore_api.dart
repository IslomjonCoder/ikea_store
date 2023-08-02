import 'dart:io';

import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/models/result_model.dart';

abstract class DbApi {
  // --------------------- Category -------------------------------------
  Future<Result> addCategory(CategoryModel category, File imageFile);

  Future<Result> updateCategory(CategoryModel category, File imageFile);

  Future<Result> deleteCategory(CategoryModel category);

  Stream<Result<List<CategoryModel>>> getCategoryList();

  Future<Result<List<CategoryModel>>> getCategoriesListSingle();

  // --------------------- Product -------------------------------------
  // Future<Result<ProductModel>> getProductById(ProductModel product);

  Stream<Result<List<ProductModel>>> getProductsByCategory(CategoryModel category);

  Future<Result> addProduct(ProductModel product, File imageFile);

  Future<Result> updateProduct(ProductModel product);

  Future<Result> deleteProduct(ProductModel product);

  Stream<Result<List<ProductModel>>> getProductList();
}
