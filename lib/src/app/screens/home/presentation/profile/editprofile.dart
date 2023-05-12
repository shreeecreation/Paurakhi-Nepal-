import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/core/API/EditProfile/edit_profile_api.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/providers/location_provider.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:provider/provider.dart';

import 'model/edit_profile_model.dart';
import 'model/profile_model.dart';

void editProfileDialog(BuildContext context) {
  TextEditingController firstNameController = TextEditingController(text: Profile.firstName);
  TextEditingController lastNameController = TextEditingController(text: Profile.lastName);
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: TextFormField(
                            controller: firstNameController,
                            validator: (value) {
                              if (!ExtString.validateFirstName(value!)) return "Name can't be less than 4";
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              hintStyle: AppStyles.text16Px.textGrey,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: TextFormField(
                            controller: lastNameController,
                            validator: (value) {
                              if (!ExtString.validateSecondName(value!)) return "Name can't be less than 4";
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              hintStyle: AppStyles.text16Px.textGrey,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    phoneNumber(context, phoneNoController),
                    location(context, addressController),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        ElevatedButton(
                            onPressed: () async {
                              addressController.text = Provider.of<LocationProvider>(context, listen: false).location;
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFF34A853),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                            child: Row(
                              children: [
                                Text('Auto Select ', style: AppStyles.text12Px.white),
                                const Icon(Icons.location_on),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      const SizedBox(width: 10),
                      Expanded(
                          child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    //TODO editProfile
                                    EditProfileModel model = EditProfileModel();

                                    model.address = addressController.text;
                                    model.phoneNo = phoneNoController.text;
                                    model.firstName = firstNameController.text;
                                    model.lastName = lastNameController.text;
                                    EditProfile.editProfile(model);
                                  },
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
          hintText: 'Name',
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
          hintText: 'Phone Number',
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
          hintText: 'Address',
        ),
      ),
    ),
  );
}
