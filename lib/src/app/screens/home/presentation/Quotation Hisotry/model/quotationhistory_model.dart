class QuotationHistoryModel {
  final List<Datum> data;

  QuotationHistoryModel({
    required this.data,
  });

  factory QuotationHistoryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] as List<dynamic>;
    final List<Datum> items = dataList.map((item) => Datum.fromJson(item as Map<String, dynamic>)).toList();

    return QuotationHistoryModel(data: items);
  }
}

class Datum {
  final int id;
  final String createdAt;
  final String queryId;
  final int price;
  final String status;
  final Product product;

  Datum({
    required this.id,
    required this.createdAt,
    required this.queryId,
    required this.price,
    required this.status,
    required this.product,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'] as int,
      createdAt: json['createdAt'],
      queryId: json['queryId'] as String,
      price: json['price'] as int,
      status: json['status'] as String,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }
}

class Product {
  final int id;
  final String name;

  Product({
    required this.id,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
