class NotificationModel {
  final int id;
  final DateTime createdAt;
  final String message;
  final String type;
  final bool seen;

  NotificationModel({
    required this.id,
    required this.createdAt,
    required this.message,
    required this.type,
    required this.seen,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      seen: json['seen'] ?? false,
    );
  }
}
