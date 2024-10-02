import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/enums/image_type.dart';
import '../../../../../core/services/local/cache_helper/cache_keys.dart';
import '../../../../../core/services/remote/dio/end_points.dart';
import '../../../../../core/shared_components/profile_picture.dart';
import '../../../../../cubits/bottom_navbar/bottom_navbar_cubit.dart';
import '../../../../../cubits/vendor_profile/vendor_profile_cubit.dart';
import '../vendor_profile_tab_view/notififcation_tab_view.dart';
import '../vendor_profile_tab_view/orders_tab_view.dart';
import '../vendor_profile_tab_view/settings_tab_view.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({Key? key}) : super(key: key);

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward(from: 0);

    AuthCubit.get(context).getGovernorates();
    AuthCubit.get(context).getBusinessTypes();
    AuthCubit.get(context).getProfileData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    if (BottomNavbarCubit.get(context).orderTab) {
      _tabController.animateTo(1);
      BottomNavbarCubit.get(context).orderTab = false;
    }
    if (BottomNavbarCubit.get(context).profileTab) {
      _tabController.animateTo(2);
      BottomNavbarCubit.get(context).profileTab = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    log('${CacheKeysManger.getUserTokenFromCache()}');
    // log('${AuthCubit.get(context).profileModel!.data}');
    var previousDragDirection = 'Down';
    var cubit = AuthCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<VendorProfileCubit, VendorProfileState>(
            builder: (context, state) {
              // if (state is VendorProfileNotFullScreen) {
              //   _animationController.forward(from: 0);
              // }
              // if (state is VendorProfileFullScreen) {
              //   _animationController.reverse(from: 1);
              // }
              return SizeTransition(
                sizeFactor: _animationController,
                child: Center(
                  child: BlocBuilder<AuthCubit, AuthStates>(
                    builder: (context, state) {
                      if (state is UpdateProfileLoadingState ||
                          state is SuccessPickImage) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ProfilePicture(
                        imageType: ImageType.network,
                        imageLink:
                            (AuthCubit.get(context).profileModel != null &&
                                    AuthCubit.get(context).profileModel!.data !=
                                        null &&
                                    AuthCubit.get(context)
                                            .profileModel!
                                            .data!
                                            .image !=
                                        null)
                                ? EndPoints.clients +
                                    AuthCubit.get(context)
                                        .profileModel!
                                        .data!
                                        .image!
                                : null,
                        hasEdit: true,
                        onTap: () {
                          cubit.pickProfileImage();
                        },
                        size: 50.r,
                      );
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10.h),
          TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.sp),
              ),
              tabs: [
                Tab(text: "notification".tr()),
                Tab(text: "orders".tr()),
                // Tab(text: "requests".tr()),
                Tab(text: "account".tr()),
              ]),
          SizedBox(height: 15.h),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                var dragDirection = details.delta.dy > 0 ? 'Down' : 'Up';
                if (dragDirection == 'Down' && previousDragDirection == 'Up') {
                  _animationController.forward(from: 0);
                } else if (dragDirection == 'Up' &&
                    previousDragDirection == 'Down') {
                  _animationController.reverse(from: 1);
                }
                previousDragDirection = dragDirection;
              },
              child: TabBarView(
                controller: _tabController,
                children: [
                  NotificationTabView(),
                  OrdersTabView(),
                  // RequestsTabView(),
                  BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
                    return state is GetProfileDataLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : state is GetProfileDataErrorState
                            ? CustomErrorWidget(onTap: () {
                                AuthCubit.get(context).getProfileData();
                              })
                            : SettingsTabView();
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
