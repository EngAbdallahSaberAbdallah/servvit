import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/constants.dart';
import 'package:echo/core/utils/functions.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/vendor_my_cart/vendor_my_cart_cubit.dart';
import 'package:echo/model/products/vendor_product_model.dart'
    as vendorProductModel;
import 'package:echo/model/suppliers_product_size/supplier_product_size_model.dart';
import 'package:echo/views/vendor/views/screens/vendor_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/number_format.dart';
import '../../../../cubits/products/products_cubit.dart';
import '../../../../cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import 'package:path/path.dart' as path;

class AddToVendorCart extends StatefulWidget {
  const AddToVendorCart({
    super.key,
    required this.supplierProductSize,
    required this.productDetails,
  });
  final Data supplierProductSize;
  final vendorProductModel.Data productDetails;

  @override
  State<AddToVendorCart> createState() => _AddToVendorCartState();
}

class _AddToVendorCartState extends State<AddToVendorCart> {
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    context.read<ProductsCubit>().images.clear();
    context.read<ProductsCubit>().files.clear();
    // productDetails = ProductsCubit.get(context)
    //     .allProductsModel!
    //     .data![ProductsCubit.get(context).clickedIndex!];
  }

  // late final vendorProductModel.Data widget.productDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (VendorAddToCartCubit.get(context).state is VendorLoadingAddToCart) {
          toast(text: 'loading_hint'.tr(), color: AppColors.primaryColor);
          return false;
        }
        VendorAddToCartCubit.get(context).selectedDesignStatus = '';
        // VendorAddToCartCubit.get(context).selectedImage = null;
        context.read<ProductsCubit>().images.clear();
        context.read<ProductsCubit>().files.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.h,
          title: Image.asset(
            Assets.imagesLogo2,
            width: 100.w,
            height: 40.h,
            fit: BoxFit.contain,
          ),
          leading: IconButton(
            onPressed: () {
              if (VendorAddToCartCubit.get(context).state
                  is VendorLoadingAddToCart) {
                toast(text: 'loading_hint'.tr(), color: AppColors.primaryColor);
              } else {
                VendorAddToCartCubit.get(context).selectedDesignStatus = '';
                // VendorAddToCartCubit.get(context).selectedImage = null;
                context.read<ProductsCubit>().images.clear();
                context.read<ProductsCubit>().files.clear();
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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                // * image of the product
                DefaultCachedNetworkImage(
                  imageUrl: widget.productDetails.image![0],
                  imageHeight: MediaQuery.of(context).size.height * .30,
                  imageWidth: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 5.h),
                // * product name
                Text(
                  '${widget.productDetails.name} - ${widget.productDetails.name2 != null ? widget.productDetails.name2 : ''}',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.headLine().copyWith(fontSize: 18),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(height: 10.h),
                //* description of the product
                Text(
                  '${widget.productDetails.description}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp,
                      ),
                ),
                SizedBox(height: 10.h),
                //* product color and size
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //* color
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          '${"color".tr()}: ${widget.productDetails.color!.name}',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14.sp,
                                  ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      //* size
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          '${'size'.tr()}: ${ProductsCubit.get(context).selectedSize}',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14.sp,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //* min quantity
                      if (Functions.getNumberFormatFunc(widget
                                  .supplierProductSize
                                  .productSizes![0]
                                  .minQuantity) !=
                              "0.0" &&
                          Functions.getNumberFormatFunc(widget
                                  .supplierProductSize
                                  .productSizes![0]
                                  .minQuantity) !=
                              "null")
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            '${"min_quantity".tr()}: ${Functions.getNumberFormatFunc(widget.supplierProductSize.productSizes![0].minQuantity)}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14.sp,
                                    ),
                          ),
                        ),
                      SizedBox(width: 10.w),
                      //* min printed quantity
                      if (Functions.getNumberFormatFunc(widget
                                  .supplierProductSize
                                  .productSizes![0]
                                  .minQuantity2) !=
                              "0.0" &&
                          Functions.getNumberFormatFunc(widget
                                  .supplierProductSize
                                  .productSizes![0]
                                  .minQuantity2) !=
                              "null")
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            '${'min_quantity_printed'.tr()}: ${Functions.getNumberFormatFunc(widget.supplierProductSize.productSizes![0].minQuantity2)}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14.sp,
                                    ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),

                //* user type quantity

                // Container(
                //   width: MediaQuery.sizeOf(context).width * .5,
                //   padding: EdgeInsets.zero,
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(10.r),
                //   ),
                //   child: TextFormField(
                //     controller: _quantityController,
                //     textAlign: TextAlign.center,
                //     onTapOutside: (event) {
                //       FocusManager.instance.primaryFocus?.unfocus();
                //     },
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     onChanged: (value) {
                //       _quantityController.text = Functions.getNumberFormatFunc(
                //           _quantityController.text
                //               .replaceAll(RegExp(r','), ''));
                //       _quantityController.selection =
                //           TextSelection.fromPosition(
                //         TextPosition(
                //           offset: _quantityController.text.length,
                //         ),
                //       );
                //     },
                //     validator: (value) {
                //       //! value must be bigger or equal to min quantity
                //       if (value!.isEmpty) {
                //         return 'enter_req_quantity'.tr();
                //       } else if (int.parse(value.replaceAll(RegExp(r','), '')) <
                //           int.parse(widget.supplierProductSize.productSizes![0]
                //               .minQuantity!)) {
                //         return '${'bigger_quantity'.tr(namedArgs: {
                //               'quantity':
                //                   '${Functions.getNumberFormatFunc(widget.supplierProductSize.productSizes![0].minQuantity!)}'
                //             })}';
                //       }
                //       return null;
                //     },
                //     keyboardType: TextInputType.number,
                //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       suffixText: 'piece'.tr(),
                //       suffixStyle:
                //           Theme.of(context).textTheme.bodySmall!.copyWith(
                //                 fontSize: 10.sp,
                //               ),
                //       errorStyle:
                //           Theme.of(context).textTheme.bodySmall!.copyWith(
                //                 fontSize: 10.sp,
                //                 color: Colors.red,
                //               ),
                //       hintText: 'quantity'.tr(),
                //       contentPadding:
                //           EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                //     ),
                //   ),
                // ),
                Container(
                  width: MediaQuery.sizeOf(context).width - 128.w,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: TextFormField(
                    controller: _quantityController,
                    textAlign: TextAlign.center,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    autovalidateMode: AutovalidateMode
                        .disabled, //------ Disable auto-validation
                    onChanged: (value) {
                      _quantityController.text = Functions.getNumberFormatFunc(
                          _quantityController.text
                              .replaceAll(RegExp(r','), ''));
                      _quantityController.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                          offset: _quantityController.text.length,
                        ),
                      );
                    },
                    style: AppTextStyle.bodyText(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixText: 'piece'.tr(),
                      suffixStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                              fontSize: 10.sp, fontWeight: FontWeight.w500),
                      hintText: 'enter_req_quantity'.tr(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),
                //* choose between without design, with design, or donate with a new
                BlocBuilder<VendorAddToCartCubit, VendorAddToCartState>(
                  builder: (context, state) {
                    var currentDesign =
                        VendorAddToCartCubit.get(context).selectedDesignStatus;
                    List<String> designs =
                        widget.productDetails.designStatus!.split(',');
                    if (currentDesign == '') {
                      log('-----=========---- ${designs[0]}');
                      VendorAddToCartCubit.get(context).selectedDesignStatus =
                          currentDesign = designs[0] == 'donate'
                              ? 'with_donate'
                              : designs[0];
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 8.w),
                          //! without
                          if (designs.contains('without'))
                            InkWell(
                              onTap: () {
                                VendorAddToCartCubit.get(context)
                                    .addToCart(designStatus: 'without');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: currentDesign == 'without'
                                      ? AppColors.primaryColor
                                      : null,
                                  border: Border.all(
                                    color: Color.fromRGBO(160, 160, 162, 1),
                                  ),
                                ),
                                child: Text(
                                  'without'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: currentDesign == 'without'
                                            ? Colors.white
                                            : null,
                                      ),
                                ),
                              ),
                            ),
                          SizedBox(width: 8.w),
                          //!with
                          if (designs.contains('with'))
                            InkWell(
                              onTap: () {
                                VendorAddToCartCubit.get(context)
                                    .addToCart(designStatus: 'with');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: currentDesign == 'with'
                                      ? AppColors.primaryColor
                                      : null,
                                  border: Border.all(
                                    color: Color.fromRGBO(160, 160, 162, 1),
                                  ),
                                ),
                                child: Text(
                                  'printed'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: currentDesign == 'with'
                                            ? Colors.white
                                            : null,
                                      ),
                                ),
                              ),
                            ),
                          SizedBox(width: 8.w),
                          //!with_donate_add
                          if (designs.contains('donate'))
                            InkWell(
                              onTap: () {
                                VendorAddToCartCubit.get(context)
                                    .addToCart(designStatus: 'with_donate');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: currentDesign == 'with_donate'
                                      ? AppColors.primaryColor
                                      : null,
                                  border: Border.all(
                                    color: Color.fromRGBO(160, 160, 162, 1),
                                  ),
                                ),
                                child: Text(
                                  'with_donate_add'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: currentDesign == 'with_donate'
                                            ? Colors.white
                                            : null,
                                      ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
//==========================================================

                BlocBuilder<ProductsCubit, ProductsStates>(
                  builder: (context, state) {
                    if (state is UploadMultipleImagesSuccessState) {
                      return ProductsCubit.get(context).images.isEmpty
                          ? SizedBox()
                          : SizedBox(
                              height: MediaQuery.sizeOf(context).height * .25,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.images.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    clipBehavior: Clip.hardEdge,
                                    width:
                                        MediaQuery.sizeOf(context).width * .25,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.hardEdge,
                                      children: [
                                        path.extension(state.images[index]) ==
                                                    '.png' ||
                                                path.extension(
                                                        state.images[index]) ==
                                                    '.jpg'
                                            ? Image.file(
                                                File(state.images[index]),
                                                fit: BoxFit.fill,
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(tr('file'),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                        fontSize: 11.sp,
                                                        color: AppColors
                                                            .primaryColor,
                                                      )),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      path.basename(
                                                          state.images[index]),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTextStyle
                                                              .subTitle()
                                                          .copyWith(
                                                        fontSize: 11.sp,
                                                        color: AppColors
                                                            .primaryColor,
                                                      )),
                                                ],
                                              ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                state.images.removeAt(index);
                                              });
                                            },
                                            icon: Icon(
                                              Icons
                                                  .remove_circle_outline_outlined,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                    } else {
                      return SizedBox();
                    }
                  },
                ),

                BlocBuilder<VendorAddToCartCubit, VendorAddToCartState>(
                    builder: (context, state) {
                  if (VendorAddToCartCubit.get(context).selectedDesignStatus ==
                      'with') {
                    return BlocBuilder<ProductsCubit, ProductsStates>(
                      builder: (context, state) {
                        if (state is UploadMultipleImagesSuccessState) {
                          return ProductsCubit.get(context).files.isEmpty
                              ? SizedBox()
                              : SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * .25,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.files.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        clipBehavior: Clip.hardEdge,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                .25,
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip.hardEdge,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(tr('file'),
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle.title()
                                                        .copyWith(
                                                      fontSize: 11.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    path.basename(
                                                        state.files[index]),
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        AppTextStyle.subTitle()
                                                            .copyWith(
                                                      fontSize: 11.sp,
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    state.files.removeAt(index);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons
                                                      .remove_circle_outline_outlined,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  }
                  return SizedBox();
                }),

                BlocBuilder<VendorAddToCartCubit, VendorAddToCartState>(
                    builder: (context, state) {
                  if (VendorAddToCartCubit.get(context).selectedDesignStatus ==
                      'with') {
                    return Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .12,
                              width: MediaQuery.of(context).size.height * .12,
                              child: InkWell(
                                onTap: () {
                                  ProductsCubit.get(context)
                                      .pickMultipleImages();
                                },
                                child: Image.asset(
                                  "assets/images/upload.png",
                                  fit: BoxFit.contain,
                                ),
                              )),
                          InkWell(
                              onTap: () {
                                ProductsCubit.get(context).pickMultipleImages();
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                color: Color(0xffDCDCDC),
                              )),
                        ],
                      ),
                    );
                  }
                  return SizedBox();
                }),
//==================================================================
                //* add to cart button
                /*
              BlocBuilder<VendorAddToCartCubit, VendorAddToCartState>(
                  builder: (context, state) {
                    if (VendorAddToCartCubit.get(context)
                            .selectedDesignStatus ==
                        'with') {
                      if (VendorAddToCartCubit.get(context).selectedImage !=
                          null) {
                        return FittedBox(
                          fit: BoxFit.fill,
                          child: Container(
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Color.fromRGBO(160, 160, 162, 1),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.file(
                                  File(VendorAddToCartCubit.get(context)
                                      .selectedImage!),
                                  fit: BoxFit.cover,
                                  height: 100.h,
                                  width: 150.w,
                                ),
                                SizedBox(height: 5.h),
                                InkWell(
                                  onTap: () {
                                    VendorAddToCartCubit.get(context)
                                        .selectImage();
                                  },
                                  child: Text(
                                    'replace_image'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 14.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          VendorAddToCartCubit.get(context).selectImage();
                          // ProductsCubit.get(context).pickMultipleImages();
                        },
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Color.fromRGBO(160, 160, 162, 1),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets.imagesUploadImage,
                                  height: 50.h,
                                  width: 50.w,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  'upload_image'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.primaryColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
                */
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            BlocConsumer<VendorAddToCartCubit, VendorAddToCartState>(
          listener: (context, state) {
            if (state is VendorSuccessAddToCart) {
              if (VendorAddToCartCubit.get(context).selectedDesignStatus !=
                  'without') {
                Future.delayed(Duration(seconds: 3), () {
                  NavigationUtils.navigateBack(context: context);
                  NavigationUtils.navigateBack(context: context);
                });
              }

              VendorAddToCartCubit.get(context).cartCount();
              VendorMyCartCubit.get(context).getMyCart();

              Functions.addToCart(context: context, message: state.message);
            } else if (state is VendorErrorAddToCart) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  content: Text(
                    state.error,
                    style: AppTextStyle.subTitle().copyWith(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (_quantityController.text.isNotEmpty) {
                      if (VendorAddToCartCubit.get(context)
                              .selectedDesignStatus ==
                          'with') {
                        var images = context.read<ProductsCubit>().images;
                        var files = context.read<ProductsCubit>().files;
                        if (images.isEmpty && files.isEmpty) {
                          //images.isEmpty && files.isEmpty
                          showSnackBar(
                            context: context,
                            message: 'select_design'.tr(),
                            backgroundColor: Colors.red,
                          );
                        } else {
                          //! add to cart(with design)
                          VendorAddToCartCubit.get(context).uploadOrderToCart(
                            context: context,
                            supplierId: widget.supplierProductSize
                                .productSizes![0].id!, // supplierProductId
                            quantity: int.parse(_quantityController.text
                                .replaceAll(RegExp(r','), '')),
                          );
                        }
                      } else if (VendorAddToCartCubit.get(context)
                              .selectedDesignStatus ==
                          'with_donate') {
                        //! add to cart(donate with a new)
                        VendorAddToCartCubit.get(context).uploadOrderToCart(
                          context: context,
                          supplierId:
                              widget.supplierProductSize.productSizes![0].id!,
                          quantity: int.parse(_quantityController.text
                              .replaceAll(RegExp(r','), '')),
                        );
                      } else {
                        //! add to cart(without design)
                        VendorAddToCartCubit.get(context).uploadOrderToCart(
                          context: context,
                          supplierId: widget.supplierProductSize
                              .productSizes![0].id!, // supplierProductId
                          quantity: int.parse(_quantityController.text
                              .replaceAll(RegExp(r','), '')),
                        );
                      }
                    } else {
                      showSnackBar(
                        context: context,
                        message: 'enter_req_quantity'.tr(),
                        backgroundColor: Colors.red,
                      );
                    }
                  }
                },
                child: Container(
                  height: 40.h,
                  // width: 100.w,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: state is VendorLoadingAddToCart
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'add'.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bodyText().copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
