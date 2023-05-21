import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/core/API/Search/search_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/utils/evey_product_widget.dart';

class BlogSearchResult extends StatelessWidget {
  final String title;
  const   BlogSearchResult({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogModel>?>(
        future: SearchAPI.getSearchedBlog(title),
        builder: (BuildContext context, AsyncSnapshot<List<BlogModel>?> snapshot) {
          if (snapshot.hasData) {
            // If the future is complete and has data, display the product data
            final List<BlogModel> products = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final BlogModel product = products[index];
                return everyProductWidgetBlog(context, product);
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
