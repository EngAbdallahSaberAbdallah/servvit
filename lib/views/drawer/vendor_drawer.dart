import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/enums/image_type.dart';
import 'package:echo/core/services/local/cache_helper/cache_helper.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/default_dialog.dart';
import 'package:echo/core/shared_components/profile_picture.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:echo/cubits/design_request/design_request_cubit.dart';
import 'package:echo/cubits/design_request/design_request_states.dart';
import 'package:echo/cubits/main/main_cubit.dart';
import 'package:echo/cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import 'package:echo/cubits/vendor_profile/vendor_profile_cubit.dart';
import 'package:echo/views/auth/login_screen.dart';
import 'package:echo/views/intro/intro_screen.dart';
import 'package:echo/views/vendor/views/screens/bottom_navigation_screens/home_screen.dart';
import 'package:echo/views/vendor/views/screens/conditions_screen.dart';
import 'package:echo/views/vendor/views/screens/privacy_screen.dart';
import 'package:echo/views/vendor/views/screens/requests_screen.dart';
import 'package:echo/views/vendor/views/screens/shipping_screen.dart';
import 'package:echo/views/vendor/views/screens/vendor_cart_screen.dart';
import 'package:echo/views/why_echo/why_echo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/shared_components/default_cached_network_image.dart';
import '../../core/shared_components/login_first.dart';
import '../../core/utils/assets.dart';
import '../../cubits/bottom_navbar/bottom_navbar_cubit.dart';
import '../../layout/main/main_layout.dart';
import '../vendor/views/screens/about_us.dart';
import '../vendor/views/screens/bottom_navigation_screens/main_screen.dart';
import '../vendor/views/screens/contact_us.dart';
import '../vendor/views/screens/customers_reviews_screen.dart';

