import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

void requestProduct(BuildContext context) {
  String selectedValIndex = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
            height: MediaQuery.of(context).size.height / 1.5,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Form(
                key: formKeyRequestProduct,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
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
                                return DropdownList.dropdownButton(context, "1", menuItems, selectedValIndex);
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
                          Center(
                            child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      //TODO request screen

                                      // RequestProductAPI.sellProduct();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF34A853),
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                    child: Text("Request Product", style: AppStyles.text16Px))),
                          )
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
