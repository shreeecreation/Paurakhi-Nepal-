import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import 'model/profile_model.dart';

void editProfileDialog(BuildContext context) {
  TextEditingController nameController = TextEditingController(text: Profile.finalName);
  TextEditingController phoneNoController = TextEditingController(text: ProfileModel.phoneNumber);
  TextEditingController addressController = TextEditingController(text: Profile.address);
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
          child: SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(),
              child: SizedBox(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text("Edit Profile", style: AppStyles.text22PxBold),
                    profileName(context, nameController),
                    phoneNumber(context, phoneNoController),
                    location(context, addressController),
                    const SizedBox(height: 20),
                    Row(children: [
                      const SizedBox(width: 10),
                      Expanded(
                          child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color(0xFF34A853),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                  child: Text("Save", style: AppStyles.text16Px)))),
                      const SizedBox(width: 10),
                      Expanded(
                          child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                                backgroundColor: const Color(0xFFF4FBF3)),
                            child: Text('Cancel', style: AppStyles.text16Px.black)),
                      )),
                    ]),
                    const SizedBox(height: 25)
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

Widget profileName(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Icons.person),
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Birendar Bikram',
        ),
      ),
    ),
  );
}

Widget phoneNumber(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Icons.phone),
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: '+977-9808901365',
        ),
      ),
    ),
  );
}

Widget location(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Icons.location_on),
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: 'Jukot, Bahara',
        ),
      ),
    ),
  );
}
