import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/enums/constants.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/cubits/add_to_cart_customize/add_to_cart_customize_cubit.dart';
import 'package:echo/cubits/add_to_cart_designed/add_to_cart_designed_cubit.dart';
import 'package:echo/cubits/all_bannares/all_banners_cubit.dart';
import 'package:echo/cubits/all_categories/all_categories_cubit.dart';
import 'package:echo/cubits/all_customers/all_customers.dart';
import 'package:echo/cubits/all_services/all_services_cubit.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/cancel_request/cancel_request_cubit.dart';
import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/cubits/discussion/discussion_cubit.dart';
import 'package:echo/cubits/eco_friendly/eco_friendly_cubit.dart';
import 'package:echo/cubits/main/main_cubit.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:echo/cubits/reject_customize_request/reject_customize_request_cubit.dart';
import 'package:echo/cubits/reject_designed_request/reject_designed_request_cubit.dart';
import 'package:echo/cubits/select_category/select_categories_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_cubit.dart';
import 'package:echo/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/app_theme.dart';
import '../cubits/all_products/all_products_cubit.dart';
import '../cubits/bottom_navbar/bottom_navbar_cubit.dart';
import '../cubits/design_request/design_request_cubit.dart';
import '../cubits/payment_method_cubit/payment_method_cubit.dart';
import '../cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import '../cubits/vendor_my_cart/vendor_my_cart_cubit.dart';
import '../cubits/vendor_profile/vendor_profile_cubit.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: "lib/l10n/lang",
      supportedLocales: const [Locale("ar"), Locale("en")],
      saveLocale: true,
      startLocale: Locale("ar"),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomNavbarCubit()),
          BlocProvider(create: (context) => AuthCubit()),
          BlocProvider(create: (context) => MainCubit()),
          BlocProvider(create: (context) => SelectCategoriesCubit()),
          BlocProvider(create: (context) => CancelRequestCubit()),
          BlocProvider(create: (context) => RejectCustomizeRequestCubit()),
          BlocProvider(create: (context) => RejectDesignedRequestCubit()),
          BlocProvider(create: (context) => AddToCartCustomizeRequestCubit()),
          BlocProvider(create: (context) => AddToCartDesignedRequestCubit()),
          BlocProvider(
              create: (context) =>
                  CustomizeRequestCubit()..getAllCustomizeRequests()),
          BlocProvider(
              create: (context) =>
                  DesignRequestCubit()..getAllDesignRequests()),
          BlocProvider(create: (context) => AllBannersCubit()..getAllBanners()),
          BlocProvider(
              create: (context) => AllServicesCubit()..getAllServices()),
          BlocProvider(
              create: (context) => EcoFriendlyCubit()..getEchoFirendly()),
          BlocProvider(
              create: (context) => AllCategoriesCubit()..getAllCategories()),
          BlocProvider(
              create: (context) => AllCustomersCubit()..getAllCustomers()),
          BlocProvider(
              create: (context) => DiscussionCubit()..getAllDiscussions()),
          BlocProvider(
              create: (context) => AllProductsCubit()..getAllProducts()),
          BlocProvider(create: (context) => ProductsCubit()),
          BlocProvider(create: (context) => SupplierMarketCubit()),
          BlocProvider(create: (context) => VendorAddToCartCubit()),
          BlocProvider(create: (context) => VendorMyCartCubit()),
          BlocProvider(create: (context) => VendorProfileCubit()),
          BlocProvider(create: (context) => PaymentMethodCubit()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 640),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            title: "Servvit",
            navigatorObservers: [routeObserver],
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: themeDataLight,
            home: child,
            builder: (context, child) {
              //! save context for using it later
              PaymentMethodCubit.paymentContext = context;
              if (AppConstants.firstRunTime) {
                AuthCubit.get(context).getBusinessTypes();
                AuthCubit.get(context).getGovernorates();
                if (CacheKeysManger.getUserTokenFromCache() != "") {
                  AllBannersCubit.get(context).getAllBanners();
                  AuthCubit.get(context).getProfileData();
                }
              }
              AppConstants.firstRunTime = false;
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0.sp),
                child: child!,
              );
            },
          ),
          child: SplashScreen(),
        ),
      ),
    );
  }
}
