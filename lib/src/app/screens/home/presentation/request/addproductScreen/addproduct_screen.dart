import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/SellScreenAPI/sell_product_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'addtag.dart';
import 'model/product_model.dart';

void addProduct(BuildContext context) {
  String? selectedValue = "Farming Product";
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Farming Product", child: Text("Farming Product")),
    const DropdownMenuItem(value: "Canada", child: Text("Canada")),
    const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
    const DropdownMenuItem(value: "England", child: Text("England")),
  ];

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
      return Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Container(
                  color: const Color(0xFFF4FBF3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("  Add Product", style: AppStyles.text20PxBold),
                            Flexible(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close))),
                          ],
                        ),
                        Row(
                          children: [
                            dropdownButton(context, selectedValue, menuItems),
                            const SizedBox(width: 5),
                            Container(
                                height: 55,
                                width: 50,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: const Icon(Icons.image_rounded, color: Color(0xFF34A853)))
                          ],
                        ),
                        const SizedBox(height: 5),
                        projectTitle(context),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            productPrice(context),
                            const SizedBox(width: 5),
                            minQty(context),
                          ],
                        ),
                        const SizedBox(height: 10),
                        addProductDescripttion(context),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: Container(
                              height: 40,
                              width: 70,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Center(child: Text("Product", style: AppStyles.text12PxMedium))),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                          title: Text("Type to add more tags ...", style: AppStyles.text14PxBold),
                          trailing: const Icon(Icons.keyboard_arrow_right_outlined, size: 30),
                          onTap: () async {
                            final tags = await TagGenerator.showTagDialog(context);
                          },
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    //TODO add product function

                                    // RequestProductModel model = RequestProductModel();
                                    // SellProductAPI.sellProduct(model);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF34A853),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                  child: Text("Add Product", style: AppStyles.text16Px))),
                        ),
                        const SizedBox(height: 30),
                      ]),
                    ),
                  )),
            ),
          ),
        ),
      );
    },
  );
}

Center dropdownButton(BuildContext context, String? selectedValue, List<DropdownMenuItem<String>> menuItems) {
  return Center(
    child: SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width / 1.5,
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0x00ffffff), width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0x00ffffff), width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
          ),
          validator: (value) => value == null ? "Farming Product" : null,
          dropdownColor: const Color(0xFFFFFFFF),
          value: selectedValue,
          onChanged: (String? newValue) {
            selectedValue = newValue!;
          },
          items: menuItems),
    ),
  );
}

Padding projectTitle(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Product Title',
        ),
      ),
    ),
  );
}

Padding addProductDescripttion(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextField(
        maxLines: 5,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Add product Description',
        ),
      ),
    ),
  );
}

Padding productPrice(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Product Price ',
        ),
      ),
    ),
  );
}

Padding minQty(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Min QTY',
        ),
      ),
    ),
  );
}
