import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

class DefaultDropdown extends StatelessWidget {
  DefaultDropdown({
    Key? key,
    required this.value,
    required this.hintText,
    required this.list,
    required this.onChange,
    this.textStyle,
  }) : super(key: key);
  List<String> list;
  String hintText;
  String? value;
  TextStyle? textStyle;
  void Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton2(
            value: value,
            hint: Text(
              hintText,
              style: textStyle ?? Theme.of(context).textTheme.titleMedium,
            ),
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              size: 30.r,
              color: AppColors.primaryColor,
            ),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey.shade100,
            ),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey.shade100,
            ),
            isExpanded: true,
            buttonHeight: 50.h,
            buttonWidth: double.infinity,
            dropdownWidth: 160.w,
            buttonPadding: EdgeInsets.symmetric(horizontal: 10.w),
            dropdownPadding: EdgeInsets.symmetric(horizontal: 10.w),
            dropdownElevation: 8,
            scrollbarRadius: Radius.circular(40.r),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            items: List.generate(
                list.length,
                (index) => DropdownMenuItem(
                    value: list[index],
                    child: Text(
                      list[index],
                      style: textStyle ?? Theme.of(context).textTheme.bodyLarge,
                    ))),
            onChanged: onChange));
  }
}
