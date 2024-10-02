import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

ThemeData themeDataLight = ThemeData(
  primarySwatch: AppColors.primaryColor,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  indicatorColor: AppColors.primaryColor,
  tabBarTheme: TabBarTheme(indicatorColor: AppColors.primaryColor),
  progressIndicatorTheme:
      ProgressIndicatorThemeData(color: AppColors.primaryColor),
  iconTheme: const IconThemeData(
    color: Colors.grey,
  ),
  appBarTheme: appBarTheme(),
  bottomNavigationBarTheme: bottomNavigationBarTheme(),
  dividerColor: Colors.grey.shade300,
  fontFamily: CacheKeysManger.getLanguageFromCache()=="ar"?"Tajawal":GoogleFonts.montserrat().fontFamily,
  textTheme: textThem(),
);

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    foregroundColor: AppColors.primarySwatchColor,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontFamily: CacheKeysManger.getLanguageFromCache()=="ar"?"Tajawal":GoogleFonts.montserrat().fontFamily,
      color: Colors.white,
      fontSize: 18.0.sp,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
    iconTheme: IconThemeData(
      color: AppColors.primarySwatchColor,
    ),
  );
}

BottomNavigationBarThemeData bottomNavigationBarTheme() {
  return BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primaryColor,
    elevation: 1.0,
    selectedLabelStyle: TextStyle(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w800,
      color: AppColors.primarySwatchColor,
      fontFamily: CacheKeysManger.getLanguageFromCache()=="ar"?"Tajawal":GoogleFonts.montserrat().fontFamily,

    ),
    unselectedItemColor: Colors.grey,
  );
}

TextTheme textThem() {
  return TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.primarySwatchColor,
      fontFamily: CacheKeysManger.getLanguageFromCache()=="ar"?"Tajawal":GoogleFonts.montserrat().fontFamily,

    ),
    bodyMedium: TextStyle(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.primarySwatchColor,
      fontFamily: CacheKeysManger.getLanguageFromCache()=="ar"?"Tajawal":GoogleFonts.montserrat().fontFamily,

    ),
    bodySmall: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.primarySwatchColor,
      fontFamily: CacheKeysManger.getLanguageFromCache()=="ar"?"Tajawal":GoogleFonts.montserrat().fontFamily,

    ),
  );
}
