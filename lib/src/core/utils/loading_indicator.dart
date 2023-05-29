import 'package:flutter/material.dart';

Widget loadingIndicator(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height / 2.5,
    child: Center(
        child: Image.asset(
      "assets/images/paurakhi.gif",
      height: 80,
      width: 80,
      fit: BoxFit.fill,
    )),
  );
}
