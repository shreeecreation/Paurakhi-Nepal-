class GrantHistoryModel {
  final List<Datums> data;

  GrantHistoryModel({
    required this.data,
  });

  factory GrantHistoryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] as List<dynamic>;
    final List<Datums> items = dataList.map((item) => Datums.fromJson(item as Map<String, dynamic>)).toList();

    return GrantHistoryModel(data: items);
  }
}

class Datums {
  final int id;
  final String createdAt;
  final String title;
  final String status;
  final String description;
  final int price;

  Datums({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.status,
    required this.description,
    required this.price,
  });

  factory Datums.fromJson(Map<String, dynamic> json) {
    return Datums(
        id: json['id'] as int,
        createdAt: json['createdAt'],
        price: json['price'] as int,
        description: json['description'] as String,
        title: json['title'] as String,
        status: json['status'] as String);
  }
}
