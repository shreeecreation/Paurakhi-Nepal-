import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/app/screens/search/search_dialog.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';
import 'package:paurakhi/src/core/utils/loading_indicator.dart';

import 'domain/filter_saver.dart';
import 'domain/search_value.dart';

class SearchWidget extends StatelessWidget {
  String name;
  SearchWidget({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    String type;
    var category = Filter.filter.join(',');
    Filter.type == 0 ? type = "request" : type = "sell";
    return WillPopScope(
      onWillPop: () async {
        SearchValue.searchValue = "";
        return false;
      },
      child: FutureBuilder<ServerResponseProduct?>(
          future: SearchAPI.getSearchedProduct(category, name, type),
          builder: (BuildContext context, AsyncSnapshot<ServerResponseProduct?> snapshot) {
            if (snapshot.hasData) {
              // If the future is complete and has data, display the product data
              final ServerResponseProduct products = snapshot.data!;
              if (products.data.isEmpty) {
                return SizedBox(height: 200, child: Center(child: Text("No product found !", style: AppStyles.text18PxMedium)));
              }
              return Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Search results for "${SearchValue.searchValue == "" ? "ALL" : SearchValue.searchValue}"',
                            style: AppStyles.text16PxMedium),
                        const SizedBox(width: 50),
                        ElevatedButton(
                            onPressed: () {
                              showOptionsDialog(context);
                            },
                            style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.green),
                            child: const Row(children: [Text("Filter"), Icon(Icons.arrow_drop_down_rounded)])),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ProductModel datum = products.data[index];
                      return everyProductWidgetProduct(context, datum);
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              // If the future has an error, display the error message
              return Text('${snapshot.error}');
            } else {
              return loadingIndicator(context);
            }
          }),
    );
  }
}
