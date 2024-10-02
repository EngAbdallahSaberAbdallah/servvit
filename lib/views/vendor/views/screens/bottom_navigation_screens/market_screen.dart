import 'package:cached_network_image/cached_network_image.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/shared_components/headline_text.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/constants.dart';
import 'package:echo/model/customize_request/customize_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../cubits/all_categories/all_categories_cubit.dart';
import '../../../../../cubits/all_categories/all_categories_state.dart';
import '../../../../../cubits/products/products_cubit.dart';
import '../../../../../cubits/select_category/select_categories_cubit.dart';
import '../../../../../cubits/select_category/select_categories_state.dart';
import '../../widgets/standard_product_item.dart';

class VendorMarketScreen extends StatefulWidget {
  VendorMarketScreen({
    super.key,
  });

  @override
  State<VendorMarketScreen> createState() => _VendorMarketScreenState();
}

class _VendorMarketScreenState extends State<VendorMarketScreen> {
  // int? catIndex;

  @override
  void initState() {
    super.initState();
    final allCategoriesCubit = context.read<AllCategoriesCubit>();
    if (allCategoriesCubit.allCategoriesModel?.data != null &&
        allCategoriesCubit.allCategoriesModel!.data!.isNotEmpty) {
     
    }
    if (fromHome == true) {
      AllCategoriesCubit.get(context).getAllCategories();
       final firstCategoryId =
          allCategoriesCubit.allCategoriesModel!.data!.first.id!;
      ProductsCubit.get(context)
          .getProductsByCategoryId(categoryId: firstCategoryId);
      catIndex = 0; // Initialize catIndex to 0 (first category)
    }
    fromHome = false;
  }

  int tappedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = AllCategoriesCubit.get(context);
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// products Categories
          _buildProductCategories(cubit: cubit),
          SizedBox(height: 10.h),

          /// products
          BlocBuilder<SelectCategoriesCubit, SelectCategoriesState>(
            buildWhen: (previous, current) {
              if (current is SelectCategoryState) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is SelectCategoryState && catIndex != null) {
                return Text(
                  '${cubit.allCategoriesModel!.data![catIndex!].name}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 18.sp,
                      ),
                );
              }
              return SizedBox();
            },
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: BlocBuilder<ProductsCubit, ProductsStates>(
              builder: (context, state) {
                if (state is GetAllProductsByCategoryIdLoadingState) {
                  return Shimmer.fromColors(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 160.h,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[200]!,
                  );
                }
                if (state is GetAllProductsByCategoryIdErrorState) {
                  return Column(
                    children: [
                      CustomErrorWidget(onTap: () {
                        AllCategoriesCubit.get(context).getAllCategories();
                        final categories = context
                            .read<AllCategoriesCubit>()
                            .allCategoriesModel
                            ?.data;
                        if (categories != null &&
                            categories.isNotEmpty &&
                            catIndex != null &&
                            catIndex! < categories.length) {
                          ProductsCubit.get(context).getProductsByCategoryId(
                              categoryId: categories[catIndex!].id!);
                        } else {
                          // Handle the error or show an appropriate message
                          print(
                              'No categories available or index out of bounds');
                        }
                      }),
                    ],
                  );
                }
                if (
                    // state is GetAllProductsByCategoryIdSuccessState &&
                    ProductsCubit.get(context).allProductsModelP != null) {
                  return GridView.builder(
                    itemCount: ProductsCubit.get(context)
                        .allProductsModelP!
                        .data!
                        .length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 265.h,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 5.h,
                    ),
                    itemBuilder: (context, index) {
                      return StandardProductItem(
                        data: ProductsCubit.get(context)
                            .allProductsModelP!
                            .data![index],
                        clickedIndex: index,
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCategories({required AllCategoriesCubit cubit}) {
    return SizedBox(
      height: 110.h,
      child: BlocBuilder<AllCategoriesCubit, AllCategoriesState>(
        builder: (context, state) {
          if (state is GetAllCategoriesSuccessState) {
            var categories = cubit.allCategoriesModel!.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      catIndex = index;
                    });
                    ProductsCubit.get(context).getProductsByCategoryId(
                        categoryId: categories[index].id!);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SizedBox(
                      width: 100.w,
                      child: Column(
                        children: [
                          SizedBox(height: 5.h),
                          Container(
                            height: 60.h,
                            width: 80.w,
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: catIndex == index
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                width: 2.w,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: categories[index].image!,
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Expanded(
                            child: Text(
                              categories[index].name!,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (state is GetAllCategoriesLoadingState) {
            return Shimmer.fromColors(
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Container(
                    height: 60.h,
                    width: 80.w,
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[200]!,
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
