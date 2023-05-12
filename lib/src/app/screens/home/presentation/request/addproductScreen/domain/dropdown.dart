import 'package:flutter/material.dart';

import 'dropdown_api.dart';

class DropdownList {
  static int dropDownIndex = 0;
  static List<DropdownMenuItem> allCategory = [];
  static Future<List<DropdownMenuItem<String>>> returnDropdown() async {
    List<DropdownMenuItem<String>> list = await DropDownAPI.dropdownAPI();
    
    return list;
  }

  static Future<List<DropdownMenuItem>> returnCatergory() async {
    List<DropdownMenuItem> list = await DropDownAPI.categoryAPI();
    return list;
  }

  static List<DropdownMenuItem> returnCategoryOnly() {
    List<DropdownMenuItem> finalList = [];
    Future<List<DropdownMenuItem>> list = DropDownAPI.categoryAPI().then(
      (value) {
        finalList = value;
        allCategory = finalList;
        return finalList;
      },
    );
    return finalList;
  }

  static Widget dropdownButton(BuildContext context, String? selectedValue, List<DropdownMenuItem<String>> menuItems) {
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
              var dropDownIndexs = menuItems.indexWhere((item) => item.value == newValue);
              dropDownIndex = int.parse(menuItems[dropDownIndexs].value!); // get the ID of the selected item
              selectedValue = newValue!;
              selectedValue = newValue;
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
