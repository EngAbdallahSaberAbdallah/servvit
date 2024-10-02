import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/functions.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/core/utils/number_format.dart';
import 'package:echo/cubits/payment_method_cubit/payment_method_cubit.dart';
import 'package:echo/cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import 'package:echo/views/vendor/views/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../cubits/vendor_my_cart/vendor_my_cart_cubit.dart';
import '../../../../../model/request_add_order/add_order_request_model.dart';
import '../../../../../model/shipping_cost/shipping_cost_model.dart';
import '../../../../../model/vendor_cart_model/vendor_cart_model.dart';
import '../../widgets/scroll_header_delegete.dart';
import '../bottom_navigation_screens/main_screen.dart';
import 'card_payment_screen.dart';

class VendorPaymentDetails extends StatefulWidget {
  const VendorPaymentDetails({super.key});

  @override
  State<VendorPaymentDetails> createState() => _VendorPaymentDetailsState();
}

class _VendorPaymentDetailsState extends State<VendorPaymentDetails> {
  @override
  void initState() {
    super.initState();

    notDesignedProducts = VendorMyCartCubit.get(context).notDesignedProducts;
    designedProducts = VendorMyCartCubit.get(context).designedProducts;
    donatedProducts = VendorMyCartCubit.get(context).donatedProducts;
    customizedProducts =
        VendorMyCartCubit.get(context).customizedProductsInCart;
    shippingCostModel = PaymentMethodCubit.get(context).shippingCostModel!;
    paymentOrderRequest = PaymentMethodCubit.get(context).paymentOrderRequest;
  }

  late ShippingCostModel shippingCostModel;
  late AddOrderRequestModel paymentOrderRequest;
  late List<VendorCartModel> notDesignedProducts;
  late List<VendorCartModel> designedProducts;
  late List<VendorCartModel> donatedProducts;
  late List<VendorCartModel> customizedProducts;

