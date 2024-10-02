import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/shared_components/default_text_form_field.dart';

class FormFieldPaymentMethod extends StatelessWidget {
  const FormFieldPaymentMethod({
    super.key,
    this.validator,
    required this.controller,
    this.textInputType,
    this.mandatory = true,
  });
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool mandatory;

  @override
  Widget build(BuildContext context) {
    return DefaultTextFormField(
      validator: validator,
      controller: controller,
      textInputAction: TextInputAction.next,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.r,
          ),
        ),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
        ),
      
      ),
      
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 12.sp,
            height: 1,
          ),
      // suffixIcon: mandatory ? Text('*') : null,
      suffixIconConstraints: BoxConstraints(
        minHeight: 25.h,
        minWidth: 20.w,
      ),
      contentPaddingVertical: 0,
      cursorHeight: 10.h,
      textInputType: textInputType ?? TextInputType.text,
    );
  }
}
