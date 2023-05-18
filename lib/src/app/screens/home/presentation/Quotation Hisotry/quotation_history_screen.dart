import 'dart:io';

import 'package:flutter/material.dart';

void quotationScreen(BuildContext context) {
  GlobalKey<FormState> formKeyAddProduct = GlobalKey<FormState>();

  TextEditingController productTitleController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productMinQtyController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  String selectedValIndex = "";
  List<File> images;
// modal bottom sheet go up with the keyboard appears
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFFF4FBF3),
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return const ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          child: ListTile(
            title: Text("title of the Content"),
            subtitle: Column(children: [
              Text("From: Nabil Bank"),
              Text("Date: 2023/12/05"),
            ]),
          ));
    },
  );
}
