import 'dart:io';

class RequestProductModel {
  String name = "";
  String type = "";
  String description = "";
  int category = 0;
  int quantity = 0;
  int price = 0;

  RequestProductModel(this.name, this.type, this.description,  this.category, this.quantity, this.price);

  Map<String, dynamic> toMap() {
    return {'name': name, 'type': type, "description": description,"category":category,  "quantity": quantity, "price": price};
  }
}
