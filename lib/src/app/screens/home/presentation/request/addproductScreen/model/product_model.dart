import 'dart:io';

class SellProductModel {
  String name = "";
  String type = "";
  String description = "";
  List<String> tags = [];
  String category = "";
  List<File> image = [];
  int quantity = 0;
  int price = 0;

  SellProductModel(this.name, this.type, this.description, this.tags, this.category, this.image, this.quantity, this.price);

  Map<String, dynamic> toMap() {
    return {'name': name, 'type': type, "description": description, "tags": tags, "image": image, "quantity": quantity, "price": price};
  }
}
