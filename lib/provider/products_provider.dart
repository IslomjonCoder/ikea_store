import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ikea_store/models/cart_model.dart';
import 'package:ikea_store/models/category_model.dart';
import 'package:ikea_store/models/product_model.dart';
import 'package:ikea_store/models/review_model.dart';
import 'package:ikea_store/service/storage_service/db_firestore.dart';
import 'package:ikea_store/utils/ui_utils/loadings.dart';
import 'package:ikea_store/utils/uid.dart';

class ProductsProvider extends ChangeNotifier {
  final DbFirestoreService _dbFirestoreService = DbFirestoreService();
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  List<CategoryModel> _categories = [CategoryModel(name: 'Popular')];

  List<CategoryModel> get categories => _categories;

  List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  int selectedCategory = 0;

  set setCategory(int index) {
    selectedCategory = index;
    notifyListeners();
  }

  double totalPrice = 0;

  ProductsProvider() {
    _initialize();
  }

  _initialize() {
    _dbFirestoreService.getProductList().listen((snapshot) {
      _products = snapshot;
      notifyListeners();
    });
    _dbFirestoreService.getCategoryList().listen((event) {
      _categories.addAll(event);
      notifyListeners();
    });

    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((event) {
      List<CartModel> cartModels = [];
      event.data()?.forEach((productID, quantity) {
        ProductModel product = getProductById(productID);

        CartModel cartItem = CartModel(product: product, count: quantity);
        cartModels.add(cartItem);
      });
      cartModels.sort((a, b) => a.product.name.compareTo(b.product.name));
      _cartItems = cartModels;
      totalPrice = calculate();
      notifyListeners();
    });
  }

  getProductByCategory(int index) {
    return (index == 0)
        ? _products
        : _products.where((element) => element.categoryId == _categories[selectedCategory].id).toList();
  }

  addToCard({required context, required ProductModel product, required int count}) async {
    print([count, product.id]);
    //
    LoaderDialog.showLoadingDialog(context);
    await _dbFirestoreService.addToCard(
      productID: product.id,
      userID: FirebaseAuth.instance.currentUser!.uid,
      count: count,
    );
    LoaderDialog.hideLoadingDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product has been added to cart')));
  }

  updateCartItemCount(CartModel cartItem, int count) async {
    // print([FirebaseAuth.instance.currentUser!.uid, cartItem.product.id, count]);
    await _dbFirestoreService.updateCartItemCount(
      userID: FirebaseAuth.instance.currentUser!.uid,
      productID: cartItem.product.id,
      count: count,
    );
  }

  deleteCartItem(CartModel cartItem) async {
    await _dbFirestoreService.deleteCartItem(
      productId: cartItem.product.id,
      userID: FirebaseAuth.instance.currentUser!.uid,
    );
  }

  ProductModel getProductById(String productID) {
    return _products.where((element) => element.id == productID).first;
  }

  calculate() {
    double summa = 0;
    _cartItems.forEach((element) {
      summa += element.count * element.product.price;
    });
    return summa;
  }

  addReview({required context, required String message, required double value, required ProductModel product}) async {
    LoaderDialog.showLoadingDialog(context);

    ReviewModel review = ReviewModel(
      userID: FirebaseAuth.instance.currentUser!.uid,
      rating: value,
      comment: message,
      timestamp: currentDateTimeToTimestamp(),
    );
    await _dbFirestoreService.addReview(review, product);
    LoaderDialog.hideLoadingDialog(context);
  }

  int currentDateTimeToTimestamp() {
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch ~/ 1000;
    return timestamp;
  }

  String timestampToString(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate =
        "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
    return formattedDate;
  }
}
