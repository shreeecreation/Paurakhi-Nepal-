import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/core/API/SellScreenAPI/sell_product_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/addmultipleimage.dart';

import 'addtag.dart';
import 'domain/dropdown.dart';
import 'domain/tag.dart';
import 'model/product_model.dart';

void addProduct(BuildContext context) {
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
              child: Form(
                key: formKeyAddProduct,
                child: Container(
                    color: const Color(0xFFF4FBF3),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("  Sell Product", style: AppStyles.text20PxBold),
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
                              const SizedBox(width: 5),
                              FutureBuilder<List<DropdownMenuItem<String>>>(
                                future: DropdownList.returnDropdown(),
                                builder: (context, snapshot) {
                                  List<DropdownMenuItem<String>>? menuItems = snapshot.data;
                                  if (menuItems != null) {
                                    return DropdownList.dropdownButton(context, "1", menuItems, selectedValIndex);
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(width: 5),
                              Container(
                                  height: 55,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: IconButton(
                                      icon: const Icon(Icons.image_rounded),
                                      onPressed: () async {
                                        try {
                                          int length = 0;
                                          images = (await MultipleImageChooser.pickImages(length));
                                          print(images.length);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      color: const Color(0xFF34A853)))
                            ],
                          ),
                          const SizedBox(height: 5),
                          projectTitle(context, productTitleController),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              productPrice(context, productPriceController),
                              const SizedBox(width: 5),
                              minQty(context, productMinQtyController),
                            ],
                          ),
                          const SizedBox(height: 10),
                          addProductDescripttion(context, productDescriptionController),
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
                                      if (formKeyAddProduct.currentState!.validate()) {
                                        SellProductModel model = SellProductModel(
                                            productTitleController.text,
                                            "request",
                                            productDescriptionController.text,
                                            Tag.allTag,
                                            int.parse(selectedValIndex),
                                            MultipleImageChooser.images,
                                            int.parse(productMinQtyController.text),
                                            int.parse(productPriceController.text));
                                        SellProductAPI.sellProduct(model);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF34A853),
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                    child: Text("Sell Product", style: AppStyles.text16Px))),
                          ),
                          const SizedBox(height: 30),
                        ]),
                      ),
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Padding projectTitle(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (!ExtString.validateFirstName(val!)) return " Enter a valid Product Title";
          return null;
        },
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

Padding addProductDescripttion(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (!ExtString.validateFirstName(val!)) return "Add some product description";
          return null;
        },
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

Padding productPrice(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        validator: (val) {
          if (!ExtString.validateProductPrice(val!)) return " Enter a valid price";
          return null;
        },
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

Padding minQty(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (!ExtString.validateMinQty(val!)) return " Enter a valid quantity";
          return null;
        },
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
