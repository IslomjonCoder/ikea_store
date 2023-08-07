class CategoryModel {
  String id;
  String name;
  String imageUrl;

  CategoryModel({
    required this.name,
    this.id = '',
    this.imageUrl = '',
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
      };
}
