import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

class DefaultButton extends StatelessWidget {
  void Function()? onPress;
  String text;
  Widget? icon;
  double? borderRadius;
  double? height;
  double? fontSize;
  Color? backgroundColor;
  Color? textColor;
  bool hasBorder;
  final FontWeight? fontWeight;

  DefaultButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.icon,
    this.borderRadius,
    this.height,
    this.fontSize,
    this.backgroundColor,
    this.textColor,
    this.hasBorder = false,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        padding: EdgeInsets.symmetric(vertical: height ?? 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        ),
      ),
      onPressed: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SizedBox(
              width: 10.w,
            ),
            icon!,
            SizedBox(
              width: 3.w,
            ),
          ],
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyle.title().copyWith(
                color: textColor ?? Colors.white,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: fontSize ?? 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
