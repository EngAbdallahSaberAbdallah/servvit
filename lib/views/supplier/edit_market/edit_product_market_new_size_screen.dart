import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_text_form_field.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_states.dart';
import 'package:echo/layout/main/main_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../model/supplier_products/supplier_products_model.dart';

class EditNewSizeProductScreen extends StatefulWidget {
  EditNewSizeProductScreen({
    Key? key,
    required this.productData,
    required this.productId,
  }) : super(key: key);

  final ProductSizes productData;
  final String productId;

  @override
  State<EditNewSizeProductScreen> createState() =>
      _EditNewSizeProductScreenState();
}

class _EditNewSizeProductScreenState extends State<EditNewSizeProductScreen> {
  var miniQuantityController = TextEditingController();

  var miniPriceController = TextEditingController();

  var middleQuantityController = TextEditingController();

  var middlePriceController = TextEditingController();
  var diffQuantityController = TextEditingController();

  var maxQuantityController = TextEditingController();

  var maxPriceController = TextEditingController();
  var fromController = TextEditingController();
  var toController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // SupplierMarketCubit.get(context).getProductDetails(productId: int.parse(widget.productId));

    miniQuantityController.text = widget.productData.quantity1 != "" &&
            widget.productData.quantity1 != "null" &&
            widget.productData.quantity1 != null
        ? widget.productData.quantity1!
        : "";
    diffQuantityController.text = widget.productData.minQuantity2 != "" &&
            widget.productData.minQuantity2 != "null" &&
            widget.productData.minQuantity2 != null
        ? widget.productData.minQuantity2!
        : "";
    middleQuantityController.text = widget.productData.quantity2 != "" &&
            widget.productData.quantity2 != "null" &&
            widget.productData.quantity2 != null
        ? widget.productData.quantity2!
        : "";
    maxQuantityController.text = widget.productData.quantity3 != "" &&
            widget.productData.quantity3 != "null" &&
            widget.productData.quantity3 != null
        ? widget.productData.quantity3!
        : "";
    miniPriceController.text = widget.productData.price1 != "" &&
            widget.productData.price1 != "null" &&
            widget.productData.price1 != null
        ? widget.productData.price1!
        : "";
    middlePriceController.text = widget.productData.price2 != "" &&
            widget.productData.price2 != "null" &&
            widget.productData.price2 != null
        ? widget.productData.price2!
        : "";
    maxPriceController.text = widget.productData.price3 != "" &&
            widget.productData.price3 != "null" &&
            widget.productData.price3 != null
        ? widget.productData.price3!
        : "";
    fromController.text = widget.productData.from != "" &&
            widget.productData.from != "null" &&
            widget.productData.from != null
        ? widget.productData.from!
        : "";
    toController.text = widget.productData.to != "" &&
            widget.productData.to != "null" &&
            widget.productData.to != null
        ? widget.productData.to!
        : "";
  }

  @override
  Widget build(BuildContext context) {
    var cubit = SupplierMarketCubit.get(context);
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50.h,
            title: Image.asset(
              "assets/images/logo2.png",
              width: 100.w,
              height: 40.h,
              fit: BoxFit.contain,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                Assets.imagesIconBackSquare,
                height: 20.h,
                color: AppColors.primaryColor,
              ),
            )),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocBuilder<SupplierMarketCubit, SupplierMarketStates>(
                builder: (context, state) {
              return state is GetProductDetailsLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "quantity".tr(),
                                style: AppTextStyle.headLine()
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("from".tr(),
                                          style: AppTextStyle.title()),
                                      DefaultTextFormField(
                                        textInputType: TextInputType.number,
                                        controller: fromController,
                                        hintText: "from".tr(),
                                        borderRadius: 5.sp,
                                        validationMsg: "field_req".tr(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5.h),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("to".tr(),
                                          style: AppTextStyle.title()),
                                      DefaultTextFormField(
                                        textInputType: TextInputType.number,
                                        controller: toController,
                                        hintText: "to".tr(),
                                        borderRadius: 5.sp,
                                        validationMsg: "field_req".tr(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "enter_mini".tr(),
                                  style: AppTextStyle.title()
                                      .copyWith(color: Colors.black),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: DefaultTextFormField(
                                    textInputType: TextInputType.number,
                                    controller: miniQuantityController,
                                    hintText: "add_mini".tr(),
                                    borderRadius: 5.sp,
                                    validationMsg: "mini_req".tr(),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "diff_desc".tr(),
                                  style: AppTextStyle.bodyText()
                                      .copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 5.h),
                                DefaultTextFormField(
                                  textInputType: TextInputType.number,
                                  controller: diffQuantityController,
                                  hintText: "printed_req".tr(),
                                  validator: (v) {},
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "enter_req_quantity".tr(),
                              style: AppTextStyle.title()
                                  .copyWith(color: Colors.black),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    DefaultTextFormField(
                                      textInputType: TextInputType.number,
                                      controller: miniQuantityController,
                                      hintText: "quantity".tr(),
                                      borderRadius: 5.sp,
                                      style: TextStyle(fontSize: 14.sp),
                                      validationMsg: "field_req".tr(),
                                      suffixIcon: Icon(
                                        CupertinoIcons.lessthan,
                                        color: Colors.black,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                .018,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    DefaultTextFormField(
                                      textInputType: TextInputType.number,
                                      controller: miniPriceController,
                                      hintText: "price".tr(),
                                      borderRadius: 5.sp,
                                      style: TextStyle(fontSize: 14.sp),
                                      validationMsg: "field_req".tr(),
                                    ),
                                  ],
                                )),
                                SizedBox(width: 10.w),
                                Expanded(
                                    child: Column(
                                  children: [
                                    DefaultTextFormField(
                                      textInputType: TextInputType.number,
                                      controller: middleQuantityController,
                                      hintText: "quantity".tr(),
                                      validator: (v) {},
                                      style: TextStyle(fontSize: 14.sp),
                                      borderRadius: 5.sp,
                                      suffixIcon: Icon(
                                        CupertinoIcons.lessthan,
                                        color: Colors.black,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                .018,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    DefaultTextFormField(
                                      textInputType: TextInputType.number,
                                      controller: middlePriceController,
                                      hintText: "price".tr(),
                                      validator: (v) {},
                                      style: TextStyle(fontSize: 14.sp),
                                      borderRadius: 5.sp,
                                    ),
                                  ],
                                )),
                                SizedBox(width: 10.w),
                                Expanded(
                                    child: Column(
                                  children: [
                                    DefaultTextFormField(
                                      textInputType: TextInputType.number,
                                      controller: maxQuantityController,
                                      hintText: "quantity".tr(),
                                      borderRadius: 5.sp,
                                      validator: (v) {},
                                      style: TextStyle(fontSize: 14.sp),
                                      suffixIcon: Icon(
                                        CupertinoIcons.lessthan,
                                        color: Colors.black,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                .018,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    DefaultTextFormField(
                                      textInputType: TextInputType.number,
                                      controller: maxPriceController,
                                      hintText: "price".tr(),
                                      validator: (v) {},
                                      style: TextStyle(fontSize: 14.sp),
                                      borderRadius: 5.sp,
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            BlocConsumer<SupplierMarketCubit,
                                SupplierMarketStates>(
                              listener: (context, state) {
                                if (state
                                    is EditProductSizeFromMarketSuccessState) {
                                  toast(
                                      text: state.message, color: Colors.green);
                                  BottomNavbarCubit.get(context)
                                      .changeBottomNavbar(1);
                                  NavigationUtils.navigateReplacement(
                                      context: context,
                                      destinationScreen: MainLayout());
                                }
                              },
                              builder: (context, state) => state
                                      is EditProductSizeFromMarketLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : DefaultButton(
                                      onPress: () {
                                        if (formKey.currentState!.validate()) {
                                          SupplierMarketCubit.get(context)
                                              .editProductSizeFromMarket(
                                            supplierProductSizeId:
                                                widget.productData.id!,
                                            supplierProductId: widget
                                                .productData.supplierProductId!,
                                            minQuantity:
                                                miniQuantityController.text,
                                            minQuantity2:
                                                diffQuantityController.text,
                                            quantity2:
                                                middleQuantityController.text,
                                            quantity3:
                                                maxQuantityController.text,
                                            price1: miniPriceController.text,
                                            price2: middlePriceController.text,
                                            price3: maxPriceController.text,
                                            from: fromController.text,
                                            to: toController.text,
                                          );
                                        }
                                      },
                                      text: "edit".tr(),
                                      backgroundColor: AppColors.secondaryColor,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
            }),
          ),
        ));
  }
}
