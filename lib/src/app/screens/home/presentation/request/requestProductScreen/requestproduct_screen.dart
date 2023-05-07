import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

void requestProduct(BuildContext context) {
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
            height: MediaQuery.of(context).size.height / 1.5,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
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
                        dropdownButton(context, selectedValue, menuItems),
                        const SizedBox(height: 5),
                        addRequestTitle(context),
                        const SizedBox(height: 5),
                        addProductDescripttion(context),
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
      );
    },
  );
}

Center dropdownButton(BuildContext context, String? selectedValue, List<DropdownMenuItem<String>> menuItems) {
  return Center(
    child: SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width - 20,
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

Padding addRequestTitle(BuildContext context) {
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
          hintText: 'Add Request Title',
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
