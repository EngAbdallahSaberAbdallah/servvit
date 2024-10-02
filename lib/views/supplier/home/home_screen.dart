import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/views/supplier/categories/categories_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().getProfileData();
    return BlocBuilder<BottomNavbarCubit, BottomNavbarState>(
        builder: (context, state) => context.read<BottomNavbarCubit>().counterHomeScreen == 0 ?Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "welcome_title".tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.headLine().copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 24.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 120.h,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Align(
                      child: SizedBox(
                        height: 100.h,
                        child: CircleAvatar(
                          radius: 70.sp,
                          backgroundColor: AppColors.primaryColor,
                        ),
                      ),
                      alignment: AlignmentDirectional.bottomCenter,
                    ),
                    Image.asset(
                      "assets/images/person.png",
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          child: DefaultButton(
            onPress: () {
              // NavigationUtils.navigateAndClearStack(
              //   context: context,
              //   destinationScreen: CategoriesScreen(),
              // );
             setState(() {
               context.read<BottomNavbarCubit>().counterHomeScreen = 1;
             });
            },
            text: "add_product".tr(),
          ),
        ),
      ],
    ):CategoriesScreen());
  }
}
