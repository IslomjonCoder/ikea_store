class ProductModel {
  String id;
  String name;
  String imageUrl;
  String description;
  double price;
  int count;
  String categoryId;

  ProductModel({
    this.id = '',
    required this.name,
    this.imageUrl = '',
    required this.description,
    required this.price,
    this.count = 100,
    required this.categoryId,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    double? price,
    int? count,
    String? categoryId,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
        price: price ?? this.price,
        count: count ?? this.count,
        categoryId: categoryId ?? this.categoryId,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        description: json["description"] ?? '',
        price: json["price"] ?? '',
        count: json["count"] ?? '',
        categoryId: json["categoryId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
        "price": price,
        "count": count,
        "categoryId": categoryId,
      };
}