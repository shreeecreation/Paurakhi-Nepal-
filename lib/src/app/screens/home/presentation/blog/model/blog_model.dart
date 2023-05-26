import 'package:intl/intl.dart';

class ServerResponseBlogandNews {
  final List<BlogModelandNewsModel> data;

  ServerResponseBlogandNews({
    required this.data,
  });

  factory ServerResponseBlogandNews.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] as List<dynamic>;
    final List<BlogModelandNewsModel> items = dataList.map((item) => BlogModelandNewsModel.fromJson(item as Map<String, dynamic>)).toList();

    return ServerResponseBlogandNews(data: items);
  }
}

class BlogModelandNewsModel {
  int id;
  String createdAt;
  String title;
  String body;
  String blogImage = "";
  String type;
  bool trash;
  String updatedDate;
  String author;

  BlogModelandNewsModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.blogImage,
    required this.type,
    required this.trash,
    required this.updatedDate,
    required this.author,
  });

  factory BlogModelandNewsModel.fromJson(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.parse(json['createdAt'] as String);

    // Create a DateFormat object to format the DateTime
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    // Format the DateTime into a readable string
    String formattedTime = dateFormat.format(dateTime);

    final int id = json['id'] as int;
    final createdAt = formattedTime;
    final String title = json['title'] as String;
    final String body = json['body'] as String;
    final String blogImage = json['blogImage '] as String;
    final String type = json['type'] as String;
    final bool trash = json['trash'] as bool;
    final updatedDate = json['updatedDate'] as String;
    final author = json['author'] as String;
    return BlogModelandNewsModel(
        id: id,
        createdAt: createdAt,
        title: title,
        body: body,
        blogImage: blogImage,
        type: type,
        trash: trash,
        updatedDate: updatedDate,
        author: author);
  }
}
