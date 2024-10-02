import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/custom_carousel_slider.dart';
import 'package:echo/core/shared_components/custom_dropdown_formfield.dart';
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
import 'package:echo/model/supplier_products/supplier_products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/shared_components/error_widget.dart';
import '../../../cubits/products/products_cubit.dart';

class AddNewSizeProductToMarketScreen extends StatefulWidget {
  AddNewSizeProductToMarketScreen({
    Key? key,
    required this.productDetails,
    required this.images,
  }) : super(key: key);

  final Data productDetails;

  final List<String> images;

  @override
  State<AddNewSizeProductToMarketScreen> createState() =>
      _AddNewSizeProductToMarketScreenState();
}

class _AddNewSizeProductToMarketScreenState
    extends State<AddNewSizeProductToMarketScreen> {
  int? selectedSizeId;

  List<int> selectedColorsIds = [];

  var miniQuantityController = TextEditingController();

  var miniPriceController = TextEditingController();

  var diffQuantityController = TextEditingController();

  var middleQuantityController = TextEditingController();

  var middlePriceController = TextEditingController();

  var maxQuantityController = TextEditingController();

  var maxPriceController = TextEditingController();

  var fromController = TextEditingController();

  var toController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context
        .read<ProductsCubit>()
        .getProductSizes(widget.productDetails.products!.id!);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = SupplierMarketCubit.get(context);
    List<String> sizes = [];
    List<int> sizesIds = [];
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
              )),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Align(
                    //   alignment: AlignmentDirectional.center,
                    //   child: Text(
                    //     "quantity".tr(),
                    //     style: AppTextStyle.title(),
                    //   ),
                    // ),
                    // SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.productDetails.products!.name!,
                              style: AppTextStyle.headLine(),
                            ),
                            Text(
                              "${"color".tr()} : ${widget.productDetails.products!.color!.name!}",
                              style: AppTextStyle.subTitle(),
                            ),
                            Text(
                              widget.productDetails.products!.description!,
                              style: AppTextStyle.subTitle(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                        Flexible(
                            child: CustomCarouselItem(images: widget.images)),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          DefaultTextFormField(
                            textInputType: TextInputType.number,
                            controller: miniQuantityController,
                            hintText: "add_mini".tr(),
                            style: AppTextStyle.bodyText(),
                            borderRadius: 5.sp,
                            validationMsg: "mini_req".tr(),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "diff_desc".tr(),
                            style: AppTextStyle.bodyText().copyWith(
                              fontSize: 11.sp,
                              color: Colors.grey,
                            ),
                            // fontSize:
                            //     MediaQuery.of(context).size.height * .014,
                            // fontWeight: FontWeight.w500,
                            // color: Colors.grey,
                            // fontFamily: "Tajawal",
                            // ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 5.h),
                          DefaultTextFormField(
                            textInputType: TextInputType.number,
                            controller: diffQuantityController,
                            hintText: "printed_req".tr(),
                            style: AppTextStyle.bodyText(),
                            validator: (v) {},
                          ),
                          BlocBuilder<ProductsCubit, ProductsStates>(
                            builder: (context, state) {
                              if (state is GetSizesOfProductLoadingState) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state
                                  is GetSizesOfProductSuccessState) {
                                var productSizes =
                                    ProductsCubit.get(context).productSizes;
                                for (int i = 0; i < productSizes.length; i++) {
                                  sizes.add(productSizes[i].size!);
                                  sizesIds.add(productSizes[i].id!);

                                  selectedSizeId =
                                      sizesIds[sizes.indexOf(sizes[0])];
                                }
                                return Column(
                                  children: [
                                    if (sizes.isNotEmpty)
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    if (sizes.isNotEmpty)
                                      CustomDropDownButton(
                                          hintText: "select_size".tr(),
                                          firstValue: sizes[0],
                                          onChanged: (value) {
                                            setState(() {
                                              int index = sizes.indexOf(value!);
                                              selectedSizeId = sizesIds[index];
                                            });
                                          },
                                          items: sizes,
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty)
                                              return "size_req".tr();
                                            return null;
                                          }),
                                  ],
                                );
                              } else if (state
                                  is GetSizesOfProductFailureState) {
                                print(state.errorMessage.toString());
                                return Center(
                                  child: CustomErrorWidget(
                                    onTap: () {
                                      ProductsCubit.get(context)
                                          .getProductSizes(widget
                                              .productDetails.products!.id!);
                                    },
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "delivery_time".tr(),
                          style: AppTextStyle.subTitle().copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        )),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text("from".tr(),
                                  style: AppTextStyle.subTitle().copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp)),
                              SizedBox(height: 5.h),
                              DefaultTextFormField(
                                textInputType: TextInputType.number,
                                controller: fromController,
                                hintText: "days".tr(),
                                style: AppTextStyle.bodyText(),
                                borderRadius: 5.sp,
                                validationMsg: "field_req".tr(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text("to".tr(),
                                  style: AppTextStyle.subTitle().copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp)),
                              SizedBox(height: 5.h),
                              DefaultTextFormField(
                                textInputType: TextInputType.number,
                                controller: toController,
                                hintText: "days".tr(),
                                style: AppTextStyle.bodyText(),
                                borderRadius: 5.sp,
                                validationMsg: "field_req".tr(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text("enter_req_quantity".tr(),
                        style: AppTextStyle.subTitle().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp)),
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
                              style: TextStyle(fontSize: 14.sp),
                              borderRadius: 5.sp,
                              // validationMsg: "field_req".tr(),
                              suffixIcon: Icon(
                                CupertinoIcons.lessthan,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.height * .018,
                              ),
                              validationMsg: "field_req".tr(),
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
                              // validationMsg: "field_req".tr(),
                              suffixIcon: Icon(
                                CupertinoIcons.lessthan,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.height * .018,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            DefaultTextFormField(
                              textInputType: TextInputType.number,
                              controller: middlePriceController,
                              hintText: "price".tr(),
                              borderRadius: 5.sp,
                              style: TextStyle(fontSize: 14.sp),
                              validator: (v) {},
                              // validationMsg: "field_req".tr(),
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
                              validator: (v) {},
                              style: TextStyle(fontSize: 14.sp),
                              borderRadius: 5.sp,
                              // validationMsg: "field_req".tr(),
                              suffixIcon: Icon(
                                CupertinoIcons.lessthan,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.height * .018,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            DefaultTextFormField(
                              textInputType: TextInputType.number,
                              controller: maxPriceController,
                              hintText: "price".tr(),
                              style: TextStyle(fontSize: 14.sp),
                              validator: (v) {},
                              borderRadius: 5.sp,
                              // validationMsg: "field_req".tr(),
                            ),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    BlocConsumer<SupplierMarketCubit, SupplierMarketStates>(
                      listener: (context, state) {
                        if (state is AddProductToMarketSuccessState) {
                          toast(text: state.message, color: Colors.green);
                          BottomNavbarCubit.get(context).changeBottomNavbar(1);
                          NavigationUtils.navigateReplacement(
                              context: context,
                              destinationScreen: MainLayout());
                        }
                      },
                      builder: (context, state) => state
                              is AddProductToMarketLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : DefaultButton(
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                  SupplierMarketCubit.get(context)
                                      .addProductToMarket(
                                    productId:
                                        widget.productDetails.products!.id!,
                                    from: fromController.text,
                                    to: toController.text,
                                    minQuantity: miniQuantityController.text,
                                    quantity2: middleQuantityController.text,
                                    quantity3: maxQuantityController.text,
                                    price1: miniPriceController.text,
                                    price2: middlePriceController.text,
                                    price3: maxPriceController.text,
                                    sizeId: selectedSizeId,
                                  );
                                }
                              },
                              text: "add".tr(),
                              backgroundColor: AppColors.primaryColor,
                            ),
                    ),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
