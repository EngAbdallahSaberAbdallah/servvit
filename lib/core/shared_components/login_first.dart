import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../views/auth/login_screen.dart';
import '../colors/app_colors.dart';
import '../utils/navigation_utility.dart';
import 'default_button.dart';

Future defaultLogin({
  required BuildContext context,
}) =>
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("login".tr(), textAlign: TextAlign.center,
                style: AppTextStyle.title(),),
              content: Text(
                "login_message".tr(), style: AppTextStyle.bodyText(),),
              actions: [

                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(onPress: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (context) => LoginScreen()), (
                            route) => false);
                      },
                        text: "login".tr(),
                        backgroundColor: AppColors.primaryColor,
                        fontSize: 12.sp,),
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(child: DefaultButton(onPress: () {
                      Navigator.pop(context);
                    },
                      text: "cancel".tr(),
                      backgroundColor: AppColors.secondaryColor,
                      fontSize: 12.sp,)),

                  ],
                ),


              ],
            ));
