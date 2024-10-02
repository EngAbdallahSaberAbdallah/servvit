import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/utils/constants.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/views/vendor/views/screens/payment_method/vendor_payment_info_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/text_styles/app_text_style.dart';
import '../../../../core/utils/assets.dart';
import '../../../../cubits/vendor_my_cart/vendor_my_cart_cubit.dart';
import '../../../../model/vendor_cart_model/vendor_cart_model.dart';
import '../widgets/cart_item.dart';
import '../widgets/scroll_header_delegete.dart';
import '../widgets/shimmer_loading.dart';

class VendorCartScreen extends StatefulWidget {
  const VendorCartScreen({super.key});

  @override
  State<VendorCartScreen> createState() => _VendorCartScreenState();
}

class _VendorCartScreenState extends State<VendorCartScreen> {
  // GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  GlobalKey<SliverAnimatedListState> _listWithoutKey =
      GlobalKey<SliverAnimatedListState>();
  GlobalKey<SliverAnimatedListState> _listWithKey =
      GlobalKey<SliverAnimatedListState>();
  GlobalKey<SliverAnimatedListState> _listWithDonateKey =
      GlobalKey<SliverAnimatedListState>();
  GlobalKey<SliverAnimatedListState> _listCustomizedKey =
      GlobalKey<SliverAnimatedListState>();
  GlobalKey<SliverAnimatedListState> summeryKey =
      GlobalKey<SliverAnimatedListState>();

  @override
  void initState() {
    super.initState();
    VendorMyCartCubit.get(context).getMyCart();
  }

