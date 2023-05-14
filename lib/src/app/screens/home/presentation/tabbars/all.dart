import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';

import 'productmodel.dart';

class All extends StatelessWidget {
  String category;
  All({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>?>(
        future: GetProductAPI.getProductCategory(category),
        builder: (BuildContext context, AsyncSnapshot<List<ProductModel>?> snapshot) {
          if (snapshot.hasData) {
            // If the future is complete and has data, display the product data
            final List<ProductModel> products = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final ProductModel product = products[index];
                return everyProductWidget(context, product.images, product.tags, product.description);
              },
            );
          } else if (snapshot.hasError) {
            // If the future has an error, display the error message
            return Text('${snapshot.error}');
          } else {
            // If the future is not complete yet, display a loading indicator
            return const Center(child: LinearProgressIndicator(color: AppColors.primary));
          }
        });
  }
}
