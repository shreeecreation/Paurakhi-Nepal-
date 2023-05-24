import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';
import 'quotation/quotation_screen.dart';

class SinglePageDescriptionScreen extends StatelessWidget {
  const SinglePageDescriptionScreen({super.key, required this.model});
  final ProductModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: SizedBox(
            width: MediaQuery.of(context).size.width - 50, child: Align(alignment: Alignment.topLeft, child: searchWidgetSinglePage(context))),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 200,
                  child: model.images.isEmpty
                      ? Image.asset("assets/images/defaultImage.jpg")
                      : Image.network("${Environment.imageUrl}/${model.images[0]}", fit: BoxFit.fill)),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: model.tags.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String tag = model.tags[index];
                        return Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color(0xFFD9D9D9)),
                            height: 30,
                            width: 50,
                            margin: const EdgeInsets.only(right: 10),
                            child: Center(child: Text(tag, style: AppStyles.text14Px)));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Text(model.name, style: AppStyles.text24PxBold),
              //Product Detail
              const SizedBox(height: 25),

              Text("Product Description", style: AppStyles.text16Px.textGrey),
              const SizedBox(height: 10),

              Text(model.description, style: AppStyles.text16Px),
              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("Category", style: AppStyles.text16Px.textGrey),
                      const SizedBox(height: 10),
                      Text(model.category.name, style: AppStyles.text16Px),
                      const SizedBox(height: 15),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Quantity", style: AppStyles.text16Px.textGrey),
                      const SizedBox(height: 10),
                      Text(model.quantity.toString(), style: AppStyles.text16Px),
                      const SizedBox(height: 15),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Quantity", style: AppStyles.text16Px.textGrey),
                      const SizedBox(height: 10),
                      Text(model.type, style: AppStyles.text16Px),
                      const SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                  child: Align(
                alignment: Alignment.center,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Get quotation
                        quotationBottomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF34A853),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                      child: Text("Get Quotation", style: AppStyles.text16Px),
                    ),
                  ),
                ),
              ))
            ]),
          ),
        ),
      ),
    );
  }
}

class SinglePageDescriptionScreenBlog extends StatelessWidget {
  SinglePageDescriptionScreenBlog({super.key, required this.model});
  BlogModelandNewsModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        // flexibleSpace: SizedBox(
        //     width: MediaQuery.of(context).size.width - 50, child: Align(alignment: Alignment.topLeft, child: searchWidgetSinglePage(context))),
        title: Text(model.tittle, style: AppStyles.text20PxSemiBold.black),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 200,
                  child: model.blogImage == null ? Image.asset("assets/images/defaultImage.jpg") : Image.network(model.blogImage)),
              const SizedBox(height: 10),
              const Row(
                children: [],
              ),
              const SizedBox(height: 5),
              Text(model.tittle, style: AppStyles.text22PxBold),

              //Product Detail
              const SizedBox(height: 15),

              Text("Product Detail", style: AppStyles.text16PxBold),
              const SizedBox(height: 5),
              Html(
                data: model.body,
                style: {
                  'body': Style(
                    fontSize: FontSize.medium,
                    fontWeight: FontWeight.normal,
                  ),
                },
              ),
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }
}
