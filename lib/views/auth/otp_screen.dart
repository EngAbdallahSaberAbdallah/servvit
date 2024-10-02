import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/custom_back_ground.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/all_bannares/all_banners_cubit.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:echo/layout/main/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/services/local/cache_helper/cache_keys.dart';
import '../../core/utils/assets.dart';
import '../vendor/views/screens/bottom_navigation_screens/main_screen.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key, required this.phone}) : super(key: key);

  final String phone;

  var codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomBg(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(
                        Assets.imagesIconBackSquare,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Image.asset(
                  "assets/images/logo.png",
                  height: 100.h,
                ),
                SizedBox(height: 60.h),
                Text(
                  "otp_code".tr(),
                  style: AppTextStyle.headLine(),
                ),
                SizedBox(height: 30.h),
                Form(
                  key: formKey,
                  child: PinCodeTextField(
                    length: 6,
                    appContext: context,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10.r),
                        fieldHeight: 50.h,
                        fieldWidth: 50.w,
                        activeFillColor: Colors.white,
                        inactiveColor: Colors.grey.shade300,
                        inactiveFillColor: Colors.white,
                        activeColor: AppColors.primaryColor,
                        selectedFillColor: Colors.white,
                        selectedColor: AppColors.primaryColor),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,

                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "field_req".tr();
                      }
                      return null;
                    },
                    controller: codeController,
                    onCompleted: (v) {
                      debugPrint("Completed");
                      AuthCubit.get(context).sendOtp(
                        phone: phone,
                        code: codeController.text,
                        context: context,
                      );
                    },
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "enter_number".tr()+"\n${phone}",
                  style: AppTextStyle.bodyText(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 80.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: BlocConsumer<AuthCubit, AuthStates>(
                    listener: (context, state) {
                      if (state is SendOtpSuccessState) {
                        toast(text: state.message, color: Colors.green);
                        AuthCubit.get(context).getProfileData();
                        AllBannersCubit.get(context).getAllBanners();

                        ///TODO here will pase the VendorMainScreen
                        CacheKeysManger.getUserTypeFromCache() == 'Buyer'
                            ? NavigationUtils.navigateAndClearStack(
                                context: context,
                                destinationScreen: VendorMainScreen())
                            : NavigationUtils.navigateAndClearStack(
                                context: context,
                                destinationScreen: MainLayout());
                      }
                    },
                    builder: (context, state) => state is SendOtpLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : DefaultButton(
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                AuthCubit.get(context).sendOtp(
                                  phone: phone,
                                  code: codeController.text,
                                  context: context,
                                );
                              }
                            },
                            text: "next_btn".tr()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