  late List<VendorCartModel> allProducts;
  late var notDesignedProducts;
  late var designedProducts;
  late var donatedProducts;
  late var customizedProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.h,
        title: Image.asset(
          Assets.imagesLogo2,
          width: 100.w,
          height: 40.h,
          fit: BoxFit.contain,
        ),
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
      ),
      body: BlocConsumer<VendorMyCartCubit, VendorMyCartState>(
        listener: (context, current) {
          if (current is VendorMyCartDeleteSuccess) {
            toast(
              text: current.message,
              color: AppColors.primaryColor,
            );
          }
          if (current is VendorMyCartDeleteError) {
            toast(
              text: current.error,
              color: Colors.red,
            );
          }
        },
        buildWhen: (previous, current) {
          if (current is VendorMyCartSuccess ||
              current is VendorMyCartError ||
              current is VendorMyCartLoading) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is VendorMyCartLoading &&
              VendorMyCartCubit.get(context).vendorCartModel == null) {
            return ShimmerLoading(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    height: 120.h,
                    width: double.infinity,
                    margin: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  );
                },
                separatorBuilder: (contex, index) {
                  return SizedBox(height: 10.h);
                },
                itemCount: 4,
              ),
            );
          } else if (state is VendorMyCartError ||
              state is VendorMyCartDeleteError) {
            return Center(
              child: CustomErrorWidget(
                onTap: () {
                  VendorMyCartCubit.get(context).getMyCart();
                },
              ),
            );
          }
          allProducts = VendorMyCartCubit.get(context).allProductsInCart;
          notDesignedProducts =
              VendorMyCartCubit.get(context).notDesignedProducts;
          designedProducts = VendorMyCartCubit.get(context).designedProducts;
          donatedProducts = VendorMyCartCubit.get(context).donatedProducts;
          customizedProducts =
              VendorMyCartCubit.get(context).customizedProductsInCart;
          return Column(
            children: [
              Text('my_cart'.tr(),
                  style: AppTextStyle.title().copyWith(fontSize: 18.sp)),
              SizedBox(
                height: 10.h,
              ),
              allProducts.isEmpty
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/no_cart.png",
                              color: Colors.grey,
                              width: MediaQuery.of(context).size.width * .3,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'no_cart_desc'.tr(),
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.bodyText().copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: CustomScrollView(
                        slivers: [
                          if (notDesignedProducts.isNotEmpty)
                            SliverPersistentHeader(
                              delegate: SliverHeaderDelegate(
                                minHeight: 25.h,
                                maxHeight: 30.h,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsetsDirectional.only(bottom: 5.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 4.h),
                                    child: Text('without_design'.tr(),
                                        style: AppTextStyle.title()
                                            .copyWith(color: Colors.white)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              pinned: false,
                            ),
                          if (notDesignedProducts.length > 0)
                            SliverAnimatedList(
                              key: _listWithoutKey,
                              itemBuilder: (context, index, animation) {
                                return CartItem(
                                  isFromCartScreen: true,
                                  index: index,
                                  cart: notDesignedProducts[index],
                                  onRemove: () {
                                    removeItem(context, notDesignedProducts,
                                        index, _listWithoutKey);
                                  },
                                );
                              },
                              initialItemCount: notDesignedProducts.length,
                            ),
                          //  SizedBox(height: 20.h,),
                          if (designedProducts.isNotEmpty)
                            SliverPersistentHeader(
                              delegate: SliverHeaderDelegate(
                                minHeight: 25.h,
                                maxHeight: 30.h,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsetsDirectional.only(
                                        bottom: 5.h, top: 5.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 4.h),
                                    child: Text(
                                      'with_design_m'.tr(),
                                      style: AppTextStyle.title()
                                          .copyWith(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              pinned: false,
                            ),

                          if (designedProducts.isNotEmpty)
                            SliverAnimatedList(
                              key: _listWithKey,
                              itemBuilder: (context, index, animation) {
                                return CartItem(
                                  isFromCartScreen: true,
                                  index: index,
                                  cart: designedProducts[index],
                                  onRemove: () {
                                    removeItem(context, designedProducts, index,
                                        _listWithKey);
                                  },
                                );
                              },
                              initialItemCount: designedProducts.length,
                            ),
                          if (donatedProducts.isNotEmpty)
                            SliverPersistentHeader(
                              delegate: SliverHeaderDelegate(
                                minHeight: 25.h,
                                maxHeight: 30.h,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsetsDirectional.only(
                                        bottom: 5.h, top: 5.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 4.h),
                                    child: Text(
                                      'donate'.tr(),
                                      style: AppTextStyle.title()
                                          .copyWith(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              pinned: false,
                            ),
                          if (donatedProducts.isNotEmpty)
                            SliverAnimatedList(
                              key: _listWithDonateKey,
                              itemBuilder: (context, index, animation) {
                                return CartItem(
                                  isFromCartScreen: true,
                                  index: index,
                                  cart: donatedProducts[index],
                                  onRemove: () {
                                    removeItem(context, donatedProducts, index,
                                        _listWithDonateKey);
                                  },
                                );
                              },
                              initialItemCount: donatedProducts.length,
                            ),
                          if (customizedProducts.isNotEmpty)
                            SliverPersistentHeader(
                              delegate: SliverHeaderDelegate(
                                minHeight: 25.h,
                                maxHeight: 30.h,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsetsDirectional.only(
                                        bottom: 5.h, top: 5.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 4.h),
                                    child: Text(
                                      'customized_prodcut'.tr(),
                                      style: AppTextStyle.title()
                                          .copyWith(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              pinned: false,
                            ),
                          if (customizedProducts.isNotEmpty)
                            SliverAnimatedList(
                              key: _listCustomizedKey,
                              itemBuilder: (context, index, animation) {
                                return CartItem(
                                  isFromCartScreen: true,
                                  index: index,
                                  cart: customizedProducts[index],
                                  onRemove: () {
                                    removeItem(context, customizedProducts,
                                        index, _listCustomizedKey);
                                  },
                                );
                              },
                              initialItemCount: customizedProducts.length,
                            ),
                          SliverAnimatedList(
                            key: summeryKey,
                            itemBuilder: (context, index, animation) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10.h),
                                  Text("order_summary".tr(),
                                      style: AppTextStyle.title()),
                                  SizedBox(height: 5.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 5.h),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      border: Border.all(),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              "before_vat".tr() + " :",
                                              style: AppTextStyle.title(),
                                            )),
                                            Text(
                                                "${VendorMyCartCubit.get(context).totalWithoutVat.toString()}" +
                                                    " " +
                                                    "egy".tr(),
                                                style: AppTextStyle.title()
                                                    .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              "vat".tr() + " :",
                                              style: AppTextStyle.title(),
                                            )),
                                            Text(
                                                "${VendorMyCartCubit.get(context).vat.toString()}" +
                                                    " " +
                                                    "egy".tr(),
                                                style: AppTextStyle.title()
                                                    .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Divider(),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              "after_vat".tr() + " :",
                                              style: AppTextStyle.title(),
                                            )),
                                            Text(
                                                "${VendorMyCartCubit.get(context).totalAfterVat.toString()}" +
                                                    " " +
                                                    "egy".tr(),
                                                style: AppTextStyle.title()
                                                    .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                            "* " +
                                                "priceDoesNotIncludeShippingCosts"
                                                    .tr(),
                                            textAlign: TextAlign.start,
                                            style: AppTextStyle.title()
                                                .copyWith(
                                                    fontSize: 11.sp,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                ],
                              );
                            },
                            initialItemCount: 1,
                          ),
                        ],
                      ),
                    ),
              if (allProducts.isNotEmpty)
                DefaultButton(
                  onPress: () {
                    NavigationUtils.navigateTo(
                      context: context,
                      destinationScreen: VendorPaymentInfoForm(
                        cartItems:
                            VendorMyCartCubit.get(context).allProductsInCart,
                      ),
                    );
                  },
                  text: 'proceedWithOrder'.tr(),
                  borderRadius: 0,
                )
            ],
          );
        },
      ),
    );
  }

  void removeItem(BuildContext context, List<VendorCartModel> myCarts,
      int index, GlobalKey<SliverAnimatedListState> _listKey) {
    showDialogWidget(
      context: context,
      title: 'delete_title'.tr(),
      content: 'delete_message'.tr(),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'cancel'.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 14.sp,
                ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            VendorCartModel removedItem = myCarts.removeAt(index);
            await VendorMyCartCubit.get(context)
                .deleteFromCart(cartId: removedItem.id!);
            _listKey.currentState!.removeItem(
              index,
              (context, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: CartItem(
                    isFromCartScreen: true,
                    index: index,
                    cart: removedItem,
                  ), // removeditem will be CartItem(removedItem)
                );
              },
            );
          },
          child: Text(
            'confirm'.tr(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.red[600],
                  fontSize: 14.sp,
                ),
          ),
        ),
      ],
    );
  }
}
