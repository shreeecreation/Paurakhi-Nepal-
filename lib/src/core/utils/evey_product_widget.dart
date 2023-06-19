import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/app/screens/search/model/search_model.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'focuesnode.dart';

Widget everyProductWidgetSearch(BuildContext context, SearchModel product) {
  return Stack(children: [
    Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: const Card(elevation: 0.2, color: Color(0xFFF4FBF3))),
    Column(
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            unFocusNode(context);
            SearchModel models = SearchModel(
                images: product.images,
                description: product.description,
                name: product.name,
                tags: product.tags,
                category: product.category,
                quantity: product.quantity,
                id: product.id,
                createdAt: product.createdAt);

            HomeRoutes.singlePageScreen(models);
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              product.images.isEmpty
                  ? const SizedBox(height: 120, width: 126, child: Icon(Icons.question_mark))
                  :
                  //  Container(
                  //     height: 120,
                  //     width: 126,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20.0),
                  //         image: DecorationImage(image: NetworkImage("${Environment.apiUrl}/public/images/${image[0]}"), fit: BoxFit.cover)),
                  //     child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Align(alignment: Alignment.bottomRight, child: Container())),
                  //   ),
                  Container(
                      height: 120,
                      width: 126,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://thumbs.dreamstime.com/b/rice-cop-field-green-paddy-dhan-seed-plantation-chawalfield-agriculture-landscape-image-stock-photo-263603788.jpg"),
                              fit: BoxFit.cover)),
                      child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Align(alignment: Alignment.bottomRight, child: Container())),
                    ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: product.tags.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String tag = product.tags[index];
                            return Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color(0xFFD9D9D9)),
                                height: 20,
                                width: 60,
                                margin: const EdgeInsets.only(right: 10),
                                child: Center(child: Text(tag, style: AppStyles.text13Px)));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.name, style: AppStyles.text18PxBold)),
                  const SizedBox(height: 5),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.description, style: AppStyles.text12Px)),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ]);
}

Widget everyProductWidgetProduct(BuildContext context, ProductModel product) {
  return Stack(children: [
    Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: const Card(elevation: 0.2, color: Color(0xFFF4FBF3))),
    Column(
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            unFocusNode(context);
            ProductModel models = ProductModel(
                images: product.images,
                description: product.description,
                name: product.name,
                tags: product.tags,
                category: product.category,
                quantity: product.quantity,
                type: product.type,
                id: product.id,
                createdAt: product.createdAt);

            HomeRoutes.singlePageScreen(models);
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              product.images.isEmpty
                  ? const SizedBox(height: 120, width: 126, child: Icon(Icons.question_mark))
                  : Container(
                      height: 120,
                      width: 126,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          fadeInDuration: const Duration(milliseconds: 10),
                          imageUrl: "${Environment.apiUrl}/public/images/${product.images[0]}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                              height: 10,
                              width: 10,
                              child: LinearProgressIndicator(
                                color: Color.fromARGB(57, 222, 255, 223),
                                backgroundColor: Colors.white,
                              )),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 20,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: product.tags.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String tag = product.tags[index];
                            return Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color(0xFFD9D9D9)),
                                height: 20,
                                width: 60,
                                margin: const EdgeInsets.only(right: 10),
                                child: Center(child: Text(tag, style: AppStyles.text13Px)));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.name, style: AppStyles.text18PxBold)),
                  const SizedBox(height: 5),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(product.description.length > 50 ? '${product.description.substring(0, 50)}...' : product.description,
                          style: AppStyles.text12Px)),
                  const SizedBox(height: 15),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ]);
}

Widget everyProductWidgetBlog(BuildContext context, BlogModelNewsFinanceModel product) {
  return Stack(children: [
    Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: const Card(elevation: 0.2, color: Color(0xFFF4FBF3))),
    Column(
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            HomeRoutes.singlePageScreenBlog(product);
          },
          child: Row(
            children: [
              product.blogImage == null
                  ? const SizedBox(height: 120, width: 126, child: Icon(Icons.question_mark))
                  : Container(
                      height: 120,
                      width: 126,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: "${Environment.apiUrl}/public/images/${product.blogImage[0]}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                              height: 10,
                              width: 10,
                              child: LinearProgressIndicator(
                                color: Color.fromARGB(57, 222, 255, 223),
                                backgroundColor: Colors.white,
                              )),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.title, style: AppStyles.text18PxBold)),
                  const SizedBox(height: 5),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.createdAt, style: AppStyles.text12Px)),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ]);
}

Widget everyProductWidgetFinance(BuildContext context, BlogModelNewsFinanceModel product) {
  return Stack(children: [
    Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: const Card(elevation: 0.2, color: Color(0xFFF4FBF3))),
    Column(
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            HomeRoutes.singlePageScreenFinance(product);
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.title, style: AppStyles.text18PxBold)),
                  const SizedBox(height: 5),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.createdAt, style: AppStyles.text12Px)),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ]);
}

Widget everyProductWidgetGrants(BuildContext context, BlogModelNewsFinanceModel product) {
  return Stack(children: [
    Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: const Card(elevation: 0.2, color: Color(0xFFF4FBF3))),
    Column(
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            HomeRoutes.singlePageScreenGrants(product);
          },
          child: Row(
            children: [
              const SizedBox(width: 15),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.title, style: AppStyles.text18PxBold)),
                  const SizedBox(height: 5),
                  SizedBox(width: MediaQuery.of(context).size.width / 2, child: Text(product.createdAt, style: AppStyles.text12Px)),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ]);
}
