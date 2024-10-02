import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/custom_carousel_slider.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/assets.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/products/products_cubit.dart';
import 'package:echo/model/products/products_model.dart';
import 'package:echo/views/supplier/add_to_market/add_to_market_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.productDetails})
      : super(key: key);

  final Data productDetails;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<String> images = [];
  List<String> sizes = [];
  List<int> sizesIds = [];
  List<int> colorsIds = [];

  @override
  void initState() {
    super.initState();
    //Fayez Edit this
    context
        .read<ProductsCubit>()
        .getSupplierProductSizes(productId: widget.productDetails.id!);
    if (widget.productDetails.image!.isNotEmpty) {
      for (int i = 0; i < widget.productDetails.image!.length; i++) {
        images.add(
            EndPoints.products + widget.productDetails.image![i].toString());
      }
    }
  }

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
      body: BlocBuilder<ProductsCubit, ProductsStates>(
        builder: (context, state) {
          if (state is GetProductSizesSuccessState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CustomCarouselItem(
                      images: images,
                      imageHeight: MediaQuery.of(context).size.height * .3,
                    ),
                    // DefaultCachedNetworkImage(
                    //     imageUrl: widget.productDetails.image![0],
                    //     imageHeight: MediaQuery.of(context).size.height * 0.3,
                    //     imageWidth: MediaQuery.of(context).size.width ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        widget.productDetails.name!,
                        style: AppTextStyle.headLine()
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildBodyItem(
                              title: "description".tr() + " :",
                              value: widget.productDetails.description),
                          //Fayez Stoped this
                          if (ProductsCubit.get(context)
                              .productSizesModel!
                              .data![0]
                              .productSizes!
                              .isNotEmpty)
                            SizedBox(height: 10.h),
                          if (ProductsCubit.get(context)
                              .productSizesModel!
                              .data![0]
                              .productSizes!
                              .isNotEmpty)
                            Row(
                              children: [
                                Text(
                                  "sizes".tr() + " :",
                                  style: AppTextStyle.bodyText()
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                ...List.generate(
                                  ProductsCubit.get(context)
                                      .productSizesModel!
                                      .data![0]
                                      .productSizes!
                                      .length,
                                  (index) => Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Text(
                                        ProductsCubit.get(context)
                                            .productSizesModel!
                                            .data![0]
                                            .productSizes![index]
                                            .size!,
                                        style: AppTextStyle.bodyText().copyWith(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 10.h),
                          buildBodyItem(
                              title: "categories".tr() + " :",
                              value: widget.productDetails.category!.name),
                          SizedBox(height: 10.h),
                          // buildBodyItem(title: "Review :", value: "3"),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    DefaultButton(
                      onPress: () {
                        sizes.clear();
                        sizesIds.clear();
                        if (ProductsCubit.get(context)
                            .productSizesModel!
                            .data![0]
                            .productSizes!
                            .isNotEmpty) {
                          for (int i = 0;
                              i <
                                  ProductsCubit.get(context)
                                      .productSizesModel!
                                      .data![0]
                                      .productSizes!
                                      .length;
                              i++) {
                            sizes.add(ProductsCubit.get(context)
                                .productSizesModel!
                                .data![0]
                                .productSizes![i]
                                .size
                                .toString());
                            sizesIds.add(ProductsCubit.get(context)
                                .productSizesModel!
                                .data![0]
                                .productSizes![i]
                                .id!);
                          }
                        }
                        NavigationUtils.navigateTo(
                            context: context,
                            destinationScreen: AddProductToMarketScreen(
                              productDetails: widget.productDetails,
                              sizes: sizes,
                              // colors: colors,
                              sizesIds: sizesIds,
                              images: images,
                            ));
                      },
                      text: "add_market".tr(),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetProductSizesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetProductSizesErrorState) {
            return SizedBox();
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget buildBodyItem({
    required String title,
    String? value,
  }) =>
      Row(
        children: [
          Text(
            title,
            style:
                AppTextStyle.bodyText().copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              value!,
              style: AppTextStyle.bodyText()
                  .copyWith(color: Colors.black, fontSize: 14.sp),
            ),
          ),
        ],
      );
}
