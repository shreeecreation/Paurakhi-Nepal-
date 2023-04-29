import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class OpenTicket extends StatelessWidget {
  OpenTicket({super.key});
  final String? selectedValue = "Farming Product";
  final List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Farming Product", child: Text("Farming Product")),
    const DropdownMenuItem(value: "Canada", child: Text("Canada")),
    const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
    const DropdownMenuItem(value: "England", child: Text("England")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "Open Ticket",
            style: AppStyles.text20PxSemiBold.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              userName(context),
              email(context),
              subject(context),
              dropdownButton(context, selectedValue, menuItems),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Message')),
                ),
              ),
              
              ElevatedButton(
                                    onPressed: () {
                                      //TODO submit
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF34A853),
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                    child: Text("Submit", style: AppStyles.text16Px))
            ],
          ),
        ));
  }
}

Padding userName(BuildContext context) {
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
              hintText: 'Birendra Bikram')),
    ),
  );
}

Padding email(BuildContext context) {
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
              hintText: 'Test@email2023.com')),
    ),
  );
}

Padding subject(BuildContext context) {
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
              hintText: 'Add Subject ')),
    ),
  );
}

Center dropdownButton(BuildContext context, String? selectedValue, List<DropdownMenuItem<String>> menuItems) {
  return Center(
    child: SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width - 30,
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
