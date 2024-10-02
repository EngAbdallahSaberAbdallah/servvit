import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';
import 'dimensions.dart';

class CustomStyle {
  static var textStyle = GoogleFonts.tajawal(
      color: AppColors.greyColor, fontSize: Dimensions.defaultTextSize);
  static var hintTextStyle = GoogleFonts.tajawal(
      color: Colors.grey.withOpacity(0.5),
      fontSize: Dimensions.defaultTextSize);

  static var listStyle = GoogleFonts.tajawal(
      color: AppColors.redDarkColor, fontSize: Dimensions.defaultTextSize);

  static var defaultStyle = GoogleFonts.tajawal(
    color: Colors.black,
    fontSize: Dimensions.largeTextSize,
  );

  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
  );
  static var searchBox = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
  );
  static TextStyle headLine = GoogleFonts.tajawal(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static TextStyle subTitle = GoogleFonts.tajawal(
    fontSize: 15.0.sp,
    fontWeight: FontWeight.w200,
    height: 1.1,
    color: Colors.grey,
  );
  static TextStyle appBarText = GoogleFonts.tajawal(
    fontSize: 22.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColor,
  );
  static TextStyle title = GoogleFonts.tajawal(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}
