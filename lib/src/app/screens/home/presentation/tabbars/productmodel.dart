class ProductModel {
  final List<dynamic> images;
  final List<String> tags;
  final int id;
  final String createdAt;
  final String name;
  final String description;
  final int quantity;
  final CategoryModel category;

  ProductModel({
    required this.images,
    required this.tags,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> images = json['images'] as List<dynamic>;
    final List<String> tags = List<String>.from(json['tags'] as List<dynamic>);
    final int id = json['id'] as int;
    final String createdAt = json['createdAt'] as String;
    final String name = json['name'] as String;
    final String description = json['description'] as String;
    final int quantity = json['quantity'] as int;
    final CategoryModel category = CategoryModel.fromJson(json['category'] as Map<String, dynamic>);
    return ProductModel(
      images: images,
      tags: tags,
      id: id,
      createdAt: createdAt,
      name: name,
      description: description,
      quantity: quantity,
      category: category,
    );
  }
}

class CategoryModel {
  final String name;

  CategoryModel({required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final String name = json['name'] as String;
    return CategoryModel(name: name);
  }
}