class VendorDrawerScreen extends StatelessWidget {
  const VendorDrawerScreen({Key? key}) : super(key: key);

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
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      Assets.imagesIconBackSquare,
                      height: 20.h,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                  Image.asset(
                    "assets/images/logo2.png",
                    width: 100.w,
                    height: 40.h,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
              //   return AuthCubit.get(context).profileModel == null
              //       ? const Center(child: CircularProgressIndicator())
              //       : Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             ProfilePicture(
              //                 imageType: ImageType.network,
              //                 size: 25.sp,
              //                 imageLink: AuthCubit.get(context)
              //                     .profileModel!
              //                     .data!
              //                     .image),
              //             SizedBox(width: 10.w),
              //             Expanded(
              //                 child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   AuthCubit.get(context)
              //                       .profileModel!
              //                       .data!
              //                       .name!,
              //                   style: AppTextStyle.title(),
              //                 ),
              //                 Text(
              //                   CacheKeysManger.getUserTypeFromCache()!,
              //                   style: AppTextStyle.bodyText(),
              //                 ),
              //               ],
              //             )),
              //           ],
              //         );
              // }),
              if (CacheKeysManger.getUserTokenFromCache() != "")
                BlocBuilder<AuthCubit, AuthStates>(
                  builder: (context, state) {
                    return AuthCubit.get(context).profileModel != null
                        ? InkWell(
                            onTap: () {
                              Scaffold.of(context).closeDrawer();
                              BottomNavbarCubit.get(context)
                                  .changeBottomNavbar(3, profileTab: true);
                            },
                            child: Row(
                              children: [
                                ProfilePicture(
                                  imageType: ImageType.network,
                                  imageLink: AuthCubit.get(context)
                                              .profileModel!
                                              .data!
                                              .image !=
                                          null
                                      ? EndPoints.clients +
                                          AuthCubit.get(context)
                                              .profileModel!
                                              .data!
                                              .image!
                                      : null,
                                  size: 20.sp,
                                ),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(50.sp),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.circular(50.sp),
                                //     ),
                                //     child: DefaultCachedNetworkImage(
                                //       imageUrl: AuthCubit.get(context)
                                //           .profileModel!
                                //           .data!
                                //           .image!=null?EndPoints.clients +
                                //           AuthCubit.get(context)
                                //               .profileModel!
                                //               .data!
                                //               .image!:"",
                                //       imageHeight: 50.sp,
                                //       imageWidth: 50.sp,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      AuthCubit.get(context)
                                              .profileModel!
                                              .data!
                                              .name ??
                                          "",
                                      style: AppTextStyle.title()
                                          .copyWith(fontSize: 13.sp),
                                    ),
                                    subtitle: Text(
                                      AuthCubit.get(context)
                                              .profileModel!
                                              .data!
                                              .email ??
                                          "",
                                      style: AppTextStyle.bodyText()
                                          .copyWith(fontSize: 10.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox();
                  },
                ),
              if (CacheKeysManger.getUserTokenFromCache() != "")
                SizedBox(height: 20.h),

              //market
              ListTile(
                onTap: () {
                  if (CacheKeysManger.getUserTokenFromCache() == "") {
                    defaultLogin(context: context);
                  } else {
                    Scaffold.of(context).closeDrawer();
                    BottomNavbarCubit.get(context).changeBottomNavbar(2);
                  }
                },
                title: Text(
                  "market".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  "assets/images/market.png",
                  width: MediaQuery.of(context).size.width * .08,
                  color: AppColors.primaryColor,
                ),
              ),

              // Cart
              BlocBuilder<VendorAddToCartCubit, VendorAddToCartState>(
                  buildWhen: (previous, current) {
                if (current is CartCountSuccessState ||
                    current is CartCountLoadingState) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                return ListTile(
                  onTap: () {
                    if (CacheKeysManger.getUserTokenFromCache() == "") {
                      defaultLogin(context: context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VendorCartScreen()));
                    }
                  },
                  title: Text(
                    "shopping_cart".tr(),
                    style: AppTextStyle.title()
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                  leading: Stack(
                    children: [
                      Image.asset(
                        Assets.imagesProducts,
                        width: MediaQuery.of(context).size.width * .08,
                        color: AppColors.primaryColor,
                      ),
                      state is CartCountSuccessState
                          ? _buildBage(count: state.count)
                          : SizedBox()
                    ],
                  ),
                  // trailing: state is CartCountSuccessState
                  //     ? _buildBage(count: state.count)
                  //     : SizedBox(),
                );
              }),

              // Orders
              BlocBuilder<VendorProfileCubit, VendorProfileState>(
                  buildWhen: (previous, current) {
                if (current is VendorProfileAllOrdersSuccess ||
                    current is VendorProfileAllOrdersLoading) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                return ListTile(
                  onTap: () {
                    if (CacheKeysManger.getUserTokenFromCache() == "") {
                      defaultLogin(context: context);
                    } else {
                      Scaffold.of(context).closeDrawer();
                      BottomNavbarCubit.get(context)
                          .changeBottomNavbar(3, orderTab: true);
                    }
                  },
                  title: Text(
                    "orders".tr(),
                    style: AppTextStyle.title()
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                  leading: Image.asset(
                    "assets/images/bag.png",
                    width: MediaQuery.of(context).size.width * .08,
                    color: AppColors.primaryColor,
                  ),
                  // trailing: state is VendorProfileAllOrdersSuccess
                  //     ? _buildBage(count: state.count)
                  //     : SizedBox(),
                );
              }),

              // notifications
              // BlocBuilder<VendorProfileCubit, VendorProfileState>(
              //     buildWhen: (previous, current) {
              //   if (current is VendorProfileNotificationSuccess ||
              //       current is VendorProfileNotificationLoading ||
              //       current is VendorProfileNotificationError) {
              //     return true;
              //   }
              //   return false;
              // }, builder: (context, state) {
              //   return ListTile(
              //     onTap: () {
              //       if (CacheKeysManger.getUserTokenFromCache() == "") {
              //         defaultLogin(context: context);
              //       } else {
              //         Scaffold.of(context).closeDrawer();
              //         BottomNavbarCubit.get(context)
              //             .changeBottomNavbar(3, orderTab: false);
              //       }
              //     },
              //     title: Text(
              //       "notification".tr(),
              //       style: AppTextStyle.title()
              //           .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
              //     ),
              //     leading: Stack(
              //       children: [
              //         Icon(
              //           Icons.notifications_outlined,
              //           color: AppColors.primaryColor,
              //           size: MediaQuery.of(context).size.width * .08,
              //         ),
              //         state is VendorProfileNotificationSuccess
              //         ? _buildBage(count: state.count)
              //         : SizedBox(),
              //       ],
              //     ),
              //     // trailing: state is VendorProfileNotificationSuccess
              //     //     ? _buildBage(count: state.count)
              //     //     : SizedBox(),
              //   );
              // }),

              BlocBuilder<DesignRequestCubit, DesignRequestState>(
                  buildWhen: (previous, current) {
                if (current is GetDesignRequestSuccessState ||
                    current is GetDesignRequestLoadingState) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                return ListTile(
                  onTap: () {
                    if (CacheKeysManger.getUserTokenFromCache() == "") {
                      defaultLogin(context: context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestsScreen()));
                    }
                  },
                  title: Text(
                    "requests".tr(),
                    style: AppTextStyle.title()
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                  leading: Stack(
                    children: [
                      Image.asset(
                        "assets/images/bagD.png",
                        width: MediaQuery.of(context).size.width * .08,
                        color: AppColors.primaryColor,
                      ),
                      state is GetDesignRequestSuccessState
                          ? CacheHelper.getData(
                              key: "isOrderPriceOpend",
                            ) is bool
                              ? CacheHelper.getData(
                                        key: "isOrderPriceOpend",
                                      ) ||
                                      state.count == 0
                                  ? SizedBox()
                                  : _buildBage(count: state.count)
                              : SizedBox()
                          : SizedBox(),
                    ],
                  ),
                  // trailing: state is GetDesignRequestSuccessState
                  //     ? _buildBage(count: state.count)
                  //     : SizedBox(),
                );
              }),

              ListTile(
                onTap: () {
                  // Scaffold.of(context).closeDrawer();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WhyEchoScreen()));
                },
                title: Text(
                  "why_echo".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  Assets.imagesWhyEcho,
                  width: MediaQuery.of(context).size.width * .08,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  // Scaffold.of(context).closeDrawer();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomersReviewsScreen()));
                },
                title: Text(
                  "customer_reviews".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  Assets.imagesCustomerReviews,
                  width: MediaQuery.of(context).size.width * .08,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  // Scaffold.of(context).closeDrawer();
                  if (CacheKeysManger.getUserTokenFromCache() == "") {
                    defaultLogin(context: context);
                  } else {
                    context.read<MainCubit>().getAllCountries();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactUs()));
                  }
                },
                title: Text(
                  "contact_us".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  Assets.imagesContactUs,
                  width: MediaQuery.of(context).size.width * .08,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () async {
                  await BottomNavbarCubit.get(context).changeLang(context);
                  if (BottomNavbarCubit.get(context).currentIndex != 0) {
                    BottomNavbarCubit.get(context).changeBottomNavbar(0);
                  }
                  BottomNavbarCubit.get(context).getHomeData(context);
                  NavigationUtils.navigateBack(context: context);
                  // NavigationUtils.navigateReplacement(context: context, destinationScreen: VendorMainScreen());
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
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ),
                  );
                },
                title: Text(
                  "about_us".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Icon(
                  Icons.info,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyScreen(),
                    ),
                  );
                },
                title: Text(
                  "privacy".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  "assets/images/privacy.png",
                  width: MediaQuery.of(context).size.width * .08,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConditionsScreen(),
                    ),
                  );
                },
                title: Text(
                  "conditions".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  "assets/images/conditions.png",
                  width: MediaQuery.of(context).size.width * .08,
                  color: AppColors.primaryColor,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShippingScreen(),
                    ),
                  );
                },
                title: Text(
                  "shipping".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: Image.asset(
                  "assets/images/returns.png",
                  width: MediaQuery.of(context).size.width * .08,
                  color: AppColors.primaryColor,
                ),
              ),

              Divider(),

              ListTile(
                onTap: () async {
                  BottomNavbarCubit.get(context).changeBottomNavbar(0);
                  if (CacheKeysManger.getUserTokenFromCache() == "") {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    CacheHelper.removeData(key: "userToken");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => IntroScreen()));
                  }
                },
                title: Text(
                  CacheKeysManger.getUserTokenFromCache() == ""
                      ? "login".tr()
                      : "signOut".tr(),
                  style: AppTextStyle.title()
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                leading: CacheKeysManger.getUserTokenFromCache() == ""
                    ? Icon(
                        Icons.login,
                        size: 30.sp,
                        color: AppColors.primaryColor,
                      )
                    : Image.asset(
                        "assets/images/signOut.png",
                        width: MediaQuery.of(context).size.width * .08,
                        color: Colors.red,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBage({required int count}) {
    return count > 0
        ? Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: AppColors.bageBackground, shape: BoxShape.circle))
        : const SizedBox();

    // Transform.translate(
    //   offset: const Offset(0, -7),
    //   child: Container(
    //       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
    //       decoration: BoxDecoration(
    //           color: AppColors.bageBackground,
    //           borderRadius: BorderRadius.circular(6)),
    //       child:
    //        Text(
    //         count > 999 ? '999+' : "$count",
    //         style: AppTextStyle.subTitle()
    //             .copyWith(color: Colors.white, fontSize: 10),
    //         textAlign: TextAlign.center,
    //       )
    //       ),
    // );
  }
}

