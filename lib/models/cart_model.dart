import 'package:ikea_store/models/product_model.dart';

class CartModel {
  // String userID;
  ProductModel product;
  int count;

  CartModel({
    // required this.userID,
    required this.product,
    required this.count,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        // userID: json['userID'],
        product: json['product'],
        count: json['count'],
      );
}
