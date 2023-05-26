class FinanceHistoryModel {
  final List<Datum> data;

  FinanceHistoryModel({
    required this.data,
  });

  factory FinanceHistoryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] as List<dynamic>;
    final List<Datum> items = dataList.map((item) => Datum.fromJson(item as Map<String, dynamic>)).toList();

    return FinanceHistoryModel(data: items);
  }
}

class Datum {
  final int id;
  final String createdAt;
  final String purpose;
  final int value;
  final String status;

  Datum({required this.id, required this.createdAt, required this.status, required this.purpose, required this.value});

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'] as int,
      createdAt: json['createdAt'],
      purpose: json['purpose'] as String,
      value: json['value'] as int,
      status: json['status'] as String,
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