// import 'package:easy_localization/easy_localization.dart';
// import 'package:echo/core/colors/app_colors.dart';
// import 'package:echo/core/services/local/cache_helper/cache_helper.dart';
// import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
// import 'package:echo/core/shared_components/default_dialog.dart';
// import 'package:echo/core/text_styles/app_text_style.dart';
// import 'package:echo/core/utils/navigation_utility.dart';
// import 'package:echo/cubits/auth/auth_cubit.dart';
// import 'package:echo/cubits/auth/auth_states.dart';
// import 'package:echo/cubits/main/main_cubit.dart';
// import 'package:echo/views/intro/intro_screen.dart';
// <<<<<<< HEAD
// import 'package:echo/views/vendor/views/screens/bottom_navigation_screens/home_screen.dart';
// import 'package:echo/views/vendor/views/screens/requests_screen.dart';
// =======
// >>>>>>> Mohamed
// import 'package:echo/views/why_echo/why_echo_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../core/shared_components/default_cached_network_image.dart';
// import '../../core/shared_components/login_first.dart';
// import '../../core/utils/assets.dart';
// import '../../cubits/bottom_navbar/bottom_navbar_cubit.dart';
// import '../vendor/views/screens/about_us.dart';
// import '../vendor/views/screens/bottom_navigation_screens/main_screen.dart';
// import '../vendor/views/screens/contact_us.dart';
// import '../vendor/views/screens/customers_reviews_screen.dart';

