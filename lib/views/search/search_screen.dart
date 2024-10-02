import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/all_categories/all_categories_cubit.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:echo/views/vendor/views/screens/vendor_product_details.dart';
import 'package:echo/views/vendor/views/widgets/animated_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:echo/model/products/vendor_product_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cubits/all_products/all_products_cubit.dart';
import '../../cubits/select_category/select_categories_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.product}) : super(key: key);
  final String product;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    ProductsCubit.get(context).search(product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Image.asset(
            "assets/images/logo2.png",
            width: 100.w,
            height: 40.h,
            fit: BoxFit.contain,
          ),
          // backgroundColor: Colors.,
          elevation: 0,
        ),
        body: BlocBuilder<ProductsCubit, ProductsStates>(
            builder: (context, state) {
          var cubit = ProductsCubit.get(context);
          return state is GetSearchDataLoadingState
              ? const Center(child: CircularProgressIndicator())
              : state is GetSearchDataErrorState
                  ? Center(
                      child: CustomErrorWidget(
                        onTap: () {
                          ProductsCubit.get(context)
                              .search(product: widget.product);
                        },
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      children: [
                        Text(
                          "categories".tr(),
                          style: AppTextStyle.headLine()
                              .copyWith(color: Colors.black),
                        ),
                        cubit.searchModel!.categories!.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    cubit.searchModel!.categories!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20.w,
                                  mainAxisSpacing: 20.h,
                                  childAspectRatio: 1.2,
                                ),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    int? categoryIndex;
                                    for (int i = 0;
                                        i <
                                            AllCategoriesCubit.get(context)
                                                .categoriesIDs
                                                .length;
                                        i++) {
                                      if (AllCategoriesCubit.get(context)
                                              .categoriesIDs[i] ==
                                          cubit.searchModel!.categories![index]
                                              .id) {
                                        categoryIndex = i;
                                      }
                                    }

                                    ProductsCubit.get(context)
                                        .getProductsByCategoryId(
                                            categoryId: cubit.searchModel!
                                                .categories![index].id!);
                                    NavigationUtils.navigateBack(
                                        context: context);
                                    BottomNavbarCubit.get(context)
                                        .changeBottomNavbar(2);
                                    SelectCategoriesCubit.get(context)
                                        .selectCategory(categoryIndex!);
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            DefaultCachedNetworkImage(
                                              imageUrl: EndPoints.categories +
                                                  cubit
                                                      .searchModel!
                                                      .categories![index]
                                                      .image!,
                                              imageHeight: 60.h,
                                              imageWidth: 100.w,
                                              fit: BoxFit.cover,
                                            ),
                                            Expanded(
                                              child: Text(
                                                cubit.searchModel!
                                                    .categories![index].name
                                                    .toString(),
                                                style: AppTextStyle.title(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                "no_categories".tr(),
                                style: AppTextStyle.subTitle(),
                              )),
                        Text(
                          "products".tr(),
                          style: AppTextStyle.headLine()
                              .copyWith(color: Colors.black),
                        ),
                        cubit.searchModel!.products!.isNotEmpty
                            ? GridView.builder(
                                itemCount: cubit.searchModel!.products!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20.w,
                                  mainAxisSpacing: 20.h,
                                  childAspectRatio: 0.75,
                                ),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            side: BorderSide(
                                              // color: Color.fromRGBO(0, 0, 0, 0.3),
                                              width: 1.w,
                                            ),
                                          ),
                                          shadowColor:
                                              Colors.grey.withOpacity(0.5),
                                          child: Container(
                                            // width: 100.w,
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
                                                      BorderRadius.circular(
                                                          15.r),
                                                  child:
                                                      DefaultCachedNetworkImage(
                                                    imageUrl: EndPoints
                                                            .products +
                                                        cubit
                                                            .searchModel!
                                                            .products![index]
                                                            .image!
                                                            .first,
                                                    imageHeight: 60.h,
                                                    imageWidth: 100.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AnimatedText(
                                                          text: cubit
                                                              .searchModel!
                                                              .products![index]
                                                              .name!,
                                                          style: AppTextStyle
                                                                  .bodyText()
                                                              .copyWith(
                                                                  fontSize:
                                                                      12.sp,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: AppColors
                                                                      .primaryColor)),
                                                      cubit
                                                                  .searchModel!
                                                                  .products![
                                                                      index]
                                                                  .name2 !=
                                                              null
                                                          ? SizedBox(
                                                              height: 5.h,
                                                            )
                                                          : SizedBox(),
                                                      cubit
                                                                  .searchModel!
                                                                  .products![
                                                                      index]
                                                                  .name2 !=
                                                              null
                                                          ? AnimatedText(
                                                              text: cubit
                                                                      .searchModel!
                                                                      .products![
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      DefaultButton(
                                        onPress: () {
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
                                                cubit.searchModel!
                                                    .products![index].id) {
                                              data =
                                                  AllProductsCubit.get(context)
                                                      .allProductsModel!
                                                      .data![i];
                                            }
                                          }
                                          NavigationUtils.navigateTo(
                                              context: context,
                                              destinationScreen:
                                                  VendorProductDetails(
                                                productData: data!,
                                              ));
                                        },
                                        text: "see_details".tr(),
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        backgroundColor:
                                            AppColors.secondaryColor,
                                        height: 0.h,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                "no_products".tr(),
                                style: AppTextStyle.subTitle(),
                              ))
                      ],
                    );
        }));
  }
}
