import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';

class FinanceSearchResult extends StatelessWidget {
  final String title;
  const FinanceSearchResult({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogModelNewsFinanceModel>?>(
        future: SearchAPI.getSearchedFinance(title),
        builder: (BuildContext context,
            AsyncSnapshot<List<BlogModelNewsFinanceModel>?> snapshot) {
          if (snapshot.hasData) {
            // If the future is complete and has data, display the product data
            final List<BlogModelNewsFinanceModel> products = snapshot.data!;
            if (products.isEmpty) {
              return SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.info,
                        size: 100, color: Color.fromARGB(87, 76, 175, 79)),
                    const SizedBox(height: 10),
                    Text(
                      "No Blog found on title $title !",
                      style: AppStyles.text20PxSemiBold,
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final BlogModelNewsFinanceModel product = products[index];
                return GestureDetector(
                    onTap: () {
                      HomeRoutes.singlePageScreenFinance(product);
                    },
                    child: everyProductWidgetBlog(context, product));
                // return Center(child: Text("No Finances found on title '$title'"));
              },
            );
          } else if (snapshot.hasError) {
            return SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.info,
                      size: 100, color: Color.fromARGB(87, 76, 175, 79)),
                  const SizedBox(height: 10),
                  Text(
                    "No Blog found on title $title !",
                    style: AppStyles.text20PxSemiBold,
                  ),
                ],
              ),
            );
            // If the future has an error, display the error message
          } else {
            return const Center(child: Text(""));
          }
        });
  }
}
