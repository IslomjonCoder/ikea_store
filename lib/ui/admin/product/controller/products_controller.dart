import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/service/storage_service/db_firestore.dart';
import 'package:ikea_store/utils/ui_utils/loadings.dart';

class ProductsState {
  static List<ProductModel> products = [];
  static String productName = '';
  static String description = '';
  static double price = 0;
  static String categoryID = '';
  static List<CategoryModel> categories = [];
  static File? imageFile;
}

class AdminProductsController extends ChangeNotifier {
  final DbFirestoreService _dbFirestoreService = DbFirestoreService();
  ProductsState state = ProductsState();

  AdminProductsController() {
    listenToProductsStream();
  }

  List<CategoryModel> get getCategories => ProductsState.categories;

  late Stream<List<ProductModel>> productsStream;

  void listenToProductsStream() async {
    productsStream = _dbFirestoreService
        .getProductList()
        .map((result) => (result.isSuccess) ? result.data! : []);
    categories = (await _dbFirestoreService.getCategoriesListSingle()).data;
    notifyListeners();
  }

  // Getter for products
  List<ProductModel> get products => ProductsState.products;

  // Setter for products
  set products(List<ProductModel> newProducts) {
    ProductsState.products = newProducts;
  }

  // Getter and Setter for productName
  String get productName => ProductsState.productName;

  set productName(String newProductName) {
    ProductsState.productName = newProductName;
  }

  // Getter and Setter for description
  String get description => ProductsState.description;

  set description(String newDescription) {
    ProductsState.description = newDescription;
  }

  // Getter and Setter for price
  double get price => ProductsState.price;

  set price(double newPrice) {
    ProductsState.price = newPrice;
  }

  File? get imageFile => ProductsState.imageFile;

  set imageFile(File? newImage) {
    ProductsState.imageFile = newImage;
    notifyListeners();
  }

  // Getter and Setter for categoryID
  String get categoryID => ProductsState.categoryID;

  set categoryID(String newCategoryID) {
    ProductsState.categoryID = newCategoryID;
  }

  // Getter and Setter for categories
  List<CategoryModel> get categories => ProductsState.categories;

  set categories(List<CategoryModel> newCategories) {
    ProductsState.categories = newCategories;
  }

  addProduct(BuildContext context) async {
    print([productName, categoryID, description, price]);
    showLoading(context);
    await _dbFirestoreService.addProduct(
        ProductModel(
            name: productName, description: description, price: price, categoryId: categoryID),
        imageFile);
    hideLoading(context);
    reset();
  }

  void reset() {
    products = [];
    productName = '';
    description = '';
    price = 0;
    categoryID = '';
    categories = [];
    imageFile = null;
  }
}
