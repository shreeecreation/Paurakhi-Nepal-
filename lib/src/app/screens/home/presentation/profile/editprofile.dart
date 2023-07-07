import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/core/API/EditProfile/edit_profile_api.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/providers/location_provider.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:provider/provider.dart';

import 'bloc/profile_bloc.dart';
import 'model/edit_profile_model.dart';
import 'model/profile_model.dart';

void editProfileDialog(BuildContext context) {
  final ValueNotifier<bool> isCheckedNotifier = ValueNotifier<bool>(false);

  TextEditingController firstNameController =
      TextEditingController(text: Profile.firstName);
  TextEditingController lastNameController =
      TextEditingController(text: Profile.lastName);
  TextEditingController addressController =
      TextEditingController(text: Profile.address);
  GlobalKey<FormState> editProfileKey = GlobalKey<FormState>();

  showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF4FBF3),
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
              child: SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Container(
                color: const Color(0xFFF4FBF3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: editProfileKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
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
                                  if (!ExtString.validateFirstName(value!)) {
                                    return "Invalid Name !";
                                  }
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
                                  if (!ExtString.validateSecondName(value!)) {
                                    return "Invalid Name !";
                                  }
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
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: isCheckedNotifier,
                              builder: (context, value, child) {
                                return Checkbox(
                                  value: ProfileModel.twoFactor,
                                  activeColor: Colors.green,
                                  onChanged: (newValue) {
                                    ProfileModel.twoFactor = newValue!;
                                    isCheckedNotifier.value = newValue;
                                  },
                                );
                              },
                            ),
                            Text("Two factor authentication",
                                style: AppStyles.text16Px),
                          ],
                        ),
                        location(context, addressController),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: () async {
                                addressController.text =
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .location;
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFF34A853),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text('Auto Select ',
                                      style: AppStyles.text12Px.white),
                                  const Icon(Icons.location_on),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // TODO: editProfile

                                    if (editProfileKey.currentState!
                                        .validate()) {
                                      EditProfileModel model =
                                          EditProfileModel();
                                      model.address = addressController.text;
                                      model.firstName =
                                          firstNameController.text;
                                      model.lastName = lastNameController.text;
                                      model.twoFactor = isCheckedNotifier.value;
                                      await EditProfile.editProfile(
                                          model, context);

                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        BlocProvider.of<ProfileBloc>(context)
                                            .add(ProfileLoadEvent());
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF34A853),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  child:
                                      Text("Save", style: AppStyles.text16Px),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Colors.green, width: 1.5),
                                    ),
                                    backgroundColor: const Color(0xFFF4FBF3),
                                  ),
                                  child: Text('Cancel',
                                      style: AppStyles.text16Px.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
        );
      });
}

Widget location(BuildContext context, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width - 30,
      child: TextFormField(
        validator: (value) {
          if (value!.length < 4) return "Address length can't be less than 4";
          return null;
        },
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

// void editProfileDialog(BuildContext context) {
//   showModalBottomSheet<void>(
//     isScrollControlled: true,
//     context: context,
//     useSafeArea: true,
//     backgroundColor: Colors.transparent,
//     builder: (BuildContext context) {
//       return EditProfileDialog();
//     },
//   );
// }

class ExtString {
  static bool validateFirstName(String? name) {
    if (name != null && name.isNotEmpty && name.length > 1) {
      return true;
    }
    return false;
  }

  static bool validateSecondName(String? name) {
    if (name != null && name.isNotEmpty && name.length > 1) {
      return true;
    }
    return false;
  }

  static bool validatePhoneNumber(String? number) {
    if (number != null && number.isNotEmpty && number.length >= 10) {
      return true;
    }
    return false;
  }
}