// class VendorDrawerScreen extends StatelessWidget {
//   const VendorDrawerScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Drawer(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 10.h),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: SvgPicture.asset(
//                         Assets.imagesIconBackSquare,
//                         height: 20.h,
//                         color: AppColors.primaryColor,
//                       ),
//                     ),
//                     SizedBox(width: MediaQuery.of(context).size.width * 0.15),
//                     Image.asset(Assets.imagesLogo2),
//                   ],
//                 ),
//                 SizedBox(height: 20.h),

// <<<<<<< HEAD
//               // BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
//               //   return AuthCubit.get(context).profileModel == null
//               //       ? const Center(child: CircularProgressIndicator())
//               //       : Row(
//               //           crossAxisAlignment: CrossAxisAlignment.start,
//               //           children: [
//               //             ProfilePicture(
//               //                 imageType: ImageType.network,
//               //                 size: 25.sp,
//               //                 imageLink: AuthCubit.get(context)
//               //                     .profileModel!
//               //                     .data!
//               //                     .image),
//               //             SizedBox(width: 10.w),
//               //             Expanded(
//               //                 child: Column(
//               //               crossAxisAlignment: CrossAxisAlignment.start,
//               //               children: [
//               //                 Text(
//               //                   AuthCubit.get(context)
//               //                       .profileModel!
//               //                       .data!
//               //                       .name!,
//               //                   style: AppTextStyle.title(),
//               //                 ),
//               //                 Text(
//               //                   CacheKeysManger.getUserTypeFromCache()!,
//               //                   style: AppTextStyle.bodyText(),
//               //                 ),
//               //               ],
//               //             )),
//               //           ],
//               //         );
//               // }),
//             BlocBuilder<AuthCubit, AuthStates>(
//               builder: (context, state) {
//                 return  AuthCubit.get(context)
//                     .profileModel !=null ? InkWell(
// =======
//                 // BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
//                 //   return AuthCubit.get(context).profileModel == null
//                 //       ? const Center(child: CircularProgressIndicator())
//                 //       : Row(
//                 //           crossAxisAlignment: CrossAxisAlignment.start,
//                 //           children: [
//                 //             ProfilePicture(
//                 //                 imageType: ImageType.network,
//                 //                 size: 25.sp,
//                 //                 imageLink: AuthCubit.get(context)
//                 //                     .profileModel!
//                 //                     .data!
//                 //                     .image),
//                 //             SizedBox(width: 10.w),
//                 //             Expanded(
//                 //                 child: Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 Text(
//                 //                   AuthCubit.get(context)
//                 //                       .profileModel!
//                 //                       .data!
//                 //                       .name!,
//                 //                   style: AppTextStyle.title(),
//                 //                 ),
//                 //                 Text(
//                 //                   CacheKeysManger.getUserTypeFromCache()!,
//                 //                   style: AppTextStyle.bodyText(),
//                 //                 ),
//                 //               ],
//                 //             )),
//                 //           ],
//                 //         );
//                 // }),
//                 BlocBuilder<AuthCubit, AuthStates>(
//                   builder: (context, state) {
//                     return InkWell(
//                       onTap: () {
//                         Scaffold.of(context).closeDrawer();
//                         BottomNavbarCubit.get(context)
//                             .changeBottomNavbar(3, profileTab: true);
//                       },
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(50.sp),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(50.sp),
//                               ),
//                               child: DefaultCachedNetworkImage(
//                                 imageUrl: AuthCubit.get(context)
//                                     .profileModel!
//                                     .data!
//                                     .image!,
//                                 imageHeight: 50.sp,
//                                 imageWidth: 50.sp,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10.w),
//                           Expanded(
//                             child: ListTile(
//                               title: Text(
//                                 AuthCubit.get(context)
//                                     .profileModel!
//                                     .data!
//                                     .name!,
//                                 style: AppTextStyle.title()
//                                     .copyWith(fontSize: 14.sp),
//                               ),
//                               subtitle: Text(
//                                 AuthCubit.get(context)
//                                     .profileModel!
//                                     .data!
//                                     .email!,
//                                 style: Theme.of(context).textTheme.bodySmall,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),

