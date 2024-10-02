import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/layout/main/main_layout.dart';
import 'package:echo/views/splash/components/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:echo/core/shared_components/custom_back_ground.dart';
import '../intro/intro_screen.dart';
import '../vendor/views/screens/bottom_navigation_screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 5000),
      () {
        NavigationUtils.navigateReplacement(
          context: context,
          destinationScreen: CacheKeysManger.getUserTokenFromCache() == ""
              ? IntroScreen()
              : CacheKeysManger.getUserTypeFromCache() == 'Buyer'
                  ? VendorMainScreen()
                  : MainLayout(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: 
      // Container(
      // width: double.infinity,
      // height: double.infinity,
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //         AppColors.greenLightColor,
      //         AppColors.secondaryColor,
      //         AppColors.primarySwatchColor.withOpacity(.3),
      //       ],
      //     ),),
      
      //   child: 
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/logo.png", color: Colors.white,),
                CustomSplashSlider(images: [
                  "assets/images/s1.png",
                  "assets/images/s2.png",
                  "assets/images/s3.png"
                ]),
                // Image.asset("assets/images/s1.png"),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(1.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.sp),
                      ),
                      child: LinearPercentIndicator(
                        barRadius: Radius.circular(30.sp),
                        curve: Curves.decelerate,
                        padding: EdgeInsets.zero,
                        animation: true,
                        lineHeight: 14.h,
                        backgroundColor: Colors.white,
                        animationDuration: 4000,
                        percent: 1,
                        progressColor: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "welcome".tr(),
                      style: AppTextStyle.headLine(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      // ),
    );
  }
}
