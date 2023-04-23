import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

extension TypographyExtension on TextStyle {
  //colors
  TextStyle get primary => copyWith(color: AppColors.primary);

  TextStyle get textDark => copyWith(color: AppColors.textDark);

  TextStyle get textBlue => copyWith(color: AppColors.textBlue);

  TextStyle get textLight => copyWith(color: AppColors.textLight);

  TextStyle get textGrey => copyWith(color: AppColors.textGrey);

  TextStyle get statusRed => copyWith(color: AppColors.statusRed);

  TextStyle get statusGreen => copyWith(color: AppColors.statusGreen);

  TextStyle get statusLightRed => copyWith(color: AppColors.statusLightRed);

  TextStyle get brandBackground => copyWith(color: AppColors.brandBackground);
  TextStyle get brandBackgroundLight => copyWith(color: AppColors.brandBackgroundLight);

  TextStyle get white => copyWith(color: AppColors.white);

  TextStyle get black => copyWith(color: AppColors.black);

  //line height
  TextStyle lineHeight(double px) => copyWith(height: AppStyles.calculateHeight(px, fontSize!));

  // letter spacing
  TextStyle spacing(double em) => copyWith(height: AppStyles.calculateSpacing(em));
}
