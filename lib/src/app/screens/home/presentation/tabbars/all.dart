import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';

import 'productmodel.dart';

class All extends StatelessWidget {
  String category;
  String type;
  All({super.key, required this.category, required this.type});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>?>(
        future: GetProductAPI.getProductCategory(category, type),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>?> snapshot) {
          if (snapshot.hasData) {
            // If the future is complete and has data, display the product data
            final List<ProductModel> products = snapshot.data!;
            if (products.isEmpty) {
              return Center(child: Text("No product found !", style: AppStyles.text18PxMedium));
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final ProductModel product = products[index];
                return everyProductWidgetProduct(context, product);
              },
            );
          } else if (snapshot.hasError) {
            // If the future has an error, display the error message
            return Text('${snapshot.error}');
          } else {
            return const Text("");
          }
        });
  }
}
