import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/custom_carousel_slider.dart';
import 'package:echo/core/shared_components/custom_dropdown_formfield.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/shared_components/default_text_form_field.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/core/utils/custom_style.dart';
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
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../model/products/products_model.dart';

class AddProductToMarketScreen extends StatelessWidget {
  AddProductToMarketScreen({
    Key? key,
    required this.productDetails,
    // required this.colors,
    required this.sizes,
    required this.images,
    required this.sizesIds,
  }) : super(key: key);

  final Data productDetails;

  final List<String> sizes;
  final List<String> images;
  final List<int> sizesIds;
  int? selectedSizeId;

  List<int> selectedColorsIds = [];

  var miniQuantityController = TextEditingController();
  var diffQuantityController = TextEditingController();
  var miniPriceController = TextEditingController();
  var middleQuantityController = TextEditingController();
  var middlePriceController = TextEditingController();
  var maxQuantityController = TextEditingController();
  var maxPriceController = TextEditingController();
  var fromController = TextEditingController();
  var toController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    //     style: AppTextStyle.headLine()
                    //         .copyWith(color: Colors.black),
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
                              productDetails.name!,
                              style: AppTextStyle.headLine(),
                            ),
                            Text(
                              "color".tr() +
                                  " : " +
                                  "${productDetails.color!.name!}",
                              style: AppTextStyle.subTitle(),
                            ),
                            Text(
                              productDetails.description!,
                              style: AppTextStyle.subTitle(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                        Flexible(child: CustomCarouselItem(images: images)),
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
                            validationMsg: "mini_req".tr(),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "diff_desc".tr(),
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * .014,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontFamily: "Almaria",
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 5.h),
                          DefaultTextFormField(
                            textInputType: TextInputType.number,
                            controller: diffQuantityController,
                            hintText: "printed_req".tr(),
                            validator: (v) {},
                          ),
                          if (sizes.isNotEmpty) SizedBox(height: 10.h),
                          if (sizes.isNotEmpty)
                            CustomDropDownButton(
                                hintText: "select_size".tr(),
                                onChanged: (value) {
                                  int index = sizes.indexOf(value!);
                                  selectedSizeId = sizesIds[index];
                                },
                                items: sizes,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty)
                                    return "size_req".tr();
                                  return null;
                                }),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "delivery_time".tr(),
                          style: AppTextStyle.title()
                              .copyWith(color: Colors.black),
                        )),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "from".tr(),
                                style: AppTextStyle.title()
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(height: 5.h),
                              DefaultTextFormField(
                                textInputType: TextInputType.number,
                                controller: fromController,
                                hintText: "days".tr(),
                                contentPaddingVertical: 0,
                                validationMsg: "field_req".tr(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "to".tr(),
                                style: AppTextStyle.title()
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(height: 5.h),
                              DefaultTextFormField(
                                textInputType: TextInputType.number,
                                controller: toController,
                                hintText: "days".tr(),
                                contentPaddingVertical: 0,
                                validationMsg: "field_req".tr(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "enter_req_quantity".tr(),
                      style: AppTextStyle.title().copyWith(color: Colors.black),
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
                              contentPaddingVertical: 0,
                              validationMsg: "field_req".tr(),
                              suffixIcon: Icon(
                                CupertinoIcons.lessthan,
                                color: Colors.black,
                                size: MediaQuery.of(context).size.height * .018,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            DefaultTextFormField(
                              textInputType: TextInputType.number,
                              controller: miniPriceController,
                              hintText: "price".tr(),
                              contentPaddingVertical: 0,
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
                              contentPaddingVertical: 0,
                              // validationMsg: "this field is required",
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
                              validator: (v) {},
                              contentPaddingVertical: 0,
                              // validationMsg: "this field is required",
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
                              contentPaddingVertical: 0,
                              // validationMsg: "this field is required",
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
                              validator: (v) {},
                              contentPaddingVertical: 0,
                              // validationMsg: "this field is required",
                            ),
                          ],
                        )),
                      ],
                    ),

                    // if (colors.isNotEmpty) SizedBox(height: 15.h),
                    // if (colors.isNotEmpty)
                    //   MultiSelectDialogField(
                    //     title: Text("Select Colors"),
                    //     buttonText: Text("Select Colors"),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10.sp),
                    //       border: Border.all(color: AppColors.primaryColor),
                    //     ),
                    //     dialogHeight: MediaQuery.of(context).size.height * 0.5,
                    //     buttonIcon: Icon(
                    //       Icons.color_lens,
                    //       color: AppColors.primaryColor,
                    //     ),
                    //     selectedColor: AppColors.primaryColor,
                    //     searchable: true,
                    //     validator: (List<String>? value) {
                    //       if (value!.isEmpty) return "Must Select One Color at least";
                    //       return null;
                    //     },
                    //     searchIcon: Icon(Icons.search),
                    //     items: colors.map((e) => MultiSelectItem(e, e)).toList(),
                    //     listType: MultiSelectListType.LIST,
                    //     onConfirm: (values) {
                    //       List<int> indexs = [];
                    //       for (int i = 0; i < values.length; i++) {
                    //         indexs.add(colors.indexOf(values[i]));
                    //         selectedColorsIds.add(colorsIds[i]);
                    //       }
                    //       print(selectedColorsIds);
                    //     },
                    //   ),
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
                                    productId: productDetails.id!,
                                    from: fromController.text,
                                    to: toController.text,
                                    minQuantity: miniQuantityController.text,
                                    minQuantity2: diffQuantityController.text,
                                    quantity2: middleQuantityController.text,
                                    quantity3: maxQuantityController.text,
                                    price1: miniPriceController.text,
                                    price2: middlePriceController.text,
                                    price3: maxPriceController.text,
                                    sizeId: selectedSizeId,
                                  );
                                }
                              },
                              text: "submit".tr(),
                              backgroundColor: AppColors.primaryColor,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
