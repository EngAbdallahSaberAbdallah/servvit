import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/shared_components/login_first.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/utils/functions.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:echo/model/products/vendor_product_model.dart' as productModel;
import 'package:echo/model/suppliers_product_size/supplier_product_size_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/number_format.dart';
import '../screens/vendor_add_to_cart.dart';

class SupplierForProductSize extends StatefulWidget {
  const SupplierForProductSize({
    super.key,
    required this.supplierProductSize,
    required this.productData,
  });
  final Data supplierProductSize;
  final productModel.Data productData;

  @override
  State<SupplierForProductSize> createState() => _SupplierForProductSizeState();
}

class _SupplierForProductSizeState extends State<SupplierForProductSize> {
  @override
  Widget build(BuildContext context) {
    log(widget.supplierProductSize.suppliers!.id!.ft());
    return Card(
      elevation: 5,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: Color.fromRGBO(171, 164, 164, 1),
          width: 1.w,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      //! deleveriy time and supplier
                      Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(
                                  Icons.factory_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                'SU-${widget.supplierProductSize.suppliers!.id}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12.sp,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'delivery_time'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 10.sp),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'time_from'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 12.sp),
                                      ),
                                      SizedBox(height: 2.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                            // border: Border.all(
                                            //   color: Color.fromRGBO(
                                            //       171, 164, 164, 1),
                                            //   width: 1.w,
                                            // ),
                                            ),
                                        child: Text(
                                          '${widget.supplierProductSize.productSizes![0].from}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 10.sp),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    children: [
                                      Text(
                                        'time_to'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 12.sp),
                                      ),
                                      SizedBox(height: 2.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                            // border: Border.all(
                                            //   color: Color.fromRGBO(
                                            //       171, 164, 164, 1),
                                            //   width: 1.w,
                                            // ),
                                            ),
                                        child: Text(
                                          '${widget.supplierProductSize.productSizes![0].to}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 10.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 5.w),
                                  Container(
                                    padding: EdgeInsetsDirectional.only(
                                        bottom: 2.h, end: 2.w),
                                    child: Text(
                                      'day'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 10.sp),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
                //todo(quantity1 quantity2) make with delivery time and supplier
                Expanded(
                  child: SizedBox(
                    height: 45.h,
                    width: MediaQuery.of(context).size.width - 80.w,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (Functions.getNumberFormatFunc(
                                    widget.supplierProductSize.productSizes![0]
                                        .quantity1!,
                                    convertAfter: 3) !=
                                "0.0")
                              Column(
                                // clipBehavior: Clip.none,
                                children: [
                                  Card(
                                    clipBehavior: Clip.none,
                                    elevation: 5,
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      side: BorderSide(
                                        color: Color.fromRGBO(171, 164, 164, 1),
                                        width: 1.w,
                                      ),
                                    ),
                                    child: Container(
                                      color: Colors.white,
                                      constraints: BoxConstraints(
                                        // minWidth: 40.w,
                                        // maxWidth: 55.w,
                                        minHeight: 5.h,
                                        maxHeight: 20.h,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7.w, vertical: 5.h),
                                      child: Text(
                                        '${Functions.getNumberWithTextFormatFunc(widget.supplierProductSize.productSizes![0].quantity1!, convertAfter: 3)} <',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 10.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      minHeight: 5.h,
                                      maxHeight: 20.h,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      '${Functions.getNumberWithTextFormatFunc(widget.supplierProductSize.productSizes![0].price1!, convertAfter: 5)} ${"egy".tr()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 9.sp,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              width: 5.w,
                            ),
                            if (Functions.getNumberFormatFunc(
                                    widget.supplierProductSize.productSizes![0]
                                        .quantity2!,
                                    convertAfter: 3) !=
                                "0.0")
                              Column(
                                // clipBehavior: Clip.none,
                                children: [
                                  Card(
                                    clipBehavior: Clip.none,
                                    elevation: 5,
                                    color: Colors.white,
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      side: BorderSide(
                                        color: Color.fromRGBO(171, 164, 164, 1),
                                        width: 1.w,
                                      ),
                                    ),
                                    child: Container(
                                      color: Colors.white,
                                      constraints: BoxConstraints(
                                        // minWidth: 40.w,
                                        // maxWidth: 55.w,
                                        minHeight: 5.h,
                                        maxHeight: 20.h,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7.w, vertical: 5.h),
                                      child: Text(
                                        '${Functions.getNumberWithTextFormatFunc(widget.supplierProductSize.productSizes?[0].quantity2, convertAfter: 3)} <',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 10.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      // minWidth: 20.w,
                                      // maxWidth: 50.w,
                                      minHeight: 5.h,
                                      maxHeight: 20.h,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      '${Functions.getNumberWithTextFormatFunc(widget.supplierProductSize.productSizes![0].price2, convertAfter: 5)} ${"egy".tr()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 9.sp,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              width: 5.w,
                            ),
                            if (Functions.getNumberFormatFunc(
                                    widget.supplierProductSize.productSizes![0]
                                        .quantity3!,
                                    convertAfter: 3) !=
                                "0.0")
                              Column(
                                children: [
                                  Card(
                                    clipBehavior: Clip.none,
                                    elevation: 5,
                                    color: Colors.white,
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      side: BorderSide(
                                        color: Color.fromRGBO(171, 164, 164, 1),
                                        width: 1.w,
                                      ),
                                    ),
                                    child: Container(
                                      color: Colors.white,
                                      constraints: BoxConstraints(
                                        // minWidth: 40.w,
                                        // maxWidth: 55.w,
                                        minHeight: 5.h,
                                        maxHeight: 20.h,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7.w, vertical: 5.h),
                                      child: Text(
                                        '${Functions.getNumberWithTextFormatFunc(widget.supplierProductSize.productSizes![0].quantity3, convertAfter: 3)} <',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 10.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      minHeight: 5.h,
                                      maxHeight: 20.h,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    // alignment: Alignment.center,
                                    child: Text(
                                      '${Functions.getNumberWithTextFormatFunc(widget.supplierProductSize.productSizes![0].price3, convertAfter: 5)} ${"egy".tr()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 9.sp,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.supplierProductSize.productSizes![0].minQuantity2 !=
                    "null" &&
                widget.supplierProductSize.productSizes![0].minQuantity2 !=
                    "0.0" &&
                widget.supplierProductSize.productSizes![0].minQuantity2 !=
                    null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: (widget.supplierProductSize.productSizes![0]
                                    .minQuantity2 !=
                                "null" &&
                            widget.supplierProductSize.productSizes![0]
                                    .minQuantity2 !=
                                "0.0" &&
                            widget.supplierProductSize.productSizes![0]
                                    .minQuantity2 !=
                                null)
                        ? BoxConstraints(
                            maxWidth: 65.w,
                            // minHeight: 40.h,
                          )
                        : null,
                    alignment: Alignment.center,
                    child: Text(
                      'min_quantity'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  // if (widget.supplierProductSize.productSizes![0]
                  //             .minQuantity2 !=
                  //         "null" &&
                  //     widget.supplierProductSize.productSizes![0]
                  //             .minQuantity2 !=
                  //         "0.0" &&
                  //     widget.supplierProductSize.productSizes![0]
                  //             .minQuantity2 !=
                  //         null)
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 65.w,
                    ),
                    child: Text(
                      'min_quantity_printed'.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            if (Functions.getNumberFormatFunc(widget
                        .supplierProductSize.productSizes![0].minQuantity2) !=
                    "0.0" &&
                Functions.getNumberFormatFunc(widget
                        .supplierProductSize.productSizes![0].minQuantity2) !=
                    "null")
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //! min1 and min2
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //       constraints: BoxConstraints(
                  //         maxWidth: 65.w,
                  //         // minHeight: 40.h,
                  //       ),
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         'min_quantity'.tr(),
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodySmall!
                  //             .copyWith(fontSize: 12.sp),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //     SizedBox(height: 3.h),
                  //     Card(
                  //       margin: EdgeInsets.zero,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         side: BorderSide(
                  //           color: Color.fromRGBO(171, 164, 164, 1),
                  //           width: 1.w,
                  //         ),
                  //       ),
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 5.w, vertical: 2.h),
                  //         child: Text(
                  //           '${Functions.getNumberFormatFunc(widget.supplierProductSize.productSizes![0].minQuantity)}',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodyMedium!
                  //               .copyWith(fontSize: 10.sp),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  Expanded(
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(
                          color: Color.fromRGBO(171, 164, 164, 1),
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: Text(
                            '${Functions.getNumberFormatFunc(widget.supplierProductSize.productSizes![0].minQuantity)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 10.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),

                  Expanded(
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(
                          color: Color.fromRGBO(171, 164, 164, 1),
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: Text(
                            '${Functions.getNumberFormatFunc(widget.supplierProductSize.productSizes![0].minQuantity2)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 10.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 10.w,
                  ),

                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //       constraints: BoxConstraints(
                  //         maxWidth: 65.w,
                  //       ),
                  //       child: Text(
                  //         'min_quantity_printed'.tr(),
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodySmall!
                  //             .copyWith(fontSize: 12.sp),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //     SizedBox(height: 3.h),
                  //     Card(
                  //       elevation: 3,
                  //       margin: EdgeInsets.zero,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //         side: BorderSide(
                  //           color: Color.fromRGBO(171, 164, 164, 1),
                  //           width: 1.w,
                  //         ),
                  //       ),
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 5.w, vertical: 2.h),
                  //         child: Text(
                  //           '${Functions.getNumberFormatFunc(widget.supplierProductSize.productSizes![0].minQuantity2)}',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodyMedium!
                  //               .copyWith(fontSize: 10.sp),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  ElevatedButton(
                    onPressed: () {
                      if (CacheKeysManger.getUserTokenFromCache() == "") {
                        defaultLogin(context: context);
                      } else {
                        NavigationUtils.navigateTo(
                          context: context,
                          destinationScreen: AddToVendorCart(
                            supplierProductSize: widget.supplierProductSize,
                            productDetails: widget.productData,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                      minimumSize: Size(50.w, 20.h),
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'add_to_Cart'.tr(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 8.sp,
                                    color: Colors.white,
                                  ),
                        ),
                        SizedBox(width: 2.w),
                        Icon(
                          CupertinoIcons.cart_fill_badge_plus,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () {
                      if (CacheKeysManger.getUserTokenFromCache() == "") {
                        defaultLogin(context: context);
                      } else {
                        ProductsCubit.get(context).getSample(
                            widget.supplierProductSize.productSizes![0].id!,
                            context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                      minimumSize: Size(50.w, 20.h),
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: BlocConsumer<ProductsCubit, ProductsStates>(
                      listener: (context, state) {
                        if (state is GetSampleSuccessState) {
                          toast(text: state.message, color: Colors.green);
                        }
                        if (state is GetSampleFailureState) {
                          toast(text: state.errorMessage, color: Colors.red);
                        }
                      },
                      buildWhen: (previous, current) {
                        if (ProductsCubit.get(context).context == context) {
                          return true;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        if (state is GetSampleLoadingState) {
                          return SizedBox(
                            height: 13.h,
                            width: 14.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.w,
                            ),
                          );
                        }
                        return Text(
                          'get_sample'.tr(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 8.sp,
                                    color: Colors.white,
                                  ),
                        );
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
