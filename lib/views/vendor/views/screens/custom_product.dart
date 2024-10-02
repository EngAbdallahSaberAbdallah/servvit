import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/cubits/all_categories/all_categories_cubit.dart';
import 'package:echo/cubits/all_categories/all_categories_state.dart';
import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/services/local/cache_helper/cache_keys.dart';
import '../../../../core/shared_components/custom_dropdown_formfield.dart';
import '../../../../core/shared_components/custom_pop_up.dart';
import '../../../../core/shared_components/default_button.dart';
import '../../../../core/shared_components/default_text_form_field.dart';
import '../../../../core/shared_components/login_first.dart';
import '../../../../core/text_styles/app_text_style.dart';
import '../../../../core/utils/navigation_utility.dart';
import '../../../../cubits/bottom_navbar/bottom_navbar_cubit.dart';
import '../../../../model/products/vendor_product_model.dart' hide Color;
import 'bottom_navigation_screens/main_screen.dart';
import 'package:path/path.dart' as path;

class CustomProductScreen extends StatefulWidget {
  CustomProductScreen({
    super.key,
    this.productDetails,
  });
  final Data? productDetails;

  @override
  State<CustomProductScreen> createState() => _CustomProductScreenState();
}

class _CustomProductScreenState extends State<CustomProductScreen> {
  var materialController = TextEditingController();

  var lengthController = TextEditingController();
  var widthController = TextEditingController();
  var heightController = TextEditingController();

  var moreController = TextEditingController();
  var colorController = TextEditingController();

  var descriptionController = TextEditingController();

  var quantityController = TextEditingController();

  var categoryController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  int? selectedCategoryId;

  String? selectedCategoryValue;

  @override
  void initState() {
    super.initState();
    if (widget.productDetails != null) {
      descriptionController.text = "${widget.productDetails!.name ?? ""}";
      colorController.text = "${widget.productDetails!.color!.name ?? ""}";
      selectedCategoryValue = widget.productDetails!.category!.name ?? "";
      int index = AllCategoriesCubit.get(context)
          .categories
          .indexOf(widget.productDetails!.category!.name ?? "");
      if (widget.productDetails!.category!.name != null)
        selectedCategoryId =
            AllCategoriesCubit.get(context).categoriesIDs[index];
      log('selectedValue: $selectedCategoryValue , selectedCategoryId: $selectedCategoryId');
    }
  }

