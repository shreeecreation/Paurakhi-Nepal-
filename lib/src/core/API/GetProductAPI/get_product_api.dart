import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:http/http.dart' as http;

class GetProductAPI {
  static Future<http.Response?> getProduct(model) async {
    final requestModel = model;

    final String url =
        "${Environment.apiUrl}/product/get-product?id=${model.id}&type=${model.type}&page=${model.page}&name=${model.name}&category=${model.id}";
    return null;
  }
}
