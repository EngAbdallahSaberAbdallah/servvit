import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import 'package:echo/views/vendor/views/screens/vendor_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Functions {
  static String convertDateToString({required String date}) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    return formattedDate;
  }

  static String getNumberFormatFunc(dynamic number, {int convertAfter = 0}) {
    if (number == null) {
      return '0.0'; // Default value in case number is null
    }

    try {
      double parsedNumber = double.parse(number.toString());
      if (parsedNumber == parsedNumber.roundToDouble()) {
        // No decimal places
        return parsedNumber.toStringAsFixed(0);
      } else {
        // Has decimal places, format to 2 decimal places
        return parsedNumber.toStringAsFixed(2);
      }
    } catch (e) {
      return '0.0'; // Default value in case of parsing error
    }
  }

  static String getNumberWithTextFormatFunc(dynamic number,
      {int convertAfter = 0}) {
    if (number == null) {
      return '0.0'; // Default value in case number is null
    }

    try {
      double parsedNumber = double.parse(number.toString());
      String arabicSuffix;

      if (parsedNumber >= 1e18) {
        // 1,000,000,000,000,000,000 (Quintillion)
        double quintillions = parsedNumber / 1e18;
        arabicSuffix =
            quintillions == 1 ? "quintillion".tr() : "quintillions".tr();
        return '${quintillions.toStringAsFixed(quintillions == quintillions.roundToDouble() ? 0 : 1)} $arabicSuffix';
      } else if (parsedNumber >= 1e15) {
        // 1,000,000,000,000,000 (Quadrillion)
        double quadrillions = parsedNumber / 1e15;
        arabicSuffix =
            quadrillions == 1 ? "quadrillion".tr() : "quadrillions".tr();
        return '${quadrillions.toStringAsFixed(quadrillions == quadrillions.roundToDouble() ? 0 : 1)} $arabicSuffix';
      } else if (parsedNumber >= 1e12) {
        // 1,000,000,000,000 (Trillion)
        double trillions = parsedNumber / 1e12;
        arabicSuffix = trillions == 1 ? "trillion".tr() : "trillions".tr();
        return '${trillions.toStringAsFixed(trillions == trillions.roundToDouble() ? 0 : 1)} $arabicSuffix';
      } else if (parsedNumber >= 1e9) {
        // 1,000,000,000 (Billion)
        double billions = parsedNumber / 1e9;
        arabicSuffix = billions == 1 ? "billion".tr() : "billions".tr();
        return '${billions.toStringAsFixed(billions == billions.roundToDouble() ? 0 : 1)} $arabicSuffix';
      } else if (parsedNumber >= 1e6) {
        // 1,000,000 (Million)
        double millions = parsedNumber / 1e6;
        arabicSuffix = millions == 1 ? "million".tr() : "millions".tr();
        return '${millions.toStringAsFixed(millions == millions.roundToDouble() ? 0 : 1)} $arabicSuffix';
      } else if (parsedNumber >= 1000) {
        // 1,000 (Thousand)
        double thousands = parsedNumber / 1000;
        arabicSuffix = thousands == 1 ? "thousand".tr() : "thousands".tr();
        return '${thousands.toStringAsFixed(thousands == thousands.roundToDouble() ? 0 : 1)} $arabicSuffix';
      } else {
        // Numbers less than 1000
        if (parsedNumber == parsedNumber.roundToDouble()) {
          return parsedNumber.toStringAsFixed(0);
        } else {
          return parsedNumber.toStringAsFixed(2);
        }
      }
    } catch (e) {
      return '0.0'; // Default value in case of parsing error
    }
  }

  static void addToCart({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          title:
              Image.asset("assets/images/correct_success.png", height: 100.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: AppTextStyle.bodyText(),
                textAlign: TextAlign.center,
              ),
              if (VendorAddToCartCubit.get(context).selectedDesignStatus ==
                  'without')
                Text(
                  "added_to_cart".tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.subTitle(),
                ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: VendorAddToCartCubit.get(context).selectedDesignStatus ==
                  'without'
              ? [
                  DefaultButton(
                    text: 'go_to_cart'.tr(),
                    onPress: () {
                      Navigator.pop(context);
                      NavigationUtils.navigateReplacement(
                          context: context,
                          destinationScreen: VendorCartScreen());
                    },
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: 10.h),
                  DefaultButton(
                    text: 'follow_shopping'.tr(),
                    onPress: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    fontSize: 14.sp,
                  ),
                ]
              : [],
        );
      },
    );
  }
}
