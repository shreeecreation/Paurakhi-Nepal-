import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/auth/login/login_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/model/blog_model.dart';
import 'package:paurakhi/src/app/screens/home/presentation/finance/financeaction.dart';
import 'package:paurakhi/src/app/screens/home/presentation/grants/grant_bottom_sheet.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/is_logged_in.dart';
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
                    ? Image.asset("assets/images/logo2.png")
                    : Container(
                        height: 120,
                        width: 126,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: "${Environment.apiUrl}/public/images/${model.images[0]}",
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
              ),
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
                        if (IsLoggedIn.isLoggedIn) {
                          quotationBottomSheet(context, model.id);
                        } else {
                          Get.offAll(const LoginScreen());
                        }
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
  const SinglePageDescriptionScreenBlog({super.key, required this.model});
  final BlogModelNewsFinanceModel model;
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
        title: Text(model.title, style: AppStyles.text20PxSemiBold.black),
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
                  // ignore: unnecessary_null_comparison
                  child: model.blogImage == null ? Image.asset("assets/images/logo2.png") : Image.network(model.blogImage)),
              const SizedBox(height: 10),
              const Row(
                children: [],
              ),
              const SizedBox(height: 5),
              Text(model.title, style: AppStyles.text22PxBold),

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

class SinglePageDescriptionScreenFinance extends StatelessWidget {
  const SinglePageDescriptionScreenFinance({super.key, required this.model});
  final BlogModelNewsFinanceModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(model.title, style: AppStyles.text20PxSemiBold.black),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                // ignore: unnecessary_null_comparison
                child: model.blogImage == null ? Image.asset("assets/images/logo2.png") : Image.network(model.blogImage),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [],
              ),
              const SizedBox(height: 5),
              Text(model.title, style: AppStyles.text22PxBold),
              const SizedBox(height: 15),
              Text("Finance Detail", style: AppStyles.text16PxBold),
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
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (IsLoggedIn.isLoggedIn) {
                        financeEnquiryBottomSheet(context,model.id);
                      } else {
                        Get.offAll(const LoginScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34A853),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    child: Text("Enquire Now", style: AppStyles.text16Px),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SinglePageDescriptionScreenGrants extends StatelessWidget {
  const SinglePageDescriptionScreenGrants({super.key, required this.model});
  final BlogModelNewsFinanceModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(model.title, style: AppStyles.text20PxSemiBold.black),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                // ignore: unnecessary_null_comparison
                child: model.blogImage == null ? Image.asset("assets/images/logo2.png") : Image.network(model.blogImage),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [],
              ),
              const SizedBox(height: 5),
              Text(model.title, style: AppStyles.text22PxBold),
              const SizedBox(height: 15),
              Text("Grants Detail", style: AppStyles.text16PxBold),
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
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (IsLoggedIn.isLoggedIn) {
                        applyGrantBottomSheet(context,model.id);
                      } else {
                        Get.offAll(const LoginScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34A853),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    child: Text("Apply for grants", style: AppStyles.text16Px),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}