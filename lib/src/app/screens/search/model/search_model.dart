class SearchModel {
  final List<dynamic> images;
  final List<String> tags;
  final int id;
  final String createdAt;
  final String name;
  final String description;
  final int quantity;
  final CategoryModels category;

  SearchModel({
    required this.images,
    required this.tags,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> images = json['images'] as List<dynamic>;
    final List<String> tags = List<String>.from(json['tags'] as List<dynamic>);
    final int id = json['id'] as int;
    final String createdAt = json['createdAt'] as String;
    final String name = json['name'] as String;
    final String description = json['description'] as String;
    final int quantity = json['quantity'] as int;
    final CategoryModels category = CategoryModels.fromJson(json['category'] as Map<String, dynamic>);
    return SearchModel(
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

class CategoryModels {
  final String name;

  CategoryModels({required this.name});

  factory CategoryModels.fromJson(Map<String, dynamic> json) {
    final String name = json['name'] as String;
    return CategoryModels(name: name);
  }
}
