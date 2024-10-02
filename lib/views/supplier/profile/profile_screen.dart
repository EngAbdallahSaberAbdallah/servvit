import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/views/auth/update_profile_screen.dart';
import 'package:echo/views/supplier/profile/components/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
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

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    if (BottomNavbarCubit.get(context).orderTab) {
      _tabController.animateTo(1);
      BottomNavbarCubit.get(context).orderTab = false;
    }
   
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5.sp),
            ),
            tabs: [
              Tab(
                text: "profile".tr(),
              ),
              Tab(text: "orders".tr()),
            ],
          ),
          SizedBox(height: 15.h),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                UpdateProfileScreen(),
                MyOrdersScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
