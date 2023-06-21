import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/core/API/RequestProductAPI/request_product_api.dart';
import 'package:paurakhi/src/core/dialogs/product/product_dialog.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/addmultipleimage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model/requestproduct_model.dart';

void requestProduct(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController minQtyController = TextEditingController();
  GlobalKey<FormState> formKeyRequestProduct = GlobalKey<FormState>();
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
                key: formKeyRequestProduct,
                child: SizedBox(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.request_product, style: AppStyles.text20PxBold),
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
                            future: DropdownList.returnDropdownforAdding(),
                            builder: (context, snapshot) {
                              List<DropdownMenuItem<String>>? menuItems = snapshot.data;
                              if (menuItems != null) {
                                return DropdownList.dropdownButton(context, "1", menuItems);
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
                                    } catch (e) {}
                                  },
                                  color: const Color(0xFF34A853)))
                        ],
                      ),
                      const SizedBox(height: 5),
                      addRequestTitle(context, titleController),
                      const SizedBox(height: 5),
                      addProductDescripttion(context, descriptionController),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          productPrice(context, priceController),
                          const SizedBox(width: 5),
                          minQty(context, minQtyController),
                        ],
                      ),
                      Center(
                        child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 50,
                            child: ElevatedButton(
                                onPressed: () async {
                                  //TODO request screen
                                  if (formKeyRequestProduct.currentState!.validate()) {
                                    RequestProductModel model = RequestProductModel(
                                      titleController.text,
                                      "request",
                                      descriptionController.text,
                                      DropdownList.dropDownIndex,
                                      10,
                                      10,
                                      MultipleImageChooser.images,
                                    );
                                    await RequestProductAPI.sellProduct(model);

                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      ProductDialogs().requestProduct(context);
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF34A853),
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                child: Text(AppLocalizations.of(context)!.request_product, style: AppStyles.text16Px))),
                      ),
                      const SizedBox(height: 20),
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

Padding addRequestTitle(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if (!ExtString.validateFirstName(val!)) return AppLocalizations.of(context)!.enter_a_valid_product_title;
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: AppLocalizations.of(context)!.add_request_title,
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
        validator: (val) {
          if (!ExtString.validateFirstName(val!)) return AppLocalizations.of(context)!.add_some_product_description;
          return null;
        },
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: AppLocalizations.of(context)!.add_product_description,
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
          if (!ExtString.validateProductPrice(val!)) return AppLocalizations.of(context)!.enter_a_valid_price;
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: AppLocalizations.of(context)!.product_price,
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
          if (!ExtString.validateMinQty(val!)) return AppLocalizations.of(context)!.enter_a_vaid_quantity;
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: AppLocalizations.of(context)!.min_qty,
        ),
      ),
    ),
  );
}
