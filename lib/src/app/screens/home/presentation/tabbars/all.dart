import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/GetProductAPI/get_product_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';
import 'package:paurakhi/src/core/utils/loading_indicator.dart';

import 'productmodel.dart';

class All extends StatelessWidget {
  String category;
  String type;
  All({super.key, required this.category, required this.type});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ServerResponseProduct?>(
        future: GetProductAPI.getProductCategory(category, type),
        builder: (BuildContext context, AsyncSnapshot<ServerResponseProduct?> snapshot) {
          if (snapshot.hasData) {
            // If the future is complete and has data, display the product data
            final ServerResponseProduct products = snapshot.data!;
            if (products.data.isEmpty) {
              return Center(child: Text("No product found !", style: AppStyles.text18PxMedium));
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.data.length,
              itemBuilder: (BuildContext context, int index) {
                final ProductModel datum = products.data[index];
                return everyProductWidgetProduct(context, datum);
              },
            );
          } else if (snapshot.hasError) {
            // If the future has an error, display the error message
            return Text('${snapshot.error}');
          } else {
            return loadingIndicator(context);
          }
        });
  }
}
