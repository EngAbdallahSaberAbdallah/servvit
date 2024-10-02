import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/utils/assets.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> shippingTitles = [
      "shipping_title1".tr(),
      "shipping_title2".tr(),
      "shipping_title3".tr(),
      "shipping_title4".tr(),
      "shipping_title5".tr(),
      "shipping_title6".tr(),
      "shipping_title7".tr(),
    ];

    List<String> shippingBody = [
      "shipping_body1".tr(),
      "shipping_body2".tr(),
      "shipping_body3".tr(),
      "shipping_body4".tr(),
      "shipping_body5".tr(),
      "shipping_body6".tr(),
      "shipping_body7".tr(),
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
            child: Text('shipping'.tr(),
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
                          Text(shippingTitles[index],
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
                          Text(shippingBody[index],
                              textAlign: TextAlign.justify,
                              style: AppTextStyle.bodyText()),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                itemCount: shippingTitles.length),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
