import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/Get%20Ticket%20API/getticket_api.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'getticket_model.dart';

void ticketHistoryScreen(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: AppColors.defaultbackground,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("  Ticket History", style: AppStyles.text24PxBold),
                      Flexible(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<TicketHistoryModel?>(
                    future: GetTicketHistory.ticketHistory(),
                    builder: (BuildContext context, AsyncSnapshot<TicketHistoryModel?> snapshot) {
                      if (snapshot.hasData) {
                        final TicketHistoryModel dataList = snapshot.data!;
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
                            final Datums datum = dataList.data[index];
                            return historyWidget(datum.tittle, datum.status, datum.createdAt);
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
                ? Icon(Icons.format_align_center_rounded, size: 30, color: Colors.green[200])
                : status == "close"
                    ? const Icon(Icons.format_align_center_rounded, size: 30, color: Colors.green)
                    : status == "unsolved"
                        ? const Icon(Icons.format_align_center_rounded, size: 30, color: Colors.grey)
                        : const Icon(Icons.format_align_center_rounded, size: 30, color: Colors.red),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 4),
              Text("Date: $price"),
            ]),
          ),
        ],
      ),
    ),
  );
}
