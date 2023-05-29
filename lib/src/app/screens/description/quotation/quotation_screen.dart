import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/profile/model/profile_model.dart';
import 'package:paurakhi/src/core/API/Send%20quotation%20API/sendquotation_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

void quotationBottomSheet(BuildContext context, productId) {
  GlobalKey<FormState> quantityState = GlobalKey<FormState>();

  TextEditingController quantityController = TextEditingController();
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: const Color(0xFFF4FBF3),
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: quantityState,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text("Get Quotation", style: AppStyles.text20PxBold),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            Text("Personal Information", style: AppStyles.text16PxBold),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.person),
                                            const SizedBox(width: 5),
                                            Text(Profile.finalName, style: AppStyles.text20PxSemiBold),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const Icon(Icons.location_on_outlined),
                                            const SizedBox(width: 5),
                                            Text(Profile.address ?? "", style: AppStyles.text14Px),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone_outlined),
                                            const SizedBox(width: 5),
                                            Text(ProfileModel.phoneNumber ?? "", style: AppStyles.text14Px),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 30,
                            child: TextFormField(
                              controller: quantityController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) return "Empty Quotation";
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.menu),
                                  filled: true,
                                  fillColor: const Color(0xFFFFFFFF),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Quantity...'),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 10),

                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (quantityState.currentState!.validate()) {
                                        SendQuotationAPI.sendQuotation(quantityController.text, context, productId);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF34A853),
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                    child: Text("Send", style: AppStyles.text16Px)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: const BorderSide(color: Colors.green, width: 1.5),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                                    child: const Text('Cancel')),
                              ),
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Padding quantity(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.menu),
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Quantity...',
        ),
      ),
    ),
  );
}

Padding budget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.menu),
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Add Request Title',
        ),
      ),
    ),
  );
}
