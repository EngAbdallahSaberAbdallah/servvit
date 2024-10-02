import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_helper.dart';
import 'package:echo/core/shared_components/custom_back_ground.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../vendor/views/screens/bottom_navigation_screens/main_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBg(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                // Image.asset(Assets.imagesLogo),
                // Image.asset(
                //   "assets/images/background_signup.png",
                //   fit: BoxFit.cover,
                // ),
                SizedBox(height: 50.h),
                Center(
                  child: DefaultButton(
                    onPress: () {
                      NavigationUtils.navigateTo(
                          context: context, destinationScreen: LoginScreen());
                      CacheHelper.saveData(key: "type", value: "Supplier");
                    },
                    text: "supplier".tr(),
                    borderRadius: 30.sp,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ),
                ),
                SizedBox(height: 30.h),
                DefaultButton(
                  onPress: () {
                    //todo navigate to main directly
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VendorMainScreen()));

                    // NavigationUtils.navigateTo(
                    //     context: context, destinationScreen: LoginScreen());

                    CacheHelper.saveData(key: "type", value: "Buyer");
                  },
                  text: "buyer".tr(),
                  borderRadius: 30.sp,
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
