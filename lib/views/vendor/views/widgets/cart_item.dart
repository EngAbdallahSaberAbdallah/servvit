import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/functions.dart';
import 'package:echo/cubits/payment_method_cubit/payment_method_cubit.dart';
import 'package:echo/cubits/vendor_my_cart/vendor_my_cart_cubit.dart';
import 'package:echo/model/shipping_cost/shipping_cost_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/shared_components/default_cached_network_image.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../model/vendor_cart_model/vendor_cart_model.dart';

class CartItem extends StatelessWidget {
  CartItem({
    super.key,
    this.onRemove,
    required this.cart,
    this.isItPaymentProcess = false,
    required this.index,
    required this.isFromCartScreen,
  });
  final Function()? onRemove;
  final VendorCartModel cart;
  final bool isItPaymentProcess;
  late List<VendorCartModel> notDesignedProducts;
  final int index;
  final bool isFromCartScreen;

  @override
  Widget build(BuildContext context) {
    notDesignedProducts = VendorMyCartCubit.get(context).notDesignedProducts;
    notDesignedProducts = VendorMyCartCubit.get(context).notDesignedProducts;
    List<SupplierCost> getSupplierCosts(BuildContext context) {
      final PaymentMethodCubit paymentMethodCubit =
          PaymentMethodCubit.get(context);
      final shippingCostModel = paymentMethodCubit.shippingCostModel;
      return shippingCostModel?.supplierCosts ?? [];
    }

// Usage:
    final List<SupplierCost> suppliersCostsForNotPrintedProducts =
        getSupplierCosts(context);

    print(
        'list of supplier costs are ${suppliersCostsForNotPrintedProducts.map((e) => e.supplier)}');

    final totalCostOfItem = isFromCartScreen == false &&
            suppliersCostsForNotPrintedProducts.map((e) => e.supplier).length >
                0 &&
            suppliersCostsForNotPrintedProducts
                    .where((element) =>
                        cart.supplierProductSize != null &&
                        element.supplier ==
                            cart.supplierProductSize!.supplierProduct!
                                .suppliers!.id!)
                    .length >
                0
        ? suppliersCostsForNotPrintedProducts
                    .where((element) =>
                        element.supplier ==
                        cart.supplierProductSize!.supplierProduct!.suppliers!
                            .id!)
                    .first
                    .cost !=
                null
            ? double.parse(suppliersCostsForNotPrintedProducts
                    .where((element) =>
                        element.supplier ==
                        cart.supplierProductSize!.supplierProduct!.suppliers!.id!)
                    .first
                    .cost!) +
                double.parse(cart.totalCost!)
            : double.parse(cart.totalCost!)
        : double.parse(cart.totalCost!);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Card(
        color: Colors.white,
        elevation: 5,
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
          side: BorderSide(
            color: Color.fromRGBO(160, 160, 162, 1),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(5.sp),
          child: Stack(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showDesignImage(context);
                    },
                    child: Container(
                      height: 75.h,
                      width: 80.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: DefaultCachedNetworkImage(
                        imageUrl: cart.customizeProduct != null
                            ? cart.customizeProduct!.image!
                            : cart.supplierProductSize!.supplierProduct!
                                .products!.image![0],
                        imageHeight: 75.h,
                        imageWidth: 80.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),

                        //! supplier if not customized
                        if (cart.supplierProductSize != null)
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(
                                  '${'suppliers'.tr()}:',
                                  style: AppTextStyle.bodyText().copyWith(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Flexible(
                                flex: 3,
                                child: Text(
                                  'SU-${cart.supplierProductSize!.supplierProduct!.suppliers!.id!}', //  'AM374',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyText().copyWith(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 7.h),
                        Text(
                          cart.supplierProductSize!.supplierProduct!.products!
                                          .name! !=
                                      "" &&
                                  cart.supplierProductSize!.supplierProduct!
                                          .products!.name! !=
                                      null &&
                                  cart.supplierProductSize!.supplierProduct!
                                          .products!.name! !=
                                      "null"
                              ? 
                              "${"description".tr()}: "+ cart.supplierProductSize!.supplierProduct!
                                  .products!.name!:'customized_prodcut'.tr(),
                                  
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bodyText().copyWith(
                            fontSize: 11.sp,overflow: TextOverflow.ellipsis
                          ),
                        ),
                        
                        
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Text(
                                '${'quantity'.tr()}:',
                                style: AppTextStyle.bodyText().copyWith(
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Flexible(
                              flex: 3,
                              child: Text(
                                '${Functions.getNumberFormatFunc(
                                  cart.quantity!,
                                )} ${"piece".tr()}',
                                style: AppTextStyle.bodyText().copyWith(
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //! unit price if it is a sample
                        if (cart.sample == 'no')
                          Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text(
                                  '${'unit_price'.tr()}:',
                                  style: AppTextStyle.bodyText().copyWith(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Flexible(
                                flex: 3,
                                child: Text(
                                  '${Functions.getNumberFormatFunc(
                                    cart.pieceCost!,
                                  )} ${"egy".tr()}',
                                  style: AppTextStyle.bodyText().copyWith(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        //------------------------------------------
                        // if (notDesignedProducts.length == 1)
                        // CustomScrollView(
                        //   shrinkWrap: true,
                        //   slivers: [
                        //     SliverPadding(
                        //       padding: EdgeInsets.symmetric(vertical: 6.h),
                        //       sliver: SliverList.separated(
                        //         itemCount:
                        //             suppliersCostsForNotPrintedProducts.length,
                        //         itemBuilder: (context, index) {
                        //           return
                        //            Text(
                        //             '${'shipping_cost'.tr()}: ${suppliersCostsForNotPrintedProducts[index].cost!}',
                        //             textAlign: TextAlign.start,
                        //             style: AppTextStyle.bodyText().copyWith(
                        //               fontSize: 11.sp,
                        //             ),
                        //           );
                        //         },
                        //         separatorBuilder: (context, index) {
                        //           return SizedBox(height: 10.h);
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // TODO: تكلفة الشحن
                        isFromCartScreen == false &&
                                notDesignedProducts.length == 1 &&
                                suppliersCostsForNotPrintedProducts
                                        .map((e) => e.supplier)
                                        .length >
                                    0
                            ? suppliersCostsForNotPrintedProducts
                                        .where((element) =>
                                            element.supplier ==
                                            cart
                                                .supplierProductSize!
                                                .supplierProduct!
                                                .suppliers!
                                                .id!)
                                        .first
                                        .cost !=
                                    null
                                ? Text(
                                    '${'shipping_cost'.tr()}: ${suppliersCostsForNotPrintedProducts.where((element) => element.supplier == cart.supplierProductSize!.supplierProduct!.suppliers!.id!).first.cost}',
                                    textAlign: TextAlign.start,
                                    style: AppTextStyle.bodyText().copyWith(
                                      fontSize: 11.sp,
                                    ))
                                : const SizedBox()
                            : const SizedBox(),
                        //------------------------------------------
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Text(
                                '${'total_price'.tr()}:',
                                style: AppTextStyle.bodyText().copyWith(
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Flexible(
                              flex: 3,
                              child: Text(
                                '$totalCostOfItem ${"egy".tr()}',
                                // '${getNumberFormat(
                                //   cart.totalCostWithoutShipping!,
                                // )} ${"egy".tr()}',
                                style: AppTextStyle.bodyText().copyWith(
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //* if it in checkout process show it
                        if (isItPaymentProcess)
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(
                                  '${'shipping_cost'.tr()}:',
                                  style: AppTextStyle.bodyText().copyWith(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Flexible(
                                flex: 3,
                                child: Text(
                                  '${Functions.getNumberFormatFunc(
                                    cart.shippingCost!,
                                  )} ${"egy".tr()}',
                                  style: AppTextStyle.bodyText().copyWith(
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 5.h),
                        //------------------------------
                      ],
                    ),
                  ),
                ],
              ),
              // if (cart.customizeProduct != null)
              //   PositionedDirectional(
              //     bottom: -5.h,
              //     end: 0,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadiusDirectional.only(
              //             bottomEnd: Radius.circular(15.r),
              //             topStart: Radius.circular(15.r),
              //           ),
              //         ),
              //       ),
              //       onPressed: () {
              //         showDesignImage(context);
              //       },
              //       child: Text(
              //         'design_image'.tr(),
              //         style: Theme.of(context)
              //             .textTheme
              //             .bodyMedium!
              //             .copyWith(fontSize: 8.sp, color: Colors.white),
              //       ),
              //     ),
              //   ),

              if (onRemove != null)
                PositionedDirectional(
                  top: 5.h,
                  end: 5.w,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showDesignImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: DefaultCachedNetworkImage(
            imageUrl: cart.customizeProduct != null
                ? cart.customizeProduct!.image!
                : cart
                    .supplierProductSize!.supplierProduct!.products!.image![0],
            imageHeight: MediaQuery.sizeOf(context).height * 0.40,
            imageWidth: MediaQuery.sizeOf(context).width,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
