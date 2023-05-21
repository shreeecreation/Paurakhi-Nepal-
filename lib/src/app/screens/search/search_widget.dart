import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';

import 'domain/filter_saver.dart';
import 'model/search_model.dart';

class SearchWidget extends StatelessWidget {
  String name;
  SearchWidget({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    String type;
    var category = Filter.filter.join(',');
    Filter.type == 0 ? type = "request" : type = "sell";
    return FutureBuilder<List<SearchModel>?>(
        future: SearchAPI.getSearchedProduct(category, name, type),
        builder: (BuildContext context, AsyncSnapshot<List<SearchModel>?> snapshot) {
          if (snapshot.hasData) {
            // If the future is complete and has data, display the product data
            final List<SearchModel> products = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final SearchModel product = products[index];
                return everyProductWidgetSearch(context, product);
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
