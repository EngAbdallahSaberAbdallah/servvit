import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_helper.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/cubits/all_bannares/all_banners_cubit.dart';
import 'package:echo/cubits/all_categories/all_categories_cubit.dart';
import 'package:echo/cubits/all_customers/all_customers.dart';
import 'package:echo/cubits/all_services/all_services_cubit.dart';
import 'package:echo/cubits/discussion/discussion_cubit.dart';
import 'package:echo/cubits/eco_friendly/eco_friendly_cubit.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../all_products/all_products_cubit.dart';

part 'bottom_navbar_state.dart';

class BottomNavbarCubit extends Cubit<BottomNavbarState> {
  BottomNavbarCubit() : super(BottomNavbarInitial());

  static BottomNavbarCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool orderTab = false;
  bool profileTab = false;
  bool categorySpecific = false;
  int counterHomeScreen = 0;
  void changeBottomNavbar(int index,
      {bool? orderTab, bool? profileTab, bool? categoryDetails}) {
    currentIndex = index;
    if (orderTab != null) {
      this.orderTab = orderTab;
    }
    if (profileTab != null) {
      this.profileTab = profileTab;
    }
    if (categoryDetails != null) {
      categorySpecific = categoryDetails;
    }
    emit(ChangeBottomNavbarState());
  }

  Future<void> changeLang(BuildContext context) async {
    if (CacheKeysManger.getLanguageFromCache() == "ar") {
      context.setLocale(const Locale("en"));
      CacheHelper.saveData(key: "lang", value: "en");
    } else {
      context.setLocale(const Locale("ar"));
      CacheHelper.saveData(key: "lang", value: "ar");
    }
    emit(ChangeAppLanguageState());
  }

  Future getHomeData(context) async {
    await AllCategoriesCubit.get(context).getAllCategories();
    AllProductsCubit.get(context).getAllProducts();
    await AllBannersCubit.get(context).getAllBanners();
    EcoFriendlyCubit.get(context).getEchoFirendly();
    Future.delayed(Duration(milliseconds: 200), () {
      AllServicesCubit.get(context).getAllServices();
    });
    Future.delayed(Duration(milliseconds: 300), () {
      AllCustomersCubit.get(context).getAllCustomers();
    });
    Future.delayed(Duration(milliseconds: 300), () {
      DiscussionCubit.get(context).getAllDiscussions();
    });
  }
}
