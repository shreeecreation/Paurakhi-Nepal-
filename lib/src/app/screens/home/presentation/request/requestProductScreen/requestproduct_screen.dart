import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/core/API/RequestProductAPI/request_product_api.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'model/requestproduct_model.dart';

void requestProduct(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController minQtyController = TextEditingController();
  GlobalKey<FormState> formKeyRequestProduct = GlobalKey<FormState>();

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
                          Text("  Request Product", style: AppStyles.text20PxBold),
                          Flexible(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close))),
                        ],
                      ),
                      FutureBuilder<List<DropdownMenuItem<String>>>(
                        future: DropdownList.returnDropdown(),
                        builder: (context, snapshot) {
                          List<DropdownMenuItem<String>>? menuItems = snapshot.data;
                          if (menuItems != null) {
                            return DropdownList.fullDropdownButton(context, "1", menuItems);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
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
                                onPressed: () {
                                  //TODO request screen
                                  if (formKeyRequestProduct.currentState!.validate()) {
                                    RequestProductModel model = RequestProductModel(
                                        titleController.text, "request", descriptionController.text, DropdownList.dropDownIndex, 10, 10);
                                    RequestProductAPI.sellProduct(model);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF34A853),
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                child: Text("Request Product", style: AppStyles.text16Px))),
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
          hintText: 'Add Request Title',
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
          if (!ExtString.validateFirstName(val!)) return " Enter some more product description";
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
