import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/requestProductScreen/requestproduct_screen.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'addproductScreen/addproduct_screen.dart';

void requestBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    ),
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
        child: Container(
            height: 150,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("  Choose", style: AppStyles.text20PxBold),
                        Flexible(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close)))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      const SizedBox(width: 10),
                      Expanded(
                          child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    addProduct(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF34A853),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                  child: Text("Add", style: AppStyles.text16Px)))),
                      const SizedBox(width: 10),
                      Expanded(
                          child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    requestProduct(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF34A853),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                  child: Text("Request ", style: AppStyles.text16Px)))),
                      const SizedBox(width: 10)
                    ])
                  ],
                ),
              ),
            )),
      );
    },
  );
}
