class RequestProductModel {
  int id = 0;
  String type = "";
  int page = 0;
  String name = "";

  RequestProductModel(this.id, this.type, this.page, this.name);

  Map<String, dynamic> toMap() {
    return {'name': name, 'type': type, 'page': page, 'id': id};
  }
}
