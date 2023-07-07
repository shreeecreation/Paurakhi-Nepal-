class DropdownModel {
  final List<CategoryModel> data;

  DropdownModel({required this.data});

  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataList = json['data'] as List<dynamic>;
    final List<CategoryModel> items = dataList.map((item) => CategoryModel.fromJson(item as Map<String, dynamic>)).toList();

    return DropdownModel(data: items);
  }
}

class CategoryModel {
  final int id;
  final String value;
  final String unit;

  CategoryModel({required this.id, required this.value, required this.unit});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final int id = json['id'] as int;
    final String value = json['name'] as String;
    final String unit = json['unit'] as String;
    return CategoryModel(id: id, value: value, unit: unit);
  }
}
