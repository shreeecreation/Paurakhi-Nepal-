import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/requestProductScreen/requestproduct_screen.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

void quotationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
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