//                 SizedBox(height: 20.h),
//                 ListTile(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     BottomNavbarCubit.get(context).changeBottomNavbar(2);
//                   },
//                   title: Text(
//                     "my_market".tr(),
//                     style: AppTextStyle.title().copyWith(fontSize: 14.sp),
//                   ),
//                   leading: Image.asset(
//                     "assets/images/market.png",
//                     width: MediaQuery.of(context).size.width * .08,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     // NavigationUtils.navigateTo(
//                     //     context: context, destinationScreen: CategoriesScreen());
//                   },
//                   title: Text(
//                     "add_product".tr(),
//                     style: AppTextStyle.title().copyWith(fontSize: 14.sp),
//                   ),
//                   leading: Image.asset(
//                     Assets.imagesProducts,
//                     width: MediaQuery.of(context).size.width * .08,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 ListTile(
// >>>>>>> Mohamed
//                   onTap: () {
//                     Scaffold.of(context).closeDrawer();
//                     BottomNavbarCubit.get(context)
//                         .changeBottomNavbar(3, orderTab: true);
//                   },
// <<<<<<< HEAD
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(50.sp),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50.sp),
//                           ),
//                           child: DefaultCachedNetworkImage(
//                            imageUrl: Endpoints.clients+AuthCubit.get(context)
//                                .profileModel!
//                                .data!
//                                .image!, imageHeight: 50.sp, imageWidth: 50.sp,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10.w),
//                       Expanded(
//                         child: ListTile(
//                           title: Text(AuthCubit.get(context)
//                               .profileModel!
//                               .data!
//                               .name??"",style: AppTextStyle.title().copyWith(
//                               fontSize: 14.sp
//                           ),),
//                           subtitle: Text(
//                             AuthCubit.get(context)
//                                 .profileModel!
//                                 .data!
//                                 .email??"",
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ):SizedBox();
//               },
//             ),
// =======
//                   title: Text(
//                     "orders".tr(),
//                     style: AppTextStyle.title().copyWith(fontSize: 14.sp),
//                   ),
//                   leading: Image.asset(
//                     "assets/images/bag.png",
//                     width: MediaQuery.of(context).size.width * .08,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     // Scaffold.of(context).closeDrawer();
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => WhyEchoScreen()));
//                   },
//                   title: Text(
//                     "why_echo".tr(),
//                     style: AppTextStyle.title().copyWith(fontSize: 14.sp),
//                   ),
//                   leading: Image.asset(
//                     Assets.imagesWhyEcho,
//                     width: MediaQuery.of(context).size.width * .08,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     // Scaffold.of(context).closeDrawer();
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => CustomersReviewsScreen()));
//                   },
//                   title: Text(
//                     "customer_reviews".tr(),
//                     style: AppTextStyle.title().copyWith(fontSize: 14.sp),
//                   ),
//                   leading: Image.asset(
//                     Assets.imagesCustomerReviews,
//                     width: MediaQuery.of(context).size.width * .08,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     // Scaffold.of(context).closeDrawer();
//                     context.read<MainCubit>().getAllCountries();
// >>>>>>> Mohamed