  @override
  Widget build(BuildContext context) {
    //* 1: get all products in cart
    //* 2: add one field "shipping_cost" to "donate, customized" products
    //* 3: calcualte shipping cost for "without" design products
    //* 4: get summery of all costs
    //* 5: determine paymeny method
    //* 6: add order

    var suppliersCostsForNotPrintedProducts =
        PaymentMethodCubit.get(context).shippingCostModel!.supplierCosts!;
    log('shipping cost ${shippingCostModel.toString()}');
    return WillPopScope(
      onWillPop: () async {
        if (PaymentMethodCubit.get(context).state is PayLoadingState) {
          toast(text: 'loading_hint'.tr(), color: AppColors.primaryColor);
          return false;
        }
        paymentOrderRequest.paymentStatus = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.h,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            Assets.imagesLogo2,
            width: 100.w,
            height: 40.h,
            fit: BoxFit.contain,
          ),
          leading: IconButton(
            onPressed: () {
              if (PaymentMethodCubit.get(context).state is PayLoadingState) {
                toast(text: 'loading_hint'.tr(), color: AppColors.primaryColor);
              } else {
                paymentOrderRequest.paymentStatus = null;
                Navigator.pop(context);
              }
            },
            icon: SvgPicture.asset(
              Assets.imagesIconBackSquare,
              height: 20.h,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.sp),
          child: CustomScrollView(
            slivers: [
              //* for products
              if (notDesignedProducts.isNotEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        'without_design'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              //---------------------------------- details not designed product
              if (notDesignedProducts.isNotEmpty)
                SliverList.separated(
                  itemCount: notDesignedProducts.length,
                  itemBuilder: (context, index) {
                    print('notDesignedProducts ${notDesignedProducts.length}');
                    return CartItem(
                      isFromCartScreen: false,
                      index: index,
                      cart: notDesignedProducts[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                ),

              //-------------------------------todo calcualte shipping cost
              if (notDesignedProducts.length != 1)
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  sliver: SliverList.separated(
                    itemCount: suppliersCostsForNotPrintedProducts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.grey,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            //---------------------------------
                            Expanded(
                              child: Text(
                                '${'shipping_cost_for_without'.tr(
                                  namedArgs: {
                                    'supplier':
                                        'SU-${suppliersCostsForNotPrintedProducts[index].supplier}',
                                    'cost': suppliersCostsForNotPrintedProducts[
                                            index]
                                        .cost!
                                  },
                                )}',
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                            //-------------------------------
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10.h);
                    },
                  ),
                ),

              if (designedProducts.isNotEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        'with_design_m'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),

              if (designedProducts.isNotEmpty)
                SliverList.separated(
                  itemCount: designedProducts.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      isFromCartScreen: false,
                      index: index,
                      cart: designedProducts[index],
                      isItPaymentProcess: true,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                ),

              if (donatedProducts.isNotEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        'donate'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),

              if (donatedProducts.isNotEmpty)
                SliverList.separated(
                  itemCount: donatedProducts.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      isFromCartScreen: false,
                      index: index,
                      isItPaymentProcess: true,
                      cart: donatedProducts[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                ),

              if (customizedProducts.isNotEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        'customized_prodcut'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),

              if (customizedProducts.isNotEmpty)
                SliverList.separated(
                  itemCount: customizedProducts.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      isFromCartScreen: false,
                      index: index,
                      cart: customizedProducts[index],
                      isItPaymentProcess: true,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                ),

              //---------------------------------* for payment process summary

              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(
                  height: 20.h,
                )
              ])),

              SliverPersistentHeader(
                pinned: true,
                delegate: SliverHeaderDelegate(
                  maxHeight: 40.h,
                  minHeight: 25.h,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColors.primaryColor,
                    ),
                    child: Text('order_summary'.tr(),
                        textAlign: TextAlign.center,
                        style:
                            AppTextStyle.title().copyWith(color: Colors.white)),
                  ),
                ),
              ),

              //* order summary
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            "${'shipping_address'.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            paymentOrderRequest.shippingAddress!,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.h,
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            "${'before_vat'.tr()}",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      // fontFamily: 'Tajawal',
                                    ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            "${Functions.getNumberFormatFunc(shippingCostModel.totalWithoutVat!)} ${'egy'.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            "${'vat'.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            "${Functions.getNumberFormatFunc(shippingCostModel.vat!)} ${'egy'.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    if (shippingCostModel.couponValue! != '0.00')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              "${'coupon_value'.tr()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Text(
                              "${Functions.getNumberFormatFunc(shippingCostModel.couponValue!)} ${'egy'.tr()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 5.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            "${'shipping_cost'.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            "${Functions.getNumberFormatFunc(shippingCostModel.allShippingCost!)} ${'egy'.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1.h,
                      height: 10.h,
                    ),
                    SizedBox(height: 5.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Text(
                            "${'after_vat_shipping'.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            "${Functions.getNumberFormatFunc(shippingCostModel.totalCost!)} ${'egy'.tr()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    if (shippingCostModel.half! != '0') SizedBox(height: 10.h),
                    if (shippingCostModel.half! != '0')
                      Text(
                        'payment_note'.tr(
                          namedArgs: {
                            'amount': Functions.getNumberFormatFunc(
                                shippingCostModel.half!)
                          },
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    SizedBox(height: 10.h),
                    Text(
                      "shipping_note3".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "${'shipping_note'.tr()}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "shipping_note2".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    //* half if it founded
                    if (shippingCostModel.half! != '0')
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.h,
                        height: 20.h,
                        endIndent: 10.w,
                        indent: 15.w,
                      ),
                    SizedBox(height: 10.h),
                    if (shippingCostModel.half! != '0')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              "${'required_paid'.tr()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Text(
                              "${Functions.getNumberFormatFunc(shippingCostModel.half!)} ${'egy'.tr()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              //* payment process('card', 'transfer', 'delivery')
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColors.primaryColor,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('payment_method'.tr(),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.title()
                                  .copyWith(color: Colors.white)),
                          Text(
                            "(${"payment_cards".tr()})",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            if (shippingCostModel.half != '0')
                              RadioListTile<PaymentStatus>.adaptive(
                                title: Text('payment_bank_card'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w500)),
                                value: PaymentStatus.card,
                                groupValue: paymentOrderRequest.paymentStatus,
                                onChanged: (value) {
                                  log(value!.text);
                                  setState(() {
                                    paymentOrderRequest.paymentStatus = value;
                                  });
                                },
                              ),
                            if (shippingCostModel.half != '0')
                              RadioListTile<PaymentStatus>.adaptive(
                                title: Text('payment_transfer'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w500)),
                                value: PaymentStatus.transfer,
                                groupValue: paymentOrderRequest.paymentStatus,
                                onChanged: (value) {
                                  log(value!.text);
                                  setState(() {
                                    paymentOrderRequest.paymentStatus = value;
                                  });
                                },
                              ),
                            if (shippingCostModel.half == '0')
                              RadioListTile<PaymentStatus>.adaptive(
                                title: Text('payment_delivery'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w500)),
                                value: PaymentStatus.deleivery,
                                groupValue: paymentOrderRequest.paymentStatus,
                                onChanged: (value) {
                                  log(value!.text);

                                  setState(() {
                                    paymentOrderRequest.paymentStatus = value;
                                    print('payment order status is $value');
                                    PaymentMethodCubit.get(context)
                                        .paymentOrderRequest
                                      ..paymentStatus = value;
                                  });
                                },
                              ),
                            if (shippingCostModel.half == '0')
                              RadioListTile<PaymentStatus>.adaptive(
                                title: Text('payment_delivery2'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w500)),
                                value: PaymentStatus.bankDelivery,
                                groupValue: paymentOrderRequest.paymentStatus,
                                onChanged: (value) {
                                  log(value!.text);
                                  setState(() {
                                    paymentOrderRequest.paymentStatus = value;
                                  });
                                },
                              ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
                      listener: (context, state) {
                        if (state is PayFailureState) {
                          toast(text: state.errorMessage, color: Colors.red);
                        }
                        log('listeners: ${state.toString()}');
                        if (state is PaySuccessState) {
                          PaymentMethodCubit.get(context).showDialog = true;
                          NavigationUtils.navigateAndClearStack(
                              context: context,
                              destinationScreen: VendorMainScreen());
                        }
                        if (state is PaymobSuccessState) {
                          NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: CardPaymentScreen(
                              paymentStatus: paymentOrderRequest.paymentStatus,
                              authToken: state.token,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is PayLoadingState ||
                            state is PayWithPaymobLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          );
                        }
                        return DefaultButton(
                          onPress: () {
                            if (paymentOrderRequest.paymentStatus != null) {
                              if (paymentOrderRequest.paymentStatus ==
                                  PaymentStatus.card) {
                                PaymentMethodCubit.get(context).addOrder();

                                // PaymentMethodCubit.get(context).payWithPaymob(
                                //     items: VendorMyCartCubit.get(context)
                                //         .allProductsInCart);
                              } else
                                PaymentMethodCubit.get(context).pay();
                            } else {
                              toast(
                                  text: 'payment_process_required'.tr(),
                                  color: Colors.red);
                            }
                          },
                          text: 'confirmOrder'.tr(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
