class CategoryModel {
  String id;
  String name;
  String imageUrl;
  String description;

  CategoryModel({
    this.id = '',
    required this.name,
    this.imageUrl = '',
    required this.description,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
  }) =>
      CategoryModel(
        id: id ?? this.id ?? "",
        name: name ?? this.name ?? "",
        imageUrl: imageUrl ?? this.imageUrl ?? "",
        description: description ?? this.description ?? "",
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
      };
}
