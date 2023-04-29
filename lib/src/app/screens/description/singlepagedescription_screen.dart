import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/searchwidget.dart';

import 'quotation/quotation_screen.dart';

class SinglePageDescriptionScreen extends StatelessWidget {
  SinglePageDescriptionScreen({super.key, required this.model});
  ProductModel model;
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
            height: MediaQuery.of(context).size.height,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(width: MediaQuery.of(context).size.width - 20, height: 200, child: Image.asset(model.imagePath)),
              const SizedBox(height: 10),
              const Row(
                children: [Text("Grant"), SizedBox(width: 5), Text("International")],
              ),
              const SizedBox(height: 5),
              Text(model.productName, style: AppStyles.text22PxBold),
              const SizedBox(height: 5),
              Text(model.productPrice, style: AppStyles.text22PxBold.textGreen),
              const SizedBox(height: 15),
              Text("Product Description", style: AppStyles.text16PxBold),
              const SizedBox(height: 10),
              Text(model.productDesc, style: AppStyles.text14Px),

              //Product Detail
              const SizedBox(height: 15),

              Text("Product Detail", style: AppStyles.text16PxBold),
              const SizedBox(height: 10),
              Text(model.productDetail, style: AppStyles.text14Px),
              const SizedBox(height: 15),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: ElevatedButton(
                          onPressed: () {
                            //TODO Get quotation
                            quotationBottomSheet(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF34A853),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                          child: Text("Get Quotation ", style: AppStyles.text16Px))),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
