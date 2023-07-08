// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paurakhi/src/app/screens/auth/register/register.dart';
import 'package:paurakhi/src/app/screens/home/presentation/profile/bloc/profile_bloc.dart';
import 'package:paurakhi/src/core/API/upload%20profile%20picture/upload_profile_picture.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

Future<Object?> chooseProfie(BuildContext context) {
  File? image;

  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dismissOnTouchOutside: false,
    headerAnimationLoop: false,
    dialogType: DialogType.info,
    bodyHeaderDistance: 50,
    // customHeader: const Icon(Icons.done),
    showCloseIcon: false,
    title: 'Choose',
    titleTextStyle: AppStyles.text20PxSemiBold,
    descTextStyle: AppStyles.text16Px,
    desc: 'Choose Profile picture',
    body: Column(children: [
      const SizedBox(
        height: 30,
      ),
      Text("Choose Profile picture", style: AppStyles.text16Px),
      const SizedBox(
        height: 30,
      ),
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
                image = img;

                UploadProfilePicture.upoadPicture(img, context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            // ignore: unnecessary_null_comparison
            child: image != null
                ? CircleAvatar(
                    backgroundImage: FileImage(image),
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
    ]),

    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
  ).show();
}

Future<Object?> successEditProfile(BuildContext context) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dismissOnTouchOutside: false,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    bodyHeaderDistance: 30,
    // customHeader: const Icon(Icons.done),
    showCloseIcon: false,
    title: 'Succes',
    titleTextStyle: AppStyles.text20PxSemiBold,
    descTextStyle: AppStyles.text16Px,
    desc: 'Profile Picture Uploaded Successfully \n ',
    btnOkOnPress: () async {
      await GetUserInfo.getUserInfo();

      Navigator.pop(context);
      BlocProvider.of<ProfileBloc>(context).add(ProfileLoadEvent());
    },
    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
  ).show();
}