  @override
  Widget build(BuildContext context) {
    //todo
    //! 1: set description from product details
    //! 2: set category from product details
    //! 3: triger all methods

    return Scaffold(
      appBar: AppBar(
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
        title: Image.asset(
          "assets/images/logo2.png",
          width: 100.w,
          height: 40.h,
          fit: BoxFit.contain,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: BlocConsumer<ProductsCubit, ProductsStates>(
        builder: (context, state) {
          return DefaultButton(
            onPress: () async {
              if (CacheKeysManger.getUserTokenFromCache() == "") {
                defaultLogin(context: context);
              } else {
                if (formKey.currentState!.validate()) {
                  var images = context.read<ProductsCubit>().images;
                  var files = context.read<ProductsCubit>().files;
                  //todo check images is empty or not
                  if (images.isNotEmpty || files.isNotEmpty) {
                    List<MultipartFile> mutipleImages = await Future.wait(
                      images
                          .map(
                            (file) => MultipartFile.fromFile(file,
                                filename: file.split("/").last),
                          )
                          .toList(),
                    );

                    List<MultipartFile> mutipleFiles = await Future.wait(
                      files
                          .map(
                            (file) => MultipartFile.fromFile(file,
                                filename: file.split("/").last),
                          )
                          .toList(),
                    );

                    log('length: ${mutipleFiles.length}');
                    context.read<ProductsCubit>().sendCustomProduct(
                        size: materialController.text.isNotEmpty
                            ? materialController.text
                            : "",
                        dimension:
                            "${lengthController.text + " * " + widthController.text + " * " + heightController.text}",
                        shape: moreController.text.isNotEmpty
                            ? moreController.text
                            : "",
                        color: colorController.text.isNotEmpty
                            ? colorController.text
                            : "",
                        quantity: quantityController.text.isNotEmpty
                            ? quantityController.text
                            : "",
                        description: descriptionController.text.isNotEmpty
                            ? descriptionController.text
                            : "",
                        category_id: selectedCategoryId.toString(),
                        is_other:
                            selectedCategoryValue == "others".tr() ? "1" : "0",
                        other_type: categoryController.text ?? "",
                        images: mutipleImages,
                        files: mutipleFiles);
                  } else {
                    context.read<ProductsCubit>().sendCustomProduct(
                        size: materialController.text.isNotEmpty
                            ? materialController.text
                            : "",
                        dimension:
                            "${lengthController.text + " * " + widthController.text + " * " + heightController.text}",
                        shape: moreController.text.isNotEmpty
                            ? moreController.text
                            : "",
                        color: colorController.text.isNotEmpty
                            ? colorController.text
                            : "",
                        quantity: quantityController.text.isNotEmpty
                            ? quantityController.text
                            : "",
                        description: descriptionController.text.isNotEmpty
                            ? descriptionController.text
                            : "",
                        category_id: selectedCategoryId.toString(),
                        is_other:
                            selectedCategoryValue == "others".tr() ? "1" : "0",
                        other_type: categoryController.text.isNotEmpty
                            ? categoryController.text
                            : "",
                        images: [],
                        files: []);
                  }

                  //  else {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text("image_req".tr()),
                  //     backgroundColor: Colors.red,
                  //   ));
                  // }
                }
              }
            },
            text: "submit".tr(),
            borderRadius: 0,
            backgroundColor: AppColors.primaryColor,
          );
        },
        listener: (BuildContext context, state) async {
          if (state is SendCustomProductSuccessState) {
            BottomNavbarCubit.get(context).changeBottomNavbar(2);
            context.read<CustomizeRequestCubit>().getAllCustomizeRequests();
            NavigationUtils.navigateReplacement(
                context: context, destinationScreen: VendorMainScreen());

            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    title: Image.asset("assets/images/correct_success.png",
                        height: 70.h),
                    content: Text("weReceiveYourInquiry".tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodyText().copyWith(
                          color: const Color(0xcc323232),
                        )),
                  );
                });
            // customPopUpDialog(
            //   context: context,
            //   button: DefaultButton(
            //     onPress: () {
            //       Navigator.pop(context);
            //       BottomNavbarCubit.get(context).changeBottomNavbar(2);
            //       context
            //           .read<CustomizeRequestCubit>()
            //           .getAllCustomizeRequests();
            //       NavigationUtils.navigateReplacement(
            //           context: context,
            //           destinationScreen: VendorMainScreen());
            //     },
            //     text: "close".tr(),
            //     borderRadius: 10.sp,
            //   ),
            //   icon: "assets/images/success.png",
            //   network: false,
            //   mainTitle: "successMessage".tr(),
            // );
          } else if (state is SendCustomProductErrorState) {
            print(state.error);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          } else if (state is SendCustomProductLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => WillPopScope(
                onWillPop: () {
                  return Future.value(false);
                },
                child: AlertDialog(
                  insetPadding: const EdgeInsets.all(0),
                  contentPadding: EdgeInsets.zero,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SpinKitCubeGrid(
                            color: AppColors.primaryColor,
                            size: 40.0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "send_order".tr(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/custom_product.png",
                        width: MediaQuery.of(context).size.width * .7,
                        fit: BoxFit.contain,
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "custom_your_product".tr(),
                          style: AppTextStyle.title(),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "description".tr(),
                              style: AppTextStyle.title().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            DefaultTextFormField(
                              textInputType: TextInputType.text,
                              controller: descriptionController,
                              validationMsg: "field_req".tr(),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "category".tr(),
                              style: AppTextStyle.title().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            BlocBuilder<AllCategoriesCubit, AllCategoriesState>(
                                builder: (context, state) {
                              if (state is GetAllCategoriesLoadingState) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              // if (widget.productDetails != null &&
                              //     widget.productDetails!.category!.name !=
                              //         null) {
                              // int index = AllCategoriesCubit.get(context)
                              //     .categories
                              //     .indexOf(
                              //         0);
                              selectedCategoryId =
                                  AllCategoriesCubit.get(context)
                                      .categoriesIDs[0];
                              print('selected id is $selectedCategoryId');
                              // }
                              return CustomDropDownButton(
                                firstValue: widget.productDetails != null
                                    ? widget.productDetails!.category!.name ??
                                        null
                                    : null,
                                onChanged: (value) {
                                  log('category changed: $value');
                                  setState(() {
                                    selectedCategoryValue = value;
                                    int index = AllCategoriesCubit.get(context)
                                        .categories
                                        .indexOf(value!);
                                    selectedCategoryId =
                                        AllCategoriesCubit.get(context)
                                            .categoriesIDs[index];
                                  });
                                },
                                items:
                                    AllCategoriesCubit.get(context).categories,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty)
                                    return "field_req".tr();
                                  return null;
                                },
                                hintText: '',
                              );
                            }),
                            selectedCategoryValue == "others".tr()
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "add_category".tr(),
                                        style: AppTextStyle.title().copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      DefaultTextFormField(
                                        textInputType: TextInputType.text,
                                        controller: categoryController,
                                        validationMsg: "field_req".tr(),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(height: 10.h),
                            Text(
                              "dimensions".tr(),
                              style: AppTextStyle.title().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "length".tr(),
                                        style: AppTextStyle.title().copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      DefaultTextFormField(
                                        textInputType: TextInputType.number,
                                        controller: lengthController,
                                        validationMsg: "field_req".tr(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "width".tr(),
                                        style: AppTextStyle.title().copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      DefaultTextFormField(
                                        textInputType: TextInputType.number,
                                        controller: widthController,
                                        validationMsg: "field_req".tr(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "height".tr(),
                                        style: AppTextStyle.title().copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey),
                                        textAlign: TextAlign.justify,
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      DefaultTextFormField(
                                        textInputType: TextInputType.number,
                                        controller: heightController,
                                        validationMsg: "field_req".tr(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "material".tr(),
                              style: AppTextStyle.title().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            DefaultTextFormField(
                              textInputType: TextInputType.text,
                              controller: materialController,
                              // validationMsg: "field_req".tr(),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "quantity".tr(),
                              style: AppTextStyle.title().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            DefaultTextFormField(
                              textInputType: TextInputType.number,
                              controller: quantityController,
                              validationMsg: "field_req".tr(),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "piece".tr(),
                                      style: AppTextStyle.subTitle().copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "more_details".tr(),
                              style: AppTextStyle.title().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            DefaultTextFormField(
                              textInputType: TextInputType.text,
                              controller: moreController,
                              // validationMsg: "field_req".tr(),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "color".tr(),
                              style: AppTextStyle.title().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            DefaultTextFormField(
                              textInputType: TextInputType.text,
                              controller: colorController,
                              // validationMsg: "field_req".tr(),
                            ),
                            SizedBox(height: 10.h),
                            // Row(
                            //   children: [
                            //     Text("select_color".tr()),
                            //     SizedBox(
                            //       width: 10.w,
                            //     ),
                            //     GestureDetector(
                            //       onTap: () {
                            //         showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return AlertDialog(
                            //               title: Text('pick_color'.tr()),
                            //               content: SingleChildScrollView(
                            //                 child: ColorPicker(
                            //                   pickerColor: pickerColor,
                            //                   onColorChanged: (color) {
                            //                     setState(
                            //                         () => pickerColor = color);
                            //                   },
                            //                 ),
                            //               ),
                            //               actions: <Widget>[
                            //                 ElevatedButton(
                            //                   child: Text('got_it'.tr()),
                            //                   onPressed: () {
                            //                     setState(() =>
                            //                         currentColor = pickerColor);
                            //                     Navigator.of(context).pop();
                            //                   },
                            //                 ),
                            //               ],
                            //             );
                            //           },
                            //         );
                            //       },
                            //       child: Container(
                            //         width: 20.h,
                            //         height: 20.h,
                            //         decoration: BoxDecoration(
                            //           border: Border.all(color: Colors.black),
                            //         ),
                            //         child: Padding(
                            //           padding: EdgeInsets.all(2.sp),
                            //           child: Container(
                            //             decoration: BoxDecoration(
                            //               color: pickerColor,
                            //               borderRadius:
                            //                   BorderRadius.circular(3.sp),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 10.h),

                            Text(
                              "attach_image".tr(),
                              style: AppTextStyle.title().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10.h),
                            BlocBuilder<ProductsCubit, ProductsStates>(
                              builder: (context, state) {
                                if (state is UploadMultipleImagesSuccessState) {
                                  return ProductsCubit.get(context)
                                          .images
                                          .isEmpty
                                      ? SizedBox()
                                      : SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .25,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.images.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                clipBehavior: Clip.hardEdge,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        .25,
                                                margin: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Stack(
                                                  clipBehavior: Clip.hardEdge,
                                                  children: [
                                                    path.extension(state.images[
                                                                    index]) ==
                                                                '.png' ||
                                                            path.extension(state
                                                                        .images[
                                                                    index]) ==
                                                                '.jpg'
                                                        ? Image.file(
                                                            File(state
                                                                .images[index]),
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(tr('file'),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: AppTextStyle
                                                                          .title()
                                                                      .copyWith(
                                                                    fontSize:
                                                                        11.sp,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  )),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                  path.basename(
                                                                      state.images[
                                                                          index]),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: AppTextStyle
                                                                          .subTitle()
                                                                      .copyWith(
                                                                    fontSize:
                                                                        11.sp,
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                  )),
                                                            ],
                                                          ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            state.images
                                                                .removeAt(
                                                                    index);
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

                            BlocBuilder<ProductsCubit, ProductsStates>(
                              builder: (context, state) {
                                if (state is UploadMultipleImagesSuccessState) {
                                  return ProductsCubit.get(context)
                                          .files
                                          .isEmpty
                                      ? SizedBox()
                                      : SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .25,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.files.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                clipBehavior: Clip.hardEdge,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        .25,
                                                margin: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Stack(
                                                  clipBehavior: Clip.hardEdge,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(tr('file'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTextStyle
                                                                    .title()
                                                                .copyWith(
                                                              fontSize: 11.sp,
                                                              color: AppColors
                                                                  .primaryColor,
                                                            )),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            path.basename(state
                                                                .files[index]),
                                                            textAlign: TextAlign
                                                                .center,
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
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            state.files
                                                                .removeAt(
                                                                    index);
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

                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .12,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .12,
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
                                        ProductsCubit.get(context)
                                            .pickMultipleImages();
                                      },
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Color(0xffDCDCDC),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
