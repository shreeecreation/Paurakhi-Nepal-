import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

void quotationHistoryScreen(BuildContext context) {
// modal bottom sheet go up with the keyboard appears
  showModalBottomSheet(
    backgroundColor: AppColors.defaultbackground,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("Quotation History", style: AppStyles.text22PxBold),
                const SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0.5,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ListTile(
                          trailing: const Icon(Icons.menu, size: 30, color: Colors.green),
                          title: Text("Title of the Content", style: AppStyles.text20PxBold),
                          subtitle: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(height: 4),
                            Text("From: Nabil Bank"),
                            Text("Date: 2023/12/05"),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    },
  );
}
