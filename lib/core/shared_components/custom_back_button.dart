import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBackButton extends StatelessWidget {
  final dynamic onPressed;
  const CustomBackButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            Assets.imagesIconBackSquare,
            height: 20.h,
            color: AppColors.primaryColor,
          ),
        );
  }
}