import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/utils/assets.dart';

class ConditionsScreen extends StatelessWidget {
  const ConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> termsTitles = [
      "terms_title1".tr(),
      "terms_title2".tr(),
      "terms_title3".tr(),
      "terms_title4".tr(),
      "terms_title5".tr(),
      "terms_title6".tr(),
      "terms_title7".tr(),
      "terms_title8".tr(),
      "terms_title9".tr(),
      "terms_title10".tr(),
      "terms_title11".tr(),
      "terms_title12".tr(),
      "terms_title13".tr(),
    ];

    List<String> termsBody = [
      "terms_body1".tr(),
      "terms_body2".tr(),
      "terms_body3".tr(),
      "terms_body4".tr(),
      "terms_body5".tr(),
      "terms_body6".tr(),
      "terms_body7".tr(),
      "terms_body8".tr(),
      "terms_body9".tr(),
      "terms_body10".tr(),
      "terms_body11".tr(),
      "terms_body12".tr(),
      "terms_body13".tr(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.h,
        title: Image.asset(
          Assets.imagesLogo2,
          width: 100.w,
          height: 40.h,
          fit: BoxFit.contain,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            Assets.imagesIconBackSquare,
            height: 20.h,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Image.asset(
            Assets.imagesAboutUsImage,
            height: 150.h,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10.h),
          Center(
            child: Text('conditions'.tr(),
                style: AppTextStyle.title().copyWith(fontSize: 20.sp)),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(termsTitles[index],
                              style: AppTextStyle.headLine()
                                  .copyWith(fontSize: 18.sp)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.3),
                            child: Divider(
                              thickness: 3,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(termsBody[index],
                              textAlign: TextAlign.justify,
                              style: AppTextStyle.bodyText()),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                itemCount: termsTitles.length),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
