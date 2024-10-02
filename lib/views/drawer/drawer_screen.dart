import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/enums/image_type.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/profile_picture.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/layout/main/main_layout.dart';
import 'package:echo/views/intro/intro_screen.dart';
import 'package:echo/views/supplier/categories/categories_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(height: 10.h),
              Image.asset(
                "assets/images/logo2.png",
                width: 100.w,
                height: 40.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20.h),
              BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
                // print(
                //     "ggggggg:${AuthCubit.get(context).profileModel!.data!.image}"
                // .toString());
                return AuthCubit.get(context).profileModel == null
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (AuthCubit.get(context)
                                  .profileModel!
                                  .data!
                                  .image !=
                              null)
                            ProfilePicture(
                                imageType: ImageType.network,
                                size: 25.sp,
                                imageLink: EndPoints.suppliers +
                                    AuthCubit.get(context)
                                        .profileModel!
                                        .data!
                                        .image
                                        .toString()),
                          SizedBox(width: 10.w),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AuthCubit.get(context)
                                        .profileModel!
                                        .data!
                                        .name ??
                                    "",
                                style: AppTextStyle.title(),
                              ),
                              Text(
                                CacheKeysManger.getUserTypeFromCache()!,
                                style: AppTextStyle.bodyText(),
                              ),
                            ],
                          )),
                        ],
                      );
              }),
              SizedBox(height: 20.h),
              ListTile(
                onTap: () {
                  BottomNavbarCubit.get(context).changeBottomNavbar(1);
                  Scaffold.of(context).closeDrawer();
                },
                title: Text(
                  "my_market".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  "assets/images/my_market.png",
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  NavigationUtils.navigateTo(
                      context: context, destinationScreen: CategoriesScreen());
                },
                title: Text(
                  "add_product".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  "assets/images/products.png",
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  BottomNavbarCubit.get(context)
                      .changeBottomNavbar(2, orderTab: true);
                  Scaffold.of(context).closeDrawer();
                },
                title: Text(
                  "orders".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Icon(
                  CupertinoIcons.cart_fill_badge_plus,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  BottomNavbarCubit.get(context).changeBottomNavbar(
                    2,
                  );
                  Scaffold.of(context).closeDrawer();
                },
                title: Text(
                  "profile".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Icon(
                  CupertinoIcons.person_fill,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () async {
                  await BottomNavbarCubit.get(context).changeLang(context);
                  if (BottomNavbarCubit.get(context).currentIndex != 0) {
                    BottomNavbarCubit.get(context).changeBottomNavbar(0);
                  }
                  NavigationUtils.navigateReplacement(
                      context: context, destinationScreen: MainLayout());
                },
                title: Text(
                  "lang".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Icon(
                  Icons.language,
                  color: AppColors.primaryColor,
                ),
              ),
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {
                  if (state is LogoutSuccessState) {
                    NavigationUtils.navigateAndClearStack(
                        context: context, destinationScreen: IntroScreen());
                  }
                },
                builder: (context, state) => state is LogoutLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : ListTile(
                        onTap: () {
                          BottomNavbarCubit.get(context).changeBottomNavbar(0);
                          AuthCubit.get(context).logout();
                        },
                        title: Text(
                          "logout".tr(),
                          style: AppTextStyle.title().copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: AppColors.primaryColor,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
