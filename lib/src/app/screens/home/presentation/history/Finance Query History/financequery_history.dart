import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/Finance%20Query%20History/finance_query_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'model/financequery_model.dart';

void financeHistoryScreen(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: AppColors.defaultbackground,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("Finance Query History", style: AppStyles.text22PxBold),
                const SizedBox(height: 20),
                FutureBuilder<FinanceHistoryModel?>(
                  future: FinanceEnquiryHistory.financeHistory(),
                  builder: (BuildContext context, AsyncSnapshot<FinanceHistoryModel?> snapshot) {
                    if (snapshot.hasData) {
                      final FinanceHistoryModel dataList = snapshot.data!;
                      print(dataList.data.length);

                      if (dataList.data.isEmpty) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            const Icon(Icons.info_rounded, size: 60, color: Colors.grey),
                            const SizedBox(height: 30),
                            Text("No history found !", style: AppStyles.text18PxMedium),
                          ],
                        ));
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataList.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Datum datum = dataList.data[index];
                          return historyWidget(datum.purpose, datum.status, datum.value);
                          // return const Text("dasdas");
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

SizedBox historyWidget(product, status, price) {
  return SizedBox(
    height: 100,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.5,
      child: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            title: Text("$product", style: AppStyles.text20PxBold),
            trailing: status == "pending"
                ? const Icon(Icons.check_circle_rounded, size: 30, color: Colors.grey)
                : status == "cancel"
                    ? const Icon(Icons.close_rounded, size: 30, color: Colors.red)
                    : status == "approved"
                        ? const Icon(Icons.check_circle_rounded, size: 30, color: Colors.green)
                        : const Icon(Icons.close_rounded, size: 30, color: Colors.red),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 4),
              Text("Value : $price"),
            ]),
          ),
        ],
      ),
    ),
  );
}
