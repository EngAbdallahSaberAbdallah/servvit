import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/login_first.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/constants.dart';
import 'package:echo/cubits/all_bannares/all_banners_cubit.dart';
import 'package:echo/cubits/all_customers/all_customers.dart';
import 'package:echo/cubits/all_customers/all_customers_state.dart';
import 'package:echo/cubits/all_services/all_services_cubit.dart';
import 'package:echo/cubits/design_request/design_request_cubit.dart';
import 'package:echo/cubits/discussion/discussion_cubit.dart';
import 'package:echo/cubits/discussion/discussion_state.dart';
import 'package:echo/cubits/eco_friendly/eco_friendly_cubit.dart';
import 'package:echo/cubits/eco_friendly/eco_friendly_state.dart';
import 'package:echo/cubits/vendor_profile/vendor_profile_cubit.dart';
import 'package:echo/model/products/vendor_product_model.dart' as productModel;
import 'package:echo/views/vendor/views/screens/vendor_profile_tab_view/echo_friendly_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared_components/default_cached_network_image.dart';
import '../../../../../core/shared_components/error_widget.dart';
import '../../../../../core/shared_components/headline_text.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/navigation_utility.dart';
import '../../../../../cubits/all_categories/all_categories_cubit.dart';
import '../../../../../cubits/all_categories/all_categories_state.dart';
import '../../../../../cubits/all_products/all_products_cubit.dart';
import '../../../../../cubits/bottom_navbar/bottom_navbar_cubit.dart';
import '../../../../../cubits/products/products_cubit.dart';
import '../../../../../cubits/select_category/select_categories_cubit.dart';
import '../../../../../cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import '../../../../../model/products/vendor_product_model.dart' hide Color;
import '../../../../../root/app_root.dart';
import '../../widgets/animated_text.dart';
import '../../widgets/suggestions_text_field.dart';
import '../all_products_vendor_screen.dart';
import '../custom_product.dart';
import '../vendor_product_details.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> with RouteAware {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
     
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    super.didPush();
    log('push*');
    if (CacheKeysManger.getUserTokenFromCache() != '') {
      makeRequestsWithDelay();
    }
  }

    @override
  void didPopNext() {
    super.didPopNext();
    log('pop next');
    // if (CacheKeysManger.getUserTokenFromCache() != '') {
    //   makeRequestsWithDelay();
    // }
  }

  Future<void> makeRequestsWithDelay() async {
    // await Future.delayed(Duration(seconds: 3));
    // if (!mounted) return;
    // VendorAddToCartCubit.get(context).cartCount();

    await Future.delayed(Duration(seconds: 9));
    if (!mounted) return;
    DesignRequestCubit.get(context).designRequestsCount();

    await Future.delayed(Duration(seconds: 15));
    if (!mounted) return;
    VendorProfileCubit.get(context).ordersCount();

    // await Future.delayed(Duration(seconds: 4));
    // if (!mounted) return;
    // VendorProfileCubit.get(context).notificationsCount();
  }



  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          AllCategoriesCubit.get(context).getAllCategories();
          AllProductsCubit.get(context).getAllProducts();
          AllBannersCubit.get(context).getAllBanners();
          EcoFriendlyCubit.get(context).getEchoFirendly();
          await Future.delayed(Duration(seconds: 1));
          AllServicesCubit.get(context).getAllServices();
          await Future.delayed(Duration(seconds: 1));
          AllCustomersCubit.get(context).getAllCustomers();
          await Future.delayed(Duration(seconds: 2));
          DiscussionCubit.get(context).getAllDiscussions();
          if (CacheKeysManger.getUserTokenFromCache() != '') {
            VendorAddToCartCubit.get(context).cartCount();
            // VendorProfileCubit.get(context).notificationsCount();
            VendorProfileCubit.get(context).ordersCount();
            DesignRequestCubit.get(context).designRequestsCount();
          }
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Card(
                        elevation: 5,
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: SuggestionsTextField(
                          hintText: "search".tr(),
                          onSubmitted: (item) {
                            if (item.type == 'products') {
                              Data? data;
                              for (int i = 0;
                                  i <
                                      AllProductsCubit.get(context)
                                          .allProductsModel!
                                          .data!
                                          .length;
                                  i++) {
                                if (AllProductsCubit.get(context)
                                        .allProductsModel!
                                        .data![i]
                                        .id ==
                                    int.parse(item.id)) {
                                  data = AllProductsCubit.get(context)
                                      .allProductsModel!
                                      .data![i];
                                }
                              }
                              NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: VendorProductDetails(
                                    productData: data!,
                                  ));
                            } else {
                              int? categoryIndex;
                              for (int i = 0;
                                  i <
                                      AllCategoriesCubit.get(context)
                                          .categoriesIDs
                                          .length;
                                  i++) {
                                if (AllCategoriesCubit.get(context)
                                        .categoriesIDs[i] ==
                                    int.parse(item.id)) {
                                  categoryIndex = i;
                                }
                              }
                              ProductsCubit.get(context)
                                  .getProductsByCategoryId(
                                      categoryId: int.parse(item.id));
                              NavigationUtils.navigateBack(context: context);
                              BottomNavbarCubit.get(context)
                                  .changeBottomNavbar(2);
                              SelectCategoriesCubit.get(context)
                                  .selectCategory(categoryIndex!);
                            }
                          },
                        )

                        // DefaultTextFormField(
                        //   textInputType: TextInputType.text,
                        //   controller: searchController,
                        //   contentPaddingHorizontal: 20,
                        //   isFilled: true,
                        //   fillColor: Colors.white,
                        //   borderRadius: 30.sp,
                        //   hintText: "search".tr(),
                        //   suffixIcon: IconButton(
                        //     icon: Icon(Icons.search),
                        //     onPressed: () {
                        //       if (searchController.text.isNotEmpty) {
                        //         NavigationUtils.navigateTo(
                        //             context: context,
                        //             destinationScreen: SearchScreen(
                        //                 product: searchController.text));
                        //         searchController.clear();
                        //       }
                        //     },
                        //   ),
                        //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        //         color: Color.fromRGBO(195, 195, 195, 1),
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 14.sp,
                        //       ),
                        //   onFilledSubmit: (value) {
                        //     if (searchController.text.isNotEmpty) {
                        //       NavigationUtils.navigateTo(
                        //           context: context,
                        //           destinationScreen:
                        //               SearchScreen(product: value));
                        //       searchController.clear();
                        //     }
                        //   },
                        // ),

                        ),
                    SizedBox(height: 10.h),

                    /// Categories
                    SizedBox(
                      height: 250.h,
                      child:
                          BlocBuilder<AllCategoriesCubit, AllCategoriesState>(
                        buildWhen: (previous, current) {
                          if (current is GetAllCategoriesLoadingState ||
                              current is GetAllCategoriesSuccessState ||
                              current is GetAllCategoriesErrorState) {
                            return true;
                          }
                          return false;
                        },
                        builder: (context, state) {
                          if (state is GetAllCategoriesSuccessState) {
                            var categoryModel = AllCategoriesCubit.get(context)
                                .allCategoriesModel;
                            return Column(
                              children: [
                                Headline(
                                  text: "categories".tr(),
                                  trailingText: 'view_all'.tr(),
                                  action: () {
                                    BottomNavbarCubit.get(context)
                                        .changeBottomNavbar(2);
                                    catIndex = 0;
                                    ProductsCubit.get(context)
                                        .getProductsByCategoryId(
                                            categoryId: categoryModel!
                                                .data![catIndex].id!);
                                  },
                                ),
                                SizedBox(height: 10.h),
                                Expanded(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categoryModel!.data!.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          BottomNavbarCubit.get(context)
                                              .changeBottomNavbar(2,
                                                  categoryDetails: true);
                                          SelectCategoriesCubit.get(context)
                                              .selectCategory(index);
                                          catIndex = index;

                                          print('cat index is $catIndex');

                                          ProductsCubit.get(context)
                                              .getProductsByCategoryId(
                                                  categoryId: categoryModel
                                                      .data![catIndex].id!);
                                        },
                                        child: Container(
                                          height: 70.h,
                                          width: 100.w,
                                          clipBehavior: Clip.antiAlias,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                          ),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                child:
                                                    DefaultCachedNetworkImage(
                                                  imageUrl: categoryModel
                                                      .data![index].image!,
                                                  imageHeight: 70.h,
                                                  imageWidth: 100.w,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              AnimatedText(
                                                  text: categoryModel
                                                      .data![index].name!,
                                                  style: AppTextStyle.bodyText()
                                                      .copyWith(
                                                          fontSize: 12.sp,
                                                          overflow: TextOverflow
                                                              .ellipsis)),
                                              // Text(
                                              //   categoryModel.data![index].name!,
                                              //   textAlign: TextAlign.center,
                                              //   style: Theme.of(context).textTheme.bodySmall,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // Expanded(
                                //   child: ListView.builder(
                                //     shrinkWrap: true,
                                //     scrollDirection: Axis.horizontal,
                                //     itemBuilder: (context, index) {
                                //       return

                                //        InkWell(
                                //         onTap: () {
                                //           BottomNavbarCubit.get(context)
                                //               .changeBottomNavbar(2,
                                //                   categoryDetails: true);
                                //           SelectCategoriesCubit.get(context)
                                //               .selectCategory(index);
                                //           catIndex = index;

                                //           ProductsCubit.get(context)
                                //               .getProductsByCategoryId(
                                //                   categoryId: categoryModel
                                //                       .data![catIndex].id!);
                                //         },
                                //         child: Container(
                                //           height: 70.h,
                                //           width: 100.w,
                                //           clipBehavior: Clip.antiAlias,
                                //           margin: EdgeInsets.symmetric(
                                //               horizontal: 10.w),
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(15.r),
                                //           ),
                                //           child: Column(
                                //             children: [
                                //               ClipRRect(
                                //                 borderRadius:
                                //                     BorderRadius.circular(15.r),
                                //                 child:
                                //                     DefaultCachedNetworkImage(
                                //                   imageUrl: categoryModel
                                //                       .data![index].image!,
                                //                   imageHeight: 70.h,
                                //                   imageWidth: 100.w,
                                //                   fit: BoxFit.contain,
                                //                 ),
                                //               ),
                                //               SizedBox(height: 5.h),
                                //               AnimatedText(
                                //                   text: categoryModel
                                //                       .data![index].name!,
                                //                   style: AppTextStyle.bodyText()
                                //                       .copyWith(
                                //                           fontSize: 12.sp,
                                //                           overflow: TextOverflow
                                //                               .ellipsis)),
                                //               // Text(
                                //               //   categoryModel.data![index].name!,
                                //               //   textAlign: TextAlign.center,
                                //               //   style: Theme.of(context).textTheme.bodySmall,
                                //               // ),
                                //             ],
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //     itemCount: categoryModel!.data!.length,
                                //   ),
                                // ),
                              ],
                            );
                          } else if (state is GetAllCategoriesLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetAllCategoriesErrorState) {
                            return Expanded(
                              child: CustomErrorWidget(
                                onTap: () {
                                  context
                                      .read<AllCategoriesCubit>()
                                      .getAllCategories();
                                },
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),

                    /// All Product
                    Headline(
                      text: "all_products".tr(),
                      trailingText: 'view_all'.tr(),
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AllProductsVendorScreen()));
                      },
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 120.h,
                      child: BlocBuilder<AllProductsCubit, AllProductsStates>(
                        builder: (context, state) {
                          if (state is GetAllProductsSuccessState) {
                            var prodcutsModel =
                                AllProductsCubit.get(context).allProductsModel;
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    NavigationUtils.navigateTo(
                                      context: context,
                                      destinationScreen: VendorProductDetails(
                                        productData: prodcutsModel.data![index],
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 2,
                                    color: Colors.white,
                                    surfaceTintColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      side: BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.3),
                                        width: 1.w,
                                      ),
                                    ),
                                    shadowColor: Colors.grey.withOpacity(0.5),
                                    child: Container(
                                      width: 100.w,
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      padding: EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            child: DefaultCachedNetworkImage(
                                              imageUrl: prodcutsModel
                                                  .data![index].image![0],
                                              imageHeight: 60.h,
                                              imageWidth: 100.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AnimatedText(
                                                    text: prodcutsModel
                                                        .data![index].name!,
                                                    style: AppTextStyle
                                                            .bodyText()
                                                        .copyWith(
                                                            fontSize: 12.sp,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: AppColors
                                                                .primaryColor)),
                                                prodcutsModel.data![index]
                                                            .name2 !=
                                                        null
                                                    ? SizedBox(
                                                        height: 5.h,
                                                      )
                                                    : SizedBox(),
                                                prodcutsModel.data![index]
                                                            .name2 !=
                                                        null
                                                    ? AnimatedText(
                                                        text: prodcutsModel
                                                                .data![index]
                                                                .name2 ??
                                                            "",
                                                        style: AppTextStyle
                                                                .bodyText()
                                                            .copyWith(
                                                          fontSize: 10.sp,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ))
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: prodcutsModel!.data!.length,
                            );
                          } else if (state is GetAllProductsLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetAllProductsErrorState) {
                            return Expanded(
                              child: CustomErrorWidget(
                                onTap: () {
                                  context
                                      .read<AllProductsCubit>()
                                      .getAllProducts();
                                },
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),

                    /// Eco Friendly
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "ech_friendly".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Color.fromRGBO(115, 169, 51, 1),
                                    fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text: " " + "friendly".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EchoFriendlyProducts()));
                          },
                          child: Text(
                            'view_all'.tr(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 125.h,
                      child: BlocBuilder<EcoFriendlyCubit, EcoFriendlyState>(
                        builder: (context, state) {
                          if (state is GetEchoFriendlySuccessState) {
                            var echoModelsList = EcoFriendlyCubit.get(context)
                                .echoFriendlyModels;
                            return ListView.builder(
                              clipBehavior: Clip.none,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (CacheKeysManger
                                            .getUserTokenFromCache() ==
                                        "") {
                                      defaultLogin(context: context);
                                    } else {
                                      productModel.Data? productData;
                                      for (int i = 0;
                                          i <
                                              AllProductsCubit.get(context)
                                                  .allProductsModel!
                                                  .data!
                                                  .length;
                                          i++) {
                                        if (echoModelsList[index].id ==
                                            AllProductsCubit.get(context)
                                                .allProductsModel!
                                                .data![i]
                                                .id) {
                                          productData =
                                              AllProductsCubit.get(context)
                                                  .allProductsModel!
                                                  .data![i];
                                        }
                                      }

                                      NavigationUtils.navigateTo(
                                        context: context,
                                        destinationScreen: VendorProductDetails(
                                          productData: productData!,
                                        ),
                                      );
                                    }
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 120.w,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        padding: EdgeInsets.all(5.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          border: Border.all(
                                            color:
                                                Color.fromRGBO(115, 169, 51, 1),
                                            width: 2.w,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                              child: DefaultCachedNetworkImage(
                                                imageUrl: echoModelsList[index]
                                                    .image!,
                                                imageHeight: 60.h,
                                                imageWidth: 120.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),

                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AnimatedText(
                                                    text: echoModelsList[index]
                                                        .name!,
                                                    style:
                                                        AppTextStyle.bodyText()
                                                            .copyWith(
                                                      fontSize: 12.sp,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  echoModelsList[index].name2 !=
                                                          null
                                                      ? SizedBox(
                                                          height: 5.h,
                                                        )
                                                      : SizedBox(),
                                                  echoModelsList[index].name2 !=
                                                          null
                                                      ? AnimatedText(
                                                          text: echoModelsList[
                                                                      index]
                                                                  .name2 ??
                                                              "",
                                                          style: AppTextStyle
                                                                  .bodyText()
                                                              .copyWith(
                                                            fontSize: 10.sp,
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),

                                            // Text(
                                            //   echoModelsList[index].name!,
                                            //   textAlign: TextAlign.center,
                                            //   overflow: TextOverflow.ellipsis,
                                            // style:
                                            //     Theme.of(context).textTheme.bodySmall,
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: -20.h,
                                        right: -15.w,
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          padding: EdgeInsets.all(20),
                                          child: Container(
                                            height: 18.h,
                                            width: 18.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(100)
                                                //more than 50% of width makes circle
                                                ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -20.h,
                                        right: -10.w,
                                        child: Image.asset(
                                          Assets.imagesEcoFriendly,
                                          filterQuality: FilterQuality.high,
                                          height: 50.h,
                                          width: 50.w,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: echoModelsList.length,
                            );
                          } else if (state is GetEchoFriendlyLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetEchoFriendlyErrorState) {
                            return Expanded(
                              child: CustomErrorWidget(
                                onTap: () {
                                  context
                                      .read<EcoFriendlyCubit>()
                                      .getEchoFirendly();
                                },
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                    // SizedBox(height: 30.h),

                    /// Eco UnFriendly
                    // BlocBuilder<AllProductsCubit, AllProductsStates>(
                    //   builder: (context, state) {
                    //     if (state is GetAllProductsSuccessState) {
                    //       var echoModelsList = AllProductsCubit.get(context)
                    //           .allProductsModel!
                    //           .data!
                    //           .where(
                    //               (element) => element.status == 'unfriendly')
                    //           .toList();
                    //
                    //       return echoModelsList.isEmpty
                    //           ? SizedBox()
                    //           : Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 RichText(
                    //                   text: TextSpan(
                    //                     text: "eco".tr(),
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .bodyMedium!
                    //                         .copyWith(
                    //                             color: Color.fromRGBO(
                    //                                 115, 169, 51, 1),
                    //                             fontWeight: FontWeight.w500),
                    //                     children: [
                    //                       TextSpan(
                    //                           text: " " + "un_friendly".tr(),
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyMedium!
                    //                               .copyWith(
                    //                                   fontWeight:
                    //                                       FontWeight.w500)),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 SizedBox(height: 20.h),
                    //                 SizedBox(
                    //                   height: 125.h,
                    //                   child: ListView.builder(
                    //                     clipBehavior: Clip.none,
                    //                     shrinkWrap: true,
                    //                     scrollDirection: Axis.horizontal,
                    //                     itemBuilder: (context, index) {
                    //                       return InkWell(
                    //                         onTap: () {
                    //                           // productModel.Data? productData;
                    //                           // for (int i = 0;
                    //                           //     i <
                    //                           //         AllProductsCubit.get(
                    //                           //                 context)
                    //                           //             .allProductsModel!
                    //                           //             .data!
                    //                           //             .length;
                    //                           //     i++) {
                    //                           //   if (echoModelsList[index].id ==
                    //                           //       AllProductsCubit.get(
                    //                           //               context)
                    //                           //           .allProductsModel!
                    //                           //           .data![i]
                    //                           //           .id) {
                    //                           //     productData =
                    //                           //         AllProductsCubit.get(
                    //                           //                 context)
                    //                           //             .allProductsModel!
                    //                           //             .data![i];
                    //                           //   }
                    //                           // }
                    //
                    //                           NavigationUtils.navigateTo(
                    //                             context: context,
                    //                             destinationScreen:
                    //                                 VendorProductDetails(
                    //                               productData:
                    //                                   echoModelsList[index],
                    //                             ),
                    //                           );
                    //                         },
                    //                         child: Stack(
                    //                           clipBehavior: Clip.none,
                    //                           children: [
                    //                             Container(
                    //                               width: 120.w,
                    //                               margin: EdgeInsets.symmetric(
                    //                                   horizontal: 10.w),
                    //                               padding: EdgeInsets.all(5.w),
                    //                               decoration: BoxDecoration(
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         15.r),
                    //                                 border: Border.all(
                    //                                   color: Color.fromRGBO(
                    //                                       115, 169, 51, 1),
                    //                                   width: 2.w,
                    //                                 ),
                    //                               ),
                    //                               child: Column(
                    //                                 children: [
                    //                                   ClipRRect(
                    //                                     borderRadius:
                    //                                         BorderRadius
                    //                                             .circular(15.r),
                    //                                     child:
                    //                                         DefaultCachedNetworkImage(
                    //                                       imageUrl:
                    //                                           echoModelsList[
                    //                                                   index]
                    //                                               .image![0],
                    //                                       imageHeight: 60.h,
                    //                                       imageWidth: 120.w,
                    //                                       fit: BoxFit.cover,
                    //                                     ),
                    //                                   ),
                    //
                    //                                   Expanded(
                    //                                     child: Column(
                    //                                       mainAxisAlignment:
                    //                                           MainAxisAlignment
                    //                                               .center,
                    //                                       children: [
                    //                                         AnimatedText(
                    //                                           text:
                    //                                               echoModelsList[
                    //                                                       index]
                    //                                                   .name!,
                    //                                           style: AppTextStyle
                    //                                                   .bodyText()
                    //                                               .copyWith(
                    //                                             fontSize: 12.sp,
                    //                                             overflow:
                    //                                                 TextOverflow
                    //                                                     .ellipsis,
                    //                                             color: AppColors
                    //                                                 .primaryColor,
                    //                                           ),
                    //                                         ),
                    //                                         echoModelsList[index]
                    //                                                     .name2 !=
                    //                                                 null
                    //                                             ? SizedBox(
                    //                                                 height: 5.h,
                    //                                               )
                    //                                             : SizedBox(),
                    //                                         echoModelsList[index]
                    //                                                     .name2 !=
                    //                                                 null
                    //                                             ? AnimatedText(
                    //                                                 text: echoModelsList[index]
                    //                                                         .name2 ??
                    //                                                     "",
                    //                                                 style: AppTextStyle
                    //                                                         .bodyText()
                    //                                                     .copyWith(
                    //                                                   fontSize:
                    //                                                       10.sp,
                    //                                                 ),
                    //                                               )
                    //                                             : SizedBox(),
                    //                                       ],
                    //                                     ),
                    //                                   ),
                    //
                    //                                   // Text(
                    //                                   //   echoModelsList[index].name!,
                    //                                   //   textAlign: TextAlign.center,
                    //                                   //   overflow: TextOverflow.ellipsis,
                    //                                   // style:
                    //                                   //     Theme.of(context).textTheme.bodySmall,
                    //                                   // ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                             Positioned(
                    //                               top: -20.h,
                    //                               right: -15.w,
                    //                               child: Container(
                    //                                 alignment:
                    //                                     Alignment.topCenter,
                    //                                 padding: EdgeInsets.all(20),
                    //                                 child: Container(
                    //                                   height: 18.h,
                    //                                   width: 18.h,
                    //                                   decoration: BoxDecoration(
                    //                                       color: Colors.white,
                    //                                       borderRadius:
                    //                                           BorderRadius
                    //                                               .circular(100)
                    //                                       //more than 50% of width makes circle
                    //                                       ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             Positioned(
                    //                               top: -20.h,
                    //                               right: -10.w,
                    //                               child: Image.asset(
                    //                                 Assets.imagesEcoFriendly,
                    //                                 filterQuality:
                    //                                     FilterQuality.high,
                    //                                 height: 50.h,
                    //                                 width: 50.w,
                    //                                 fit: BoxFit.contain,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       );
                    //                     },
                    //                     itemCount: echoModelsList.length,
                    //                   ),
                    //                 ),
                    //                 SizedBox(height: 30.h),
                    //               ],
                    //             );
                    //     } else if (state is GetAllProductsLoadingState) {
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     } else if (state is GetAllProductsErrorState) {
                    //       return Expanded(
                    //         child: CustomErrorWidget(
                    //           onTap: () {
                    //             context
                    //                 .read<AllProductsCubit>()
                    //                 .getAllProducts();
                    //           },
                    //         ),
                    //       );
                    //     } else {
                    //       return SizedBox();
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    /// Payment terms
                    Headline(
                      text: "payment_terms".tr(),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          child: Image.asset(
                            CacheKeysManger.getLanguageFromCache() == "ar"
                                ? "assets/images/payment_no_design_ar.jpeg"
                                : "assets/images/payment_no_design_en.jpeg",
                            width: MediaQuery.of(context).size.width * .4,
                          ),
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          child: Image.asset(
                            CacheKeysManger.getLanguageFromCache() == "ar"
                                ? "assets/images/payment_design_ar.jpeg"
                                : "assets/images/payment_design_en.jpeg",
                            width: MediaQuery.of(context).size.width * .4,
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    // todo slider for cutomize product
                    Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/customize_products.png',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * .9,
                          ),
                          Text(
                            'customize_your_product'.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primaryColor),
                            onPressed: () {
                              file = null;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomProductScreen()));
                            },
                            child: Text(
                              'see_more'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),

                    SizedBox(height: 15.h),

                    /// Our Customers
                    BlocBuilder<AllCustomersCubit, AllCustomersState>(
                      builder: (context, state) {
                        if (state is GetAllCustomersSuccessState) {
                          var allCustomers =
                              AllCustomersCubit.get(context).mainCustomerModels;
                          return allCustomers.isEmpty
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Headline(
                                      text: "our_customers".tr(),
                                    ),
                                    SizedBox(
                                      height: 60.h,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 60.h,
                                            width: 60.w,
                                            clipBehavior: Clip.antiAlias,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    87, 116, 86, 1),
                                                width: 1.w,
                                                strokeAlign: BorderSide
                                                    .strokeAlignOutside,
                                              ),
                                            ),
                                            child: DefaultCachedNetworkImage(
                                              imageUrl:
                                                  allCustomers[index].image!,
                                              imageHeight: 80.h,
                                              imageWidth: 100.w,
                                              fit: BoxFit.contain,
                                            ),
                                          );
                                        },
                                        itemCount: allCustomers.length,
                                      ),
                                    ),
                                  ],
                                );
                        } else if (state is GetAllCustomersLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetAllCustomersErrorState) {
                          return CustomErrorWidget(
                            onTap: () {
                              context
                                  .read<AllCustomersCubit>()
                                  .getAllCustomers();
                            },
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: BlocBuilder<DiscussionCubit, DiscussionState>(
                  builder: (context, state) {
                    if (state is GetAllDiscussionsSuccessState) {
                      return state.model.data!.isEmpty ||
                              state.model.data != null
                          ? SizedBox()
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: DefaultCachedNetworkImage(
                                        imageUrl: EndPoints.discussions +
                                            state.model.data![index].icon!,
                                        imageHeight: 30.h,
                                        imageWidth: 60.w,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Flexible(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        maxLines: 4,
                                        state.model.data![index].description!,
                                        style: AppTextStyle.bodyText().copyWith(
                                            fontSize: 10.sp,
                                            color: AppColors.primaryColor,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemCount: state.model.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 20,
                                childAspectRatio: .7 / 1,
                                crossAxisCount: 3,
                              ),
                            );
                    } else if (state is GetAllDiscussionsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetAllDiscussionsErrorState) {
                      return Expanded(
                        child: CustomErrorWidget(
                          onTap: () {
                            context.read<DiscussionCubit>().getAllDiscussions();
                          },
                        ),
                      );
                    } else {
                      print("here");
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
