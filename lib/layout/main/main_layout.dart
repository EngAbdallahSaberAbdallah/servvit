import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/exit_alert.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/views/drawer/drawer_screen.dart';
import 'package:echo/views/supplier/categories/categories_screen.dart'; // Import CategoriesScreen
import 'package:echo/views/supplier/home/home_screen.dart';
import 'package:echo/views/supplier/market/market_screen.dart';
import 'package:echo/views/supplier/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../core/colors/app_colors.dart';
import '../../cubits/bottom_navbar/bottom_navbar_cubit.dart';
class MainLayout extends StatefulWidget {
  MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  // Define your bottom navigation screens
  final List<Widget> bottomNavbarScreens = [
    HomeScreen(),
    MarketScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = BottomNavbarCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        exitDialog(context);
        return true;
      },
      child: BlocBuilder<BottomNavbarCubit, BottomNavbarState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            // AppBar content
          ),
          body: bottomNavbarScreens[cubit.currentIndex],
          drawer: DrawerScreen(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 0.0,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNavbar(index);
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: "home".tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/Shape.svg",
                  color: cubit.currentIndex == 1 ? Colors.white : Colors.grey,
                ),
                label: "my_market".tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: "profile".tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
