class ProductHistoryModel {
  List<Product> data;

  ProductHistoryModel({required this.data});

  factory ProductHistoryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] as List<dynamic>;
    final List<Product> items = dataList
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();

    return ProductHistoryModel(data: items);
  }
}

class Product {
  List<dynamic> images;
  List<String> tags;
  int id;
  DateTime createdAt;
  String name;
  String type;
  String description;
  double price;
  int quantity;
  String status;
  bool trash;
  Category category;

  Product({
    required this.images,
    required this.tags,
    required this.id,
    required this.createdAt,
    required this.name,
    required this.type,
    required this.description,
    required this.price,
    required this.quantity,
    required this.status,
    required this.trash,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      images: json['images'],
      tags: json['tags'].cast<String>(),
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      name: json['name'],
      type: json['type'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      status: json['status'],
      trash: json['trash'],
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  int id;
  DateTime createdAt;
  String name;
  String unit;
  bool trash;

  Category({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.unit,
    required this.trash,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      name: json['name'],
      unit: json['unit'],
      trash: json['trash'],
    );
  }
}
