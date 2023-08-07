import 'dart:io';

import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/models/result_model.dart';

abstract class DbApi {
  // --------------------- Category -------------------------------------
  Future<Result> addCategory(CategoryModel category, File imageFile);

  Future<Result> updateCategory(CategoryModel category, File imageFile);

  Future<Result> deleteCategory(CategoryModel category);

  Stream<List<CategoryModel>> getCategoryList();

  // --------------------- Product -------------------------------------

  Future<Result> addProduct(ProductModel product, File imageFile);

  Future<Result> updateProduct(ProductModel product, File imageFile);

  Future<Result> deleteProduct(ProductModel product);

  Stream<List<ProductModel>> getProductList();

  // --------------------- Cart -------------------------------------

  Future<Result> addToCard({required String productID, required String userID, required int count});

  // Stream<List<CartModel>> getCartProducts({required String userID});
}
