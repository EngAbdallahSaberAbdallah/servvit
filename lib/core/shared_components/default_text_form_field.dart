import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';

class DefaultTextFormField extends StatefulWidget {
  int? maxLength;
  int? maxLines;
  bool isEnabled;
  bool required;
  bool isPassword;
  bool isFilled;
  bool hasBorder;
  bool autoFocus;
  bool readOnly;
  double contentPaddingVertical;
  double contentPaddingHorizontal;
  double borderRadius;
  double borderSideWidth;
  Color enabledBorderRadiusColor;
  String? validationMsg;
  TextInputType textInputType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Function? onPressSuffixIcon;
  Function(String)? onFilledSubmit;
  Function(String)? onChange;
  Function? validation;
  Function? onTap;
  String? labelText;
  String? hintText;
  TextEditingController controller;
  Color? fillColor;
  TextStyle? style;
  FocusNode? focusNode;
  String? suffixText;
  BoxConstraints? suffixIconConstraints;
  InputBorder? enabledBorder;
  double? cursorHeight;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  DefaultTextFormField({
    Key? key,
    this.isPassword = false,
    this.autoFocus = false,
    this.readOnly = false,
    this.isFilled = false,
    this.hasBorder = true,
    this.required = true,
    this.isEnabled = true,
    this.borderSideWidth = 1.0,
    this.contentPaddingHorizontal = 10.0,
    this.contentPaddingVertical = 10.0,
    this.borderRadius = 10,
    this.enabledBorderRadiusColor = Colors.grey,
    this.maxLength,
    this.maxLines,
    this.labelText,
    this.hintText,
    required this.textInputType,
    required this.controller,
    this.onFilledSubmit,
    this.onChange,
    this.onTap,
    this.onPressSuffixIcon,
    this.validation,
    this.suffixIcon,
    this.prefixIcon,
    this.validationMsg,
    this.style,
    this.fillColor,
    this.focusNode,
    this.suffixText,
    this.suffixIconConstraints,
    this.enabledBorder,
    this.cursorHeight,
    this.validator,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late FocusNode myFocusNode;
  bool hidePassword = true;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      cursorHeight: widget.cursorHeight,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      style: widget.style ?? AppTextStyle.bodyText(),
      textAlign: TextAlign.start,
      readOnly: widget.readOnly,
      obscureText: widget.isPassword && hidePassword,
      focusNode: widget.focusNode ?? myFocusNode,
      autofocus: widget.autoFocus,
      enabled: widget.isEnabled,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      onFieldSubmitted: (value) {
        if (widget.onFilledSubmit != null) {
          widget.onFilledSubmit!(value);
        }
      },
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      validator: widget.validator ??
          (String? value) {
            if (widget.validation != null) {
              return widget.validation!(value);
            } else if (value!.isEmpty && widget.required) {
              return widget.validationMsg;
            } else {
              return null;
            }
          },
      decoration: InputDecoration(
        suffixIconConstraints: widget.suffixIconConstraints,
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.contentPaddingVertical.h,
          horizontal: widget.contentPaddingHorizontal.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.borderRadius.r,
            ),
          ),
          borderSide: (!widget.hasBorder)
              ? BorderSide.none
              : BorderSide(
                  color: AppColors.primaryColor,
                  width: widget.borderSideWidth,
                ),
        ),
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  widget.borderRadius.r,
                ),
              ),
              borderSide: (!widget.hasBorder)
                  ? BorderSide.none
                  : BorderSide(
                      color: Colors.grey.shade300,
                      width: widget.borderSideWidth,
                    ),
            ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  widget.borderRadius.r,
                ),
              ),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: widget.borderSideWidth,
              ),
            ),
            hintStyle: AppTextStyle.bodyText().copyWith(fontSize: 11.sp),
        filled: widget.isFilled,
        fillColor: widget.fillColor ?? Colors.grey.shade100,
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorMaxLines: 2,
        labelStyle: TextStyle(
          color: myFocusNode.hasFocus ? AppColors.primaryColor : Colors.grey,
        ),
        suffixText: widget.suffixText,
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: myFocusNode.hasFocus
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                  )
                : null),
        prefixIcon: widget.prefixIcon,
      ),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }
}
