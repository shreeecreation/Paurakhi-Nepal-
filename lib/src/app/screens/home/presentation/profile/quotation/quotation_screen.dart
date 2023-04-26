import 'package:flutter/material.dart';
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
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        child: Container(
            height: MediaQuery.of(context).size.height,
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
                        Text("  Quotation History", style: AppStyles.text20PxBold),
                        Flexible(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close))),
                      ],
                    ),
                    ListTile(
                      title: Text("Title of the content", style: AppStyles.text18PxMedium),
                      subtitle: const Text("From: Nabil Bank\nDate : Feb 20, 2023"),
                      trailing: const Icon(Icons.format_indent_increase_rounded, size: 30, color: Colors.green),
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      title: Text("Title of the content", style: AppStyles.text18PxMedium),
                      subtitle: const Text("From: Nabil Bank\nDate : Feb 20, 2023"),
                      trailing: const Icon(Icons.format_indent_increase_rounded, size: 30, color: Colors.black),
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      title: Text("Title of the content", style: AppStyles.text18PxMedium),
                      subtitle: const Text("From: Nabil Bank\nDate : Feb 20, 2023"),
                      trailing: const Icon(Icons.format_indent_increase_rounded, size: 30, color: Colors.red),
                    ),
                  ],
                ),
              ),
            )),
      );
    },
  );
}
