import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/utils/assets.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: Text('about_title'.tr(),
                        style: AppTextStyle.title().copyWith(fontSize: 18.sp)),
                  ),
                  // SizedBox(height: 20.h),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 15.w),
                  //   child: Text('about_desc'.tr(),
                  //       textAlign: TextAlign.justify,
                  //       style: AppTextStyle.bodyText()),
                  // ),
                  // SizedBox(height: 10.h),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 80.w),
                  //   child: Divider(
                  //     thickness: 3,
                  //     color: AppColors.primaryColor,
                  //   ),
                  // ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text("about1".tr(),
                        textAlign: TextAlign.justify,
                        style: AppTextStyle.bodyText()),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: Divider(
                      thickness: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text("about2".tr(),
                        textAlign: TextAlign.justify,
                        style: AppTextStyle.bodyText()),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: Divider(
                      thickness: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text("about3".tr(),
                        textAlign: TextAlign.justify,
                        style: AppTextStyle.bodyText()),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: Divider(
                      thickness: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text("about4".tr(),
                        textAlign: TextAlign.justify,
                        style: AppTextStyle.bodyText()),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: Divider(
                      thickness: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text("about5".tr(),
                        textAlign: TextAlign.justify,
                        style: AppTextStyle.bodyText()),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: Divider(
                      thickness: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text("about6".tr(),
                        textAlign: TextAlign.justify,
                        style: AppTextStyle.bodyText()),
                  ),
                  SizedBox(
                    height: 40.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
