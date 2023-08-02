import 'package:flutter/foundation.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/service/storage_service/db_firestore.dart';

class ProductsProvider extends ChangeNotifier {
  final DbFirestoreService _dbFirestoreService = DbFirestoreService();

  ProductsProvider() {
    listenToProductsStream();
  }

  Stream<List<ProductModel>>? _productsStream;

  Stream<List<ProductModel>>? get productsStream => _productsStream;

  Stream<List<CategoryModel>>? _categoriesStream;

  Stream<List<CategoryModel>>? get categoriesStream => _categoriesStream;

  void listenToProductsStream() {
    _productsStream = _dbFirestoreService
        .getProductList()
        .map((result) => (result.isSuccess) ? result.data! : []);
    _categoriesStream = _dbFirestoreService
        .getCategoryList()
        .map((result) => (result.isSuccess) ? result.data! : []);
    notifyListeners();
  }

  Future<void> deleteCategory(CategoryModel category) async {
    await _dbFirestoreService.deleteCategory(category);
  }

  Future<void> deleteProduct(ProductModel product) async {
    await _dbFirestoreService.deleteProduct(product);
  }
}
