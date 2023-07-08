import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/profile/model/profile_model.dart';
import 'package:paurakhi/src/core/API/Send%20Finance%20API/send_finance_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

void financeEnquiryBottomSheet(BuildContext context, financeId) {
  GlobalKey<FormState> financeState = GlobalKey<FormState>();

  TextEditingController valueController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
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
        child: SingleChildScrollView(
          child: Form(
            key: financeState,
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text("Enquire Now", style: AppStyles.text20PxBold),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("  Personal Information ",
                                style: AppStyles.text16PxBold),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Card(
                            elevation: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.person),
                                            const SizedBox(width: 5),
                                            Text(Profile.finalName,
                                                style: AppStyles.text14Px),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Icon(
                                                Icons.location_on_outlined),
                                            const SizedBox(width: 5),
                                            Text(Profile.address ?? "",
                                                style: AppStyles.text14Px),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone_outlined),
                                            const SizedBox(width: 5),
                                            Text(ProfileModel.phoneNumber ?? "",
                                                style: AppStyles.text14Px),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        purpose(context, purposeController),
                        value(context, valueController),
                        Row(children: [
                          const SizedBox(width: 10),
                          Expanded(
                              child: SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await SendFinanceAPI.sendFinance(
                                            purposeController.text,
                                            context,
                                            financeId,
                                            valueController.text);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF34A853),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)))),
                                      child: Text("Send",
                                          style: AppStyles.text16Px)))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              color: Colors.green, width: 1.5)),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green)),
                                child: const Text('Cancel')),
                          )),
                          const SizedBox(width: 10)
                        ]),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      );
    },
  );
}

Padding purpose(BuildContext context, purposeController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: purposeController,
        maxLines: 3,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Purpose of loan...',
        ),
      ),
    ),
  );
}

Padding value(BuildContext context, valueController) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: valueController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.monetization_on),
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Estimated Valuation...',
        ),
      ),
    ),
  );
}
