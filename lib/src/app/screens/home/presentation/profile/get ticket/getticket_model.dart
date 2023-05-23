class TicketHistoryModel {
  final List<Datums> data;

  TicketHistoryModel({
    required this.data,
  });

  factory TicketHistoryModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] as List<dynamic>;
    final List<Datums> items = dataList.map((item) => Datums.fromJson(item as Map<String, dynamic>)).toList();

    return TicketHistoryModel(data: items);
  }
}

class Datums {
  final int id;
  final String createdAt;
  final String tittle;
  final String status;
  final String reply;
  final String body;

  Datums({
    required this.id,
    required this.createdAt,
    required this.tittle,
    required this.status,
    required this.reply,
    required this.body,
  });

  factory Datums.fromJson(Map<String, dynamic> json) {
    return Datums(
        id: json['id'] as int,
        createdAt: json['createdAt'],
        reply: json['reply'] as String,
        body: json['body'] as String,
        tittle: json['tittle'] as String,
        status: json['status'] as String);
  }
}
