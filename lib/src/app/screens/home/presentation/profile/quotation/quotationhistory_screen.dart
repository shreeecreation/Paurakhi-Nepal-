import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
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
        child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("  Get Quotation", style: AppStyles.text20PxBold),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  Personal Information ", style: AppStyles.text16PxBold),
                          TextButton(onPressed: () {}, child: Text("change", style: AppStyles.text13Px.textGreen)),
                        ],
                      ),
                      SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Card(
                              elevation: 0,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 30),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.person),
                                            const SizedBox(width: 5),
                                            Text("Birendra Bikram ", style: AppStyles.text20PxSemiBold),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const Icon(Icons.location_on_outlined),
                                            const SizedBox(width: 5),
                                            Text("Jukot, Bajura", style: AppStyles.text14Px),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone_outlined),
                                            const SizedBox(width: 5),
                                            Text("+977 98104200", style: AppStyles.text14Px),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]))),
                      quantity(context),
                      budget(context),
                      Row(children: [
                        const SizedBox(width: 10),
                        Expanded(
                            child: SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: () {
                                      // addProduct(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF34A853),
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                    child: Text("Send", style: AppStyles.text16Px)))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                              child: const Text('Click me')),
                        )),
                        const SizedBox(width: 10)
                      ])
                    ],
                  ),
                ),
              )),
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
