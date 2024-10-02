
import 'package:echo/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle headLine() => TextStyle(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: "Tajawal",
  );

  static TextStyle appBarText() => TextStyle(
    color: Colors.black,
    fontSize: 20.0.sp,
    fontWeight: FontWeight.bold,
    fontFamily: "Tajawal",
  );
  static TextStyle title() => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: "Tajawal",
    height: 1.2.h,
  );
  static TextStyle bodyText() => TextStyle(
    fontSize: 15.0.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: "Tajawal",
  );
  static TextStyle subTitle() => TextStyle(
    fontSize: 14.0.sp,
    color: Colors.grey,
    height: 1.0.h,
    fontWeight: FontWeight.normal,
    fontFamily: "Tajawal",
  );
}