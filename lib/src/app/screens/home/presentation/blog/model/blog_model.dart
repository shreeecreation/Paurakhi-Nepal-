class BlogModelandNewsModel {
  int id;
  String createdAt;
  String tittle;
  String body;
  String blogImage = "";
  String type;
  bool trash;
  String updatedDate;
  String author;

  BlogModelandNewsModel({
    required this.id,
    required this.createdAt,
    required this.tittle,
    required this.body,
    required this.blogImage,
    required this.type,
    required this.trash,
    required this.updatedDate,
    required this.author,
  });

  factory BlogModelandNewsModel.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] as int;
    final createdAt = json['createdAt'] as String;
    final String title = json['tittle'] as String;
    final String body = json['body'] as String;
    final String blogImage = json['blogImage '] as String;
    final String type = json['type'] as String;
    final bool trash = json['trash'] as bool;
    final updatedDate = json['updatedDate'] as String;
    final author = json['author'] as String;
    return BlogModelandNewsModel(
        id: id,
        createdAt: createdAt,
        tittle: title,
        body: body,
        blogImage: blogImage,
        type: type,
        trash: trash,
        updatedDate: updatedDate,
        author: author);
  }
}
