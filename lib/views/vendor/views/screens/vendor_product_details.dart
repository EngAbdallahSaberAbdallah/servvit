import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/shared_components/headline_text.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:echo/views/vendor/views/widgets/build_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/shared_components/custom_carousel_slider.dart';
import '../../../../core/utils/assets.dart';
import '../../../../cubits/supplier_market/supplier_market_cubit.dart';
import '../../../../cubits/supplier_market/supplier_market_states.dart';
import '../../../../model/products/vendor_product_model.dart';
import '../widgets/supplier_for_product_size_widget.dart';
import 'custom_product.dart';

class VendorProductDetails extends StatefulWidget {
  const VendorProductDetails({
    super.key,
    required this.productData,
  });

  final Data productData;

  @override
  State<VendorProductDetails> createState() => _VendorProductDetailsState();
}

class _VendorProductDetailsState extends State<VendorProductDetails> {
  @override
  void initState() {
    super.initState();
    // 1: get product id
    // 2: get sizes of this product by calling api
    ProductsCubit.get(context).getProductSizes(widget.productData.id!);
    SupplierMarketCubit.get(context).notifyNoSuppliersForProductSize();
  }

  @override
  Widget build(BuildContext context) {
    log('============================================================\nproduct_id: ${widget.productData.id}');
    return WillPopScope(
      onWillPop: () async {
        ProductsCubit.get(context).releaseProductSize();
        print(
            'products in market are ${ProductsCubit.get(context).allProductsModelP!.data}');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            Assets.imagesLogo2,
            width: 100.w,
            height: 40.h,
            fit: BoxFit.contain,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 50.h,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              Assets.imagesIconBackSquare,
              height: 20.h,
              color: AppColors.primaryColor,
            ),
          ),
          actions: CacheKeysManger.getUserTokenFromCache() == ""
              ? null
              : [BuildCartIcon()],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: _buildProductDetails(),
                ),
                SizedBox(height: 15.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_border_purple500_rounded,
                        color: Colors.green,
                      ),
                      Expanded(
                        child: Text(
                          "${'health_ministry'.tr()}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Headline(text: 'suppliers'.tr()),
                _buildSuppliersDetails(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuppliersDetails() {
    return BlocBuilder<SupplierMarketCubit, SupplierMarketStates>(
      builder: (context, state) {
        if (state is GetSuppliersWithProductSizeSuccessState) {
          var supplier =
              SupplierMarketCubit.get(context).supplierProductsModelForSize;
          return Container(
            // height: 145.h * supplier!.data!.length,
            constraints: BoxConstraints(
              maxHeight: 145.h * supplier!.data!.length + 20.h,
            ),
            child: ListView.builder(
              itemCount: supplier.data!.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  child: SupplierForProductSize(
                    supplierProductSize: supplier.data![index],
                    productData: widget.productData,
                  ),
                );
              },
            ),
          );
        }
        if (state is NoSuppliersForProductSize) {
          return Container(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/no_suppliers.png',
                  color: Colors.grey.shade300,
                  width: MediaQuery.of(context).size.width * .18,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "no_suppliers".tr(),
                  style: AppTextStyle.bodyText()
                      .copyWith(color: Colors.grey.shade400),
                ),
              ],
            ),
          );
        }
        if (state is GetSuppliersWithProductSizeErrorState) {
          return Center(
            child: CustomErrorWidget(
              onTap: () {
                SupplierMarketCubit.get(context)
                    .notifyNoSuppliersForProductSize();
              },
            ),
          );
        }
        return SizedBox(
          height: 400.h,
          child: Shimmer.fromColors(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                height: 90.h,
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                ),
              ),
            ),
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[200]!,
          ),
        );
      },
    );
  }

  Widget _buildProductDetails() {
    return Column(
      children: [
        widget.productData.image!.length != 1
            ?
            //! display slider of images
            CustomCarouselItem(
                imageHeight: MediaQuery.of(context).size.height * .3,
                images: widget.productData.image!,
                viewportFraction: .7,
              )
            : Hero(
                tag: '${widget.productData.id}',
                child: CachedNetworkImage(
                  imageUrl: widget.productData.image![0],
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.sizeOf(context).width - 30.w,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) =>
                      Center(), //child: Icon(Icons.error)
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
        SizedBox(height: 20.h),
        Text(
            '${widget.productData.name} ${widget.productData.name != null ? " ${widget.productData.name2 != null ? "-${widget.productData.name2}" : ""}" : ""} ',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500)),
        SizedBox(height: 10.h),
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                'description'.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                    ),
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(
                '${widget.productData.description}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ],
        ),
        if (widget.productData.category!.name != null) SizedBox(height: 10.h),
        if (widget.productData.category!.name != null)
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  'category'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12.sp),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Text(
                  '${widget.productData.category!.name ?? ""}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ],
          ),
        if (widget.productData.color!.name != null) SizedBox(height: 10.h),
        if (widget.productData.color!.name != null)
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  'color'.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12.sp),
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Text(
                  '${widget.productData.color!.name}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ],
          ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                'size'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 12.sp),
              ),
            ),
            SizedBox(width: 10.w),
            BlocBuilder<ProductsCubit, ProductsStates>(
              builder: (context, state) {
                var productSizes = ProductsCubit.get(context).productSizes;
                if (state is GetSizesOfProductLoadingState) {
                  return Flexible(
                    flex: 3,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                //! for first time loading the screen
                if (state is GetSizesOfProductSuccessState) {
                  triggerProductSize(productSizes.first.size, productSizes);
                }
                if (state is GetSizesOfProductFailureState) {
                  return Center(
                    child: CustomErrorWidget(
                      onTap: () {
                        ProductsCubit.get(context)
                            .getProductSizes(widget.productData.id!);
                      },
                    ),
                  );
                }
                return Flexible(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    // width: 60.w,
                    height: 25.h,
                    child: ProductsCubit.get(context).productSizes.isEmpty
                        ? Text('no_sizes'.tr())
                        : DropdownButton<String>(
                            elevation: 3,
                            padding: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(10.r),
                            iconEnabledColor: AppColors.primaryColor,
                            iconDisabledColor: AppColors.greyColor,
                            iconSize: 20.sp,
                            isExpanded: true,
                            underline: SizedBox(),
                            items: productSizes
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.size!,
                                    child: Text(
                                      e.size!,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                )
                                .toList(),
                            value: state is SelectProductSizeState
                                ? state.size
                                : productSizes.first.size!,
                            onChanged: ((value) {
                              if (value == 'other') {
                                //todo navigate to customize page
                                // NavigationUtils.navigateTo(
                                //     context: context,
                                //     destinationScreen: CustomProductScreen(
                                //       productDetails: widget.productData,
                                //     ));
                              } else {
                                ProductsCubit.get(context)
                                    .selectProductSize(value!);
                                var sizeId = productSizes
                                    .firstWhere((productSize) =>
                                        productSize.size == value)
                                    .id;
                                SupplierMarketCubit.get(context)
                                    .getSuppliersWithProductSize(
                                        sizeId: sizeId!,
                                        productId: widget.productData.id!);
                              }
                            }),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
        if (ProductsCubit.get(context).otherSize == "yes")
          SizedBox(height: 10.h),
        if (ProductsCubit.get(context).otherSize == "yes")
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  "not_found_size".tr(),
                  style: AppTextStyle.title(),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: CustomProductScreen(
                          productDetails: widget.productData,
                        ));
                  },
                  child: Container(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 10.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: Text(
                      "specify_your_size".tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyle.subTitle().copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  void triggerProductSize(String? value, var productSizes) {
    ProductsCubit.get(context).selectProductSize(value!);
    var sizeId =
        productSizes.firstWhere((productSize) => productSize.size == value).id;
    SupplierMarketCubit.get(context).getSuppliersWithProductSize(
        sizeId: sizeId!, productId: widget.productData.id!);
  }
}