//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => ContactUs()));
//                   },
//                   title: Text(
//                     "contact_us".tr(),
//                     style: AppTextStyle.title().copyWith(fontSize: 14.sp),
//                   ),
//                   leading: Image.asset(
//                     Assets.imagesContactUs,
//                     width: MediaQuery.of(context).size.width * .08,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 ListTile(
//                   onTap: () async {
//                     await BottomNavbarCubit.get(context).changeLang(context);
//                     if (BottomNavbarCubit.get(context).currentIndex != 0) {
//                       BottomNavbarCubit.get(context).changeBottomNavbar(0);
//                     }
//                     NavigationUtils.navigateReplacement(
//                         context: context,
//                         destinationScreen: VendorMainScreen());
//                   },
//                   title: Text(
//                     "lang".tr(),
//                     style: AppTextStyle.title().copyWith(fontSize: 14.sp),
//                   ),
//                   leading: Icon(
//                     Icons.language,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
// <<<<<<< HEAD
//               ),
//               ListTile(
//                 onTap: () {
//                   if(CacheKeysManger.getUserTokenFromCache()=="")
//                     {
//                       defaultLogin(context: context);
//                     }else{
//                     Scaffold.of(context).closeDrawer();
//                     BottomNavbarCubit.get(context)
//                         .changeBottomNavbar(3, orderTab: true);
//                   }

//                 },
//                 title: Text("orders".tr(),style: AppTextStyle.title().copyWith(
//                     fontSize: 14.sp
//                 ),),
//                 leading: Image.asset(
//                   "assets/images/bag.png",
//                   width: MediaQuery.of(context).size.width*.08,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   if(CacheKeysManger.getUserTokenFromCache()=="")
//                   {
//                     defaultLogin(context: context);
//                   }else{
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestsScreen()));
//                   }

