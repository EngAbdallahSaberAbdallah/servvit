import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/shared_components/exit_alert.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/vendor_my_cart/vendor_my_cart_cubit.dart';
import 'package:echo/views/vendor/views/screens/bottom_navigation_screens/vendor_profile_screen.dart';
import 'package:echo/views/vendor/views/widgets/build_cart_icon.dart';
import 'package:echo/views/vendor/views/widgets/build_notification_icon.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/shared_components/login_first.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../cubits/bottom_navbar/bottom_navbar_cubit.dart';
import '../../../../../cubits/payment_method_cubit/payment_method_cubit.dart';
import '../../../../../cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import '../../../../drawer/vendor_drawer.dart';
import '../custom_product.dart';
import '../vendor_cart_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'market_screen.dart';

class VendorMainScreen extends StatefulWidget {
  VendorMainScreen({Key? key}) : super(key: key);

  @override
  State<VendorMainScreen> createState() => _VendorMainScreenState();
}

class _VendorMainScreenState extends State<VendorMainScreen> {
  final List<Widget> bottomNavbarScreens = [
    VendorHomeScreen(),
    VendorFavoriteScreen(),
    VendorMarketScreen(),
    VendorProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    final messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();

    context.read<AuthCubit>().addFcmTokenUser(token: token!);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //! in case it add order successfully
    if (PaymentMethodCubit.get(context).state is PaySuccessState &&
        PaymentMethodCubit.get(context).showDialog) {
      PaySuccessState state =
          PaymentMethodCubit.get(context).state as PaySuccessState;
      VendorAddToCartCubit.get(context).cartCount();
      VendorMyCartCubit.get(context).getMyCart();
      Future(
        () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              content: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * .48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/correct_success.png',
                            height: 200,
                            width: MediaQuery.sizeOf(context).width * .2,
                          ),
                          Text(
                            'order_sccuess'.tr(),
                            style: AppTextStyle.title(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.primaryColor,
                            ),
                      ),
                      subtitle: Text(
                        "${"order_number".tr()}: ${state.orderNumber.toString()}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 12.sp,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              backgroundColor: Color.fromRGBO(186, 210, 88, 1),
                              minimumSize: Size(85.w, 20.h),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              BottomNavbarCubit.get(context)
                                  .changeBottomNavbar(3, orderTab: true);
                            },
                            child: Text(
                              'order_details'.tr(),
                              style: AppTextStyle.subTitle().copyWith(
                                  color: Colors.black, fontSize: 13.sp),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'dismiss'.tr(),
                            style: AppTextStyle.subTitle()
                                .copyWith(color: Colors.black, fontSize: 13.sp),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ).whenComplete(() => PaymentMethodCubit.get(context).showDialog = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BottomNavbarCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        if (cubit.currentIndex == 0) {
          exitDialog(context);
        } else {
          cubit.changeBottomNavbar(0);
        }
        return false;
      },
      child: BlocBuilder<BottomNavbarCubit, BottomNavbarState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 50.h,
            leading: cubit.currentIndex != 0
                ? IconButton(
                    onPressed: () {
                      cubit.changeBottomNavbar(0);
                    },
                    icon: SvgPicture.asset(
                      Assets.imagesIconBackSquare,
                      height: 20.h,
                      color: AppColors.primaryColor,
                    ),
                  )
                : Builder(
                    builder: (context) {
                      return IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
            title: Image.asset(
              Assets.imagesLogo2,
              width: 100.w,
              height: 40.h,
              fit: BoxFit.contain,
            ),
            centerTitle: true,
            actions: CacheKeysManger.getUserTokenFromCache() == ""
                ? null
                : [
                    // Row(
                    //   children: [
                    //     BuildNotificationIcon(
                    //       onTap: () {
                    //         BottomNavbarCubit.get(context)
                    //             .changeBottomNavbar(3, orderTab: false);
                    //       },
                    //     ),
                    BuildCartIcon(),
                    //   ],
                    // )
                  ],
          ),
          body: bottomNavbarScreens[cubit.currentIndex],
          drawer: VendorDrawerScreen(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.primaryColor,
            elevation: 0.0,
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              if (index == 2) {
                fromHome = true;
                catIndex = 0;
              }
              if (index == 1 || index == 3) {
                if (CacheKeysManger.getUserTokenFromCache() == "") {
                  defaultLogin(context: context);
                } else {
                  cubit.changeBottomNavbar(index);
                }
              } else {
                cubit.changeBottomNavbar(index);
              }
            },
            selectedItemColor: Colors.white,
            selectedLabelStyle:
                TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: "home".tr()),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.heart), label: "fav".tr()),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.imagesShape,
                  color: cubit.currentIndex == 2 ? Colors.white : Colors.grey,
                ),
                label: "market".tr(),
              ),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: "profile".tr()),
            ],
          ),
          floatingActionButton: cubit.currentIndex == 2
              ? FloatingActionButton.extended(
                  onPressed: () {
                    // Add your onPressed code here!
                    if (CacheKeysManger.getUserTokenFromCache() == "") {
                      defaultLogin(context: context);
                    } else {
                      file = null;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomProductScreen()));
                    }
                  },
                  label: Text(
                    'custom_product'.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Image.asset(
                    "assets/images/robot.png",
                    width: MediaQuery.of(context).size.width * .08,
                    color: Colors.white,
                  ),
                  backgroundColor: AppColors.primaryColor,
                )
              : null,
        ),
      ),
    );
  }
}
