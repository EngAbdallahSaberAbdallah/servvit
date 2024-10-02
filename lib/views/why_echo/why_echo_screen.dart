import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/text_styles/app_text_style.dart';

class WhyEchoScreen extends StatelessWidget {
  const WhyEchoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Image.asset(
          "assets/images/logo2.png",
          width: 100.w,
          height: 40.h,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Text(
              "WhyEcho".tr(),
              style: AppTextStyle.title(),
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/whyEcho${index + 1}.svg",
                        width: MediaQuery.of(context).size.width * .25,
                        color: index != 1 ? AppColors.primaryColor : null,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "whyEchoTitle${index + 1}".tr(),
                        style: AppTextStyle.title(),
                      ),
                      Text(
                        "whyEchoDescription${index + 1}".tr(),
                        style: AppTextStyle.bodyText(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              itemCount: 5,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
