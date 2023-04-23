import 'package:flutter/material.dart';

abstract class ScreenSize {

  static returnHeight(context){

  return MediaQuery.of(context).size.height;
  }

  static returnWidth(context){

  return MediaQuery.of(context).size.width;
  }
}
