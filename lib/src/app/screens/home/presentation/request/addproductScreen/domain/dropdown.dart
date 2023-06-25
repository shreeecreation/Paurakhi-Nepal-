import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/choosedunit.dart';

import 'dropdown_api.dart';

class DropdownList {
  static int dropDownIndex = 0;
  static List<DropdownMenuItem> allCategory = [];
  static ChoosedUnitController chooseUnitController = Get.find<ChoosedUnitController>();
  static Future<List<DropdownMenuItem<String>>> returnDropdown() async {
    List<DropdownMenuItem<String>> list = await DropDownAPI.dropdownAPI();
    return list;
  }

  static Future<List<DropdownMenuItem<String>>> returnDropdownforAdding() async {
    List<DropdownMenuItem<String>> list = await DropDownAPI.dropdownAPI();
    list.removeAt(0);
    return list;
  }

  static Widget dropdownButton(BuildContext context, List<DropdownMenuItem<String>> menuItems) {
    String? selectedValue;
    if (menuItems.isNotEmpty) {
      selectedValue = menuItems.first.value;
      dropDownIndex = int.parse(menuItems.first.value!);
    }
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
            validator: (value) => value == null ? "All" : null,
            dropdownColor: const Color(0xFFFFFFFF),
            value: selectedValue,
            onChanged: (String? newValue) {
              var dropDownIndexs = menuItems.indexWhere((item) => item.value == newValue);
              dropDownIndex = int.parse(menuItems[dropDownIndexs].value!); // get the ID of the selected item
              selectedValue = newValue!;
              selectedValue = newValue;
              chooseUnitController.changeunit();
            },
            items: menuItems),
      ),
    );
  }

  static Widget fullDropdownButton(BuildContext context, String? selectedValue, List<DropdownMenuItem<String>> menuItems) {
    return Center(
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width / 1.1,
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
              var dropDownIndexs = menuItems.indexWhere((item) => item.value == newValue);
              dropDownIndex = int.parse(menuItems[dropDownIndexs].value!); // get the ID of the selected item
              selectedValue = newValue!;
              selectedValue = newValue;
            },
            items: menuItems),
      ),
    );
  }
}
