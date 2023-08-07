import 'package:ikea_store/models/review_model.dart';

class ProductModel {
  String id;
  String name;
  String imageUrl;
  String description;
  double price;
  num rating;
  int count;
  String categoryId;
  List<ReviewModel>? comments;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    this.id = '',
    this.rating = 5,
    this.imageUrl = '',
    this.count = 100,
    this.comments,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    double? price,
    int? count,
    String? categoryId,
    List<ReviewModel>? comments,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
        price: price ?? this.price,
        count: count ?? this.count,
        categoryId: categoryId ?? this.categoryId,
        comments: comments ?? this.comments,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        description: json["description"] ?? '',
        price: (json["price"]) ?? '',
        count: json["count"] ?? '',
        rating: (json['rating']) ?? 5,
        categoryId: json["categoryId"] ?? '',
        comments:
            (json['review'] == null) ? [] : List<ReviewModel>.from(json["review"].map((x) => ReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
        "price": price,
        "count": count,
        "categoryId": categoryId,
        'review': comments?.map((review) => review.toJson()).toList(),
      };

  addComment(ReviewModel comment) {
    print(comment.timestamp);
    comments?.add(comment);
  }
}
