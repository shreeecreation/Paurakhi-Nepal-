import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/core/API/registeruser/registerapi.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/get_current_location.dart';

import 'domain/model.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  File? image;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  getLocation() async {
    try {
      await GetCurrentLocation.getCurrentPosition(context).then((value) => addressController.text = GetCurrentLocation.currentAddress ?? "");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false, // Disable automatic resizin
        backgroundColor: const Color(0xFFF4FBF3),
        body: Form(
          key: formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                const SizedBox(height: 50),
                Text("Set Your Farm Now", style: AppStyles.text24PxBold),
                Text("sign in to start your journey", style: AppStyles.text16Px),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () async {
                        var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          File? img = File(pickedFile.path);
                          img = await cropImage(imageFile: img);
                          setState(() {
                            image = img;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF4FBF3),
                        elevation: 0,
                      ),
                      child: image != null
                          ? CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 80,
                            )
                          : const CircleAvatar(
                              radius: 70,
                              backgroundColor: Color.fromARGB(255, 180, 180, 180),
                              child: Icon(Icons.person_add_alt, size: 50, color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                    ),
                  ),
                ),
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
                            borderSide: const BorderSide(color: Colors.black, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextFormField(
                        controller: secondNameController,
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
                            borderSide: const BorderSide(color: Colors.black, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                phoneNumber(context),
                const SizedBox(height: 10),
                email(context),
                const SizedBox(height: 10),
                address(context),
                const SizedBox(height: 10),
                password(context),
                const SizedBox(height: 10),
                confirmPassword(context),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                signUp(context),
                const SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.network(
                    "http://pngimg.com/uploads/google/google_PNG19635.png",
                    height: 30,
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                      onTap: () {
                        AuthRoutes.googelSigninRoute();
                      },
                      child: Text("Login with Google", style: AppStyles.text18PxBold))
                ]),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    Text("Already have an account ?", style: AppStyles.text14PxMedium),
                    TextButton(
                        onPressed: () {
                          AuthRoutes.loginRoute();
                        },
                        child: const Text("Log In"))
                  ],
                ),
                const SizedBox(height: 10),
                Align(alignment: Alignment.bottomCenter, child: Image.asset('assets/images/design.png', fit: BoxFit.cover)),
              ]),
            ),
          ),
        ));
  }

  SizedBox signUp(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.2,
        child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                RegisterModel model = RegisterModel();
                model.phoneNo = phoneNumberController.text;
                model.firstName = firstNameController.text;
                model.lastName = secondNameController.text;
                model.address = addressController.text;
                model.phoneNo = phoneNumberController.text;
                model.password = passwordController.text;
                model.email = emailController.text;
                // print(image!.path);
                model.image = image!;
                var response = await RegisterAPI.registerAPI(model);
                var data = response?.body;
                if (data != null) {
                  AuthRoutes.loginRoute();
                }
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34A853), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: Text("Sign Up", style: AppStyles.text18PxSemiBold)));
  }

  SizedBox confirmPassword(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        controller: confirmpasswordController,
        validator: (value) {
          if (passwordController.text != confirmpasswordController.text) return "Enter a valid name";
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Confirm Password',
          filled: true,
          hintStyle: AppStyles.text16Px.textGrey,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)),
        ),
      ),
    );
  }

  Widget address(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: TextFormField(
          controller: addressController,
          validator: (value) {
            if (!ExtString.validateFirstName(value!)) return "Enter a valid address";
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Address',
            filled: true,
            hintStyle: AppStyles.text16Px.textGrey,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)),
          ),
        ),
      ),
    );
  }

  SizedBox email(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        validator: (value) {
          if (!ExtString.isEmailValid(value!)) return "Enter a valid email";
          return null;
        },
        controller: emailController,
        decoration: InputDecoration(
          hintText: 'email',
          filled: true,
          hintStyle: AppStyles.text16Px.textGrey,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)),
        ),
      ),
    );
  }

  SizedBox password(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
        validator: (value) {
          if (!ExtString.validatePassword(value!)) return "Enter a valid password";
          return null;
        },
        controller: passwordController,
        decoration: InputDecoration(
          hintText: 'Password',
          filled: true,
          hintStyle: AppStyles.text16Px.textGrey,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)),
        ),
      ),
    );
  }

  SizedBox phoneNumber(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextFormField(
          controller: phoneNumberController,
          validator: (value) {
            if (!ExtString.validatePhoneNumber(value!)) return "Enter a valid number";
            return null;
          },
          decoration: InputDecoration(
              hintText: 'Phone Number',
              hintStyle: AppStyles.text16Px.textGrey,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)))),
    );
  }
}

Future<File?> cropImage({required File imageFile}) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
  if (croppedImage == null) return null;
  return File(croppedImage.path);
}