//                 },
//                 title: Text("requests".tr(),style: AppTextStyle.title().copyWith(
//                     fontSize: 14.sp
//                 ),),
//                 leading: Image.asset(
//                   "assets/images/bagD.png",
//                   width: MediaQuery.of(context).size.width*.08,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   // Scaffold.of(context).closeDrawer();
//                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WhyEchoScreen()));
//                 },
//                 title: Text("why_echo".tr(),style: AppTextStyle.title().copyWith(
//                   fontSize: 14.sp
//                 ),),
//                 leading: Image.asset(
//                   Assets.imagesWhyEcho,
//                   width: MediaQuery.of(context).size.width*.08,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   // Scaffold.of(context).closeDrawer();
//                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomersReviewsScreen()));
//                 },
//                 title: Text("customer_reviews".tr(),style: AppTextStyle.title().copyWith(
//                     fontSize: 14.sp
//                 ),),
//                 leading: Image.asset(
//                   Assets.imagesCustomerReviews,
//                   width: MediaQuery.of(context).size.width*.08,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   // Scaffold.of(context).closeDrawer();
//                   if(CacheKeysManger.getUserTokenFromCache()=="")
//                   {
//                     defaultLogin(context: context);
//                   }else{
//                     context.read<MainCubit>().getAllCountries();

//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
//                   }
//                 },
//                 title: Text("contact_us".tr(),style: AppTextStyle.title().copyWith(
//                     fontSize: 14.sp
//                 ),),
//                 leading: Image.asset(
//                   Assets.imagesContactUs,
//                   width: MediaQuery.of(context).size.width*.08,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               ListTile(
//                 onTap: () async{
//                   await BottomNavbarCubit.get(context).changeLang(context);
//                   if (BottomNavbarCubit.get(context).currentIndex != 0) {
//                     BottomNavbarCubit.get(context).changeBottomNavbar(0);
//                   }
//                   NavigationUtils.navigateReplacement(context: context, destinationScreen: VendorMainScreen());
//                 },
//                 title: Text("lang".tr(),style: AppTextStyle.title().copyWith(
//                     fontSize: 14.sp
//                 ),),
//                 leading: Icon(
//                   Icons.language,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AboutUs(),
//                     ),
//                   );
//                 },
//                 title: Text("about_us".tr(),style: AppTextStyle.title().copyWith(
//                     fontSize: 14.sp
//                 ),),
//                 leading: Icon(
//                   Icons.info,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               Divider(),
//               ListTile(
//                 onTap: () async{
//                   CacheHelper.removeData(key: "userToken");
//                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroScreen()));
//                 },
//                 title: Text("signOut".tr(),style: AppTextStyle.title().copyWith(
//                     fontSize: 14.sp
//                 ),),
//                 leading: Image.asset(
//                   "assets/images/signOut.png",
//                   width: MediaQuery.of(context).size.width*.08,
//                   color: Colors.red,
// =======
//                 ListTile(
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AboutUs(),
//                       ),
//                     );
//                   },
//                   title: Text("About Us"),
//                   leading: Icon(
//                     Icons.info,
//                     color: AppColors.primaryColor,
//                   ),
// >>>>>>> Mohamed
//                 ),
//                 BlocConsumer<AuthCubit, AuthStates>(
//                   listener: (context, state) {
//                     if (state is LogoutSuccessState) {
//                       NavigationUtils.navigateAndClearStack(
//                           context: context, destinationScreen: IntroScreen());
//                     }
//                   },
//                   builder: (context, state) => state is LogoutLoadingState
//                       ? Center(
//                           child: CircularProgressIndicator(
//                           value: 15.r,
//                         ))
//                       : ListTile(
//                           onTap: () {
//                             AuthCubit.get(context).logout();
//                           },
//                           title: Text("Log Out"),
//                           leading: Icon(
//                             Icons.logout_rounded,
//                             color: AppColors.primaryColor,
//                           ),
//                         ),
//                 ),
//                 Divider(),
//                 ListTile(
//                   onTap: () async {
//                     CacheHelper.removeData(key: "userToken");
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => IntroScreen()));
//                   },
//                   title: Text(
//                     "signOut".tr(),
//                     style: AppTextStyle.title().copyWith(fontSize: 14.sp),
//                   ),
//                   leading: Image.asset(
//                     "assets/images/signOut.png",
//                     width: MediaQuery.of(context).size.width * .08,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
