import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4FBF3),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 35,
            child: Stack(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("Set Your Farm Now", style: AppStyles.text24PxBold),
                Text("sign in to start your journey", style: AppStyles.text16Px),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Full Name',
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
                const SizedBox(height: 10),
                phoneNumber(context),
                const SizedBox(height: 10),
                password(context),
                const SizedBox(height: 10),
                confirmPassword(context),
                const SizedBox(height: 15),
                Text("Choose profile", style: AppStyles.text18PxMedium),
                const SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ElevatedButton(
                      onPressed: () async {
                        var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        File? img = File(pickedFile!.path);
                        img = await cropImage(imageFile: img);
                        setState(() {
                          image = img;
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF4FBF3), elevation: 0),
                      child: image != null ? Image.file(image!) : const Icon(Icons.image, size: 80, color: Colors.green)),
                ),
                const SizedBox(height: 15),
                signUp(context),
                const SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.gps_off_outlined),
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
                const SizedBox(height: 70),
                Align(alignment: Alignment.bottomCenter, child: Image.asset('assets/images/design.png', fit: BoxFit.cover)),
              ]),
            ]),
          ),
        ));
  }

  SizedBox signUp(BuildContext context) {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.2,
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34A853), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: Text("Sign Up", style: AppStyles.text18PxSemiBold)));
  }

  SizedBox confirmPassword(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
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

  SizedBox password(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: TextField(
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
      child: TextField(
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
