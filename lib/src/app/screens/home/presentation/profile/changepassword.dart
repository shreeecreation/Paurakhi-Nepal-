import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

void changepassword(BuildContext context) {
// modal bottom sheet go up with the keyboard appears
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFFFCFCFC),
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
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0x0fffffff),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, size: 20),
                              hintText: "Old Password",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 16,
                                height: 2.2, // adjust this value to center the hint text vertically
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0x0fffffff),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 16,
                                height: 2.2, // adjust this value to center the hint text vertically
                              ),
                              prefixIcon: Icon(Icons.key, size: 20),
                              hintText: "New Password",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0x0fffffff),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.key, size: 20),
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                height: 2.2, // adjust this value to center the hint text vertically
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
      );
    },
  );
}
