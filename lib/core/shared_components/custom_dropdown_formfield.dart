import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownButton extends StatelessWidget {
  CustomDropDownButton({
    required this.hintText,
    required this.onChanged,
    required this.items,
    super.key,
    required this.validator,
    this.onTap,
    this.height,
    this.valueTextStyle,
    this.borderRadius,
    this.isFilled,
    this.hasBorder = true,
    this.firstValue,
  });

  final List<String>? items;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final String hintText;
  final double? height;
  final TextStyle? valueTextStyle;
  final BorderRadius? borderRadius;
  final bool? isFilled;
  final bool hasBorder;
  final String? firstValue;

  @override
  Widget build(BuildContext context) {
    // Set the value to the first item of the list if firstValue is not provided
    final defaultValue = firstValue ?? (items != null && items!.isNotEmpty ? items![0] : null);

    return DropdownButtonFormField2(
      value: defaultValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      buttonHeight: height ?? 35.h,
      dropdownMaxHeight: 500.h,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.white,
        filled: isFilled ?? true,
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(5.r),
          borderSide: !hasBorder
              ? BorderSide.none
              : BorderSide(
                  color: AppColors.primaryColor,
                ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: valueTextStyle ??AppTextStyle.bodyText().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w400),
      ),
      items: items!
          .map((item) => DropdownMenuItem<String>(
                onTap: onTap,
                value: item,
                child: Text(
                  item.toString(),
                  style: valueTextStyle ?? AppTextStyle.bodyText().copyWith(fontWeight: FontWeight.w400),
                ),
              ))
          .toList(),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
