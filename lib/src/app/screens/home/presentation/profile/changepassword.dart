import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

void changepassword(BuildContext context) {
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  GlobalKey<FormState> updatePassKey = GlobalKey<FormState>();

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
            height: MediaQuery.of(context).size.height / 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Form(
                key: updatePassKey,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Update Password", style: AppStyles.text20PxBold),
                              Flexible(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close))),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              controller: oldPass,
                              validator: (val) {
                                if (!ExtString.validatePassword(val!)) return " Enter a valid password";
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Old Password',
                                prefixIcon: const Icon(Icons.key, size: 20),
                                filled: true,
                                hintStyle: AppStyles.text16Px.textGrey,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              controller: oldPass,
                              validator: (val) {
                                if (!ExtString.validatePassword(val!)) return "Password length should be greater than 8";
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                prefixIcon: const Icon(Icons.key, size: 20),
                                filled: true,
                                hintStyle: AppStyles.text16Px.textGrey,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              controller: oldPass,
                              validator: (value) {
                                if (value != newPass.text) {
                                  return "Password does'nt match";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                prefixIcon: const Icon(Icons.key, size: 20),
                                filled: true,
                                hintStyle: AppStyles.text16Px.textGrey,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(children: [
                            const SizedBox(width: 10),
                            Expanded(
                                child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (updatePassKey.currentState!.validate()) {}
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
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                                  child: const Text('Click me')),
                            )),
                            const SizedBox(width: 10)
                          ])
                        ]),
                      ),
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}
