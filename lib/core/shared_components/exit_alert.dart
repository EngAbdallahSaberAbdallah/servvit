import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void exitDialog(context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("exit".tr(),style: AppTextStyle.title()),
            content: Text("exit_title".tr(),style: AppTextStyle.title(),),
            actions: [
              TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text("yes".tr(), style: AppTextStyle.title().copyWith(fontSize: 11.sp,),)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "cancel".tr(),
                    style:  AppTextStyle.title().copyWith(fontSize: 11.sp,color: Colors.grey),
                  )),
            ],
          ));
}
