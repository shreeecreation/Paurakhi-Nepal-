import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/description/singlepagedescription_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'focuesnode.dart';

Stack everyProductWidget(BuildContext context) {
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
              ProductModel models = ProductModel();
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                models.imagePath = "assets/images/design.png";
                models.productDesc =
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas id sit eu tellus sed cursus eleifend id porta. Lorem adipiscing mus vestibulum consequat porta eu ultrices";
                models.productDetail =
                    "Ipsum: Maecenas id sit eu tellus sed\n  Ipsdasm: Sasdanbo sjhsaduhs uhuh\nIpsdasm: Msdasd sit eu tellus sed  \nAsdsum: Maecenas idasdasdu tellus sed  \nIdassum: Maecenas id sit eu tellus sed  \nIpdasm: Maecesdas asdasd sdef ed  \n";
                models.productName = "Product Name in detail and maybe seller";
                models.productPrice = "Rs. 500 / KG";

                return SinglePageDescriptionScreen(model: models);
              })));
            },
            child: Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  height: 120,
                  width: 126,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(image: AssetImage("assets/images/nepalflag.png"), fit: BoxFit.cover)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(10.0), child: Align(alignment: Alignment.bottomRight, child: Container())),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //TODO get tag

                        Container(
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Color(0xFFD9D9D9)),
                            height: 40,
                            width: 70,
                            child: const Center(child: Text("Product"))),
                        const SizedBox(width: 10),

                        //TODO get tag
                        Container(
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Color(0xFFD9D9D9)),
                            height: 40,
                            width: 70,
                            child: const Center(child: Text("Fertilizer"))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text("Rs. Urea Fertilizer | High Quality | 100KG Package", style: AppStyles.text18PxBold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
