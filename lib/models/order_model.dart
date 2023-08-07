import 'package:ikea_store/models/cart_model.dart';
import 'package:ikea_store/models/product_model.dart';

class OrderModel {
  String id;
  String userID;
  List<CartModel> products;
  double totalAmount;
  int timestamp;

  OrderModel({
    required this.id,
    required this.userID,
    required this.timestamp,
    required this.totalAmount,
    required this.products,
  });
}
