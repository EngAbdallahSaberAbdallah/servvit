import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_text_form_field.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:echo/views/auth/register_screen.dart';
import 'package:echo/views/vendor/views/screens/bottom_navigation_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/colors/app_colors.dart';
import '../../core/services/local/cache_helper/cache_helper.dart';
import '../../core/services/local/cache_helper/cache_keys.dart';
import '../../cubits/all_bannares/all_banners_cubit.dart';
import '../../layout/main/main_layout.dart';
import '../intro/intro_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    log('build_pressed_text_field');
    AuthCubit.get(context).getGovernorates();
    AuthCubit.get(context).getBusinessTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Image.asset(
                  //   "assets/images/background_signup.png",
                  //   fit: BoxFit.cover,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     
                      Align(
                        alignment: Alignment.topLeft,
                        child: PopupMenuButton<String>(
                          icon: Icon(
                            Icons.language,
                            color: AppColors.primaryColor,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          initialValue: context.locale == Locale('ar')
                              ? 'العربية'
                              : 'English',
                          onSelected: (lang) async {
                            CacheHelper.saveData(key: 'lang', value: lang);
                            context.setLocale(Locale(lang));
                            AuthCubit.get(context).getGovernorates();
                            AuthCubit.get(context).getBusinessTypes();
                          },
                          itemBuilder: ((context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem(
                                  value: "ar", child: Text('العربية')),
                              PopupMenuItem(value: "en", child: Text('English'))
                            ];
                          }),
                        ),
                      ),
                      
                    ],
                  ),
                  
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: IconButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          // SystemNavigator.pop();
                          NavigationUtils.navigateAndClearStack(
                              context: context,
                              destinationScreen: IntroScreen());
                        }
                      },
                      icon: SvgPicture.asset(
                        Assets.imagesIconBackSquare,
                        height: 20.h,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

               Image.asset(
                          "assets/images/logo.png",
                          height: 100.h,
                          color: AppColors.primaryColor,
                        ),
                      
              SizedBox(height: 20.h),
              Text(
                "login_title".tr(),
                style: AppTextStyle.headLine().copyWith(fontSize: 20),
              ),
              SizedBox(height: 20.h),
              Form(
                key: formKey,
                child: DefaultTextFormField(
                  textInputType: TextInputType.phone,
                  controller: phoneController,
                  fillColor: Colors.white,
                  isFilled: true,
                  hintText: "phone_hint".tr(),
                  style: AppTextStyle.title(),
                  validationMsg: "phone_validation_hint".tr(),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 10.w),
                      Image.asset(
                        "assets/images/egypt.png",
                        width: 30.w,
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        height: 25.h,
                        width: 1.w,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "login_activate_hint".tr(),
                style: AppTextStyle.bodyText(),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      toast(text: state.message, color: Colors.green);

                      /// old code
                      // NavigationUtils.navigateTo(
                      //     context: context,
                      //     destinationScreen: OtpScreen(
                      //       phone: phoneController.text,
                      //     ));

                      /// for test only and will return the old code don't forget
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
                  builder: (context, state) => state is LoginLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : DefaultButton(
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              AuthCubit.get(context).login(
                                phone: phoneController.text,
                                context: context,
                              );
                            }
                          },
                          text: "next_btn".tr()),
                ),
              ),
              SizedBox(height: 20.h),
              // CacheKeysManger.getUserTypeFromCache() == "Supplier"
              //     ? SizedBox()
              //     : Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 20.w),
              //         child: DefaultButton(
              //             onPress: () {
              //               Navigator.pushReplacement(
              //                   context, MaterialPageRoute(builder: (context) => VendorMainScreen()));
              //             },
              //             text: "guest_btn".tr()),
              //       ),
              // SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "signup_question".tr(),
                    style: AppTextStyle.bodyText(),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationUtils.navigateTo(
                          context: context,
                          destinationScreen: RegisterScreen());
                    },
                    child: Text("signup".tr(), style: AppTextStyle.bodyText().copyWith(fontWeight: FontWeight.w500).copyWith(color: AppColors.primaryColor)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
