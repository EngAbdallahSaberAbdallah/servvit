import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/supplier_market/supplier_market_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_states.dart';
import 'package:echo/views/supplier/add_to_market/add_to_market_new_size_screen.dart';
import 'package:echo/views/supplier/market/market_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  void initState() {
    super.initState();
    SupplierMarketCubit.get(context).getSupplierProducts();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = SupplierMarketCubit.get(context);
    return Column(
      children: [
        SizedBox(height: 10.h),
        Text(
          "your_market".tr(),
          style: AppTextStyle.headLine()
              .copyWith(color: Colors.black, fontSize: 18.sp),
        ),
        SizedBox(height: 20.h),
        Expanded(
          child: BlocBuilder<SupplierMarketCubit, SupplierMarketStates>(
              builder: (context, state) {
            return state is GetSupplierProductsLoadingState
                ? const Center(child: CircularProgressIndicator())
                : cubit.supplierProductsModel!.data!.isNotEmpty
                    ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10.sp),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        cubit.supplierProductsModel!
                                            .data![index].products!.name!,
                                        style: AppTextStyle.title(),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (cubit
                                                      .supplierProductsModel!
                                                      .data![index]
                                                      .products!
                                                      .category!
                                                      .name !=
                                                  null)
                                                Text(
                                                  "${"category".tr()} : ${cubit.supplierProductsModel!.data![index].products!.category!.name ?? ""}",
                                                  style:
                                                      AppTextStyle.subTitle(),
                                                ),
                                              if (cubit
                                                      .supplierProductsModel!
                                                      .data![index]
                                                      .products!
                                                      .color!
                                                      .name !=
                                                  null)
                                                Text(
                                                  "${"color".tr()} : ${cubit.supplierProductsModel!.data![index].products!.color!.name ?? ""}",
                                                  style:
                                                      AppTextStyle.subTitle(),
                                                ),
                                              if (cubit
                                                      .supplierProductsModel!
                                                      .data![index]
                                                      .products!
                                                      .dimension !=
                                                  null)
                                                Text(
                                                  "${"dimension".tr()} : ${cubit.supplierProductsModel!.data![index].products!.dimension ?? ""}",
                                                  style:
                                                      AppTextStyle.subTitle(),
                                                ),
                                              if (cubit
                                                      .supplierProductsModel!
                                                      .data![index]
                                                      .products!
                                                      .material !=
                                                  null)
                                                Text(
                                                  "${"material".tr()} : ${cubit.supplierProductsModel!.data![index].products!.material ?? ""}",
                                                  style:
                                                      AppTextStyle.subTitle(),
                                                ),
                                              if (cubit
                                                      .supplierProductsModel!
                                                      .data![index]
                                                      .products!
                                                      .description !=
                                                  null)
                                                Text(
                                                  "${"description".tr()} : ${cubit.supplierProductsModel!.data![index].products!.description ?? ""}",
                                                  style:
                                                      AppTextStyle.subTitle(),
                                                ),
                                            ],
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          child: DefaultCachedNetworkImage(
                                              imageUrl: EndPoints.products +
                                                  cubit
                                                      .supplierProductsModel!
                                                      .data![index]
                                                      .products!
                                                      .image![0],
                                              imageHeight:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.18,
                                              fit: BoxFit.fill,
                                              imageWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3),
                                        )
                                      ],
                                    ),
                                    if (cubit.supplierProductsModel!
                                            .data![index].productSizes!.length >
                                        0)
                                      SizedBox(
                                        height: 30.h,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${"size".tr()} : ",
                                              style: AppTextStyle.subTitle(),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemBuilder:
                                                    (context, sizeIndex) {
                                                  return Container(
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .only(end: 10.w),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.sp),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.sp,
                                                              vertical: 5.sp),
                                                      child: Text(
                                                        cubit
                                                            .supplierProductsModel!
                                                            .data![index]
                                                            .productSizes![
                                                                sizeIndex]
                                                            .sizes!
                                                            .size!,
                                                        style:
                                                            AppTextStyle.title()
                                                                .copyWith(
                                                                    fontSize:
                                                                        12.sp),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: cubit
                                                    .supplierProductsModel!
                                                    .data![index]
                                                    .productSizes!
                                                    .length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: DefaultButton(
                                            onPress: () {
                                              List<String> images = [];

                                              if (cubit
                                                  .supplierProductsModel!
                                                  .data![index]
                                                  .products!
                                                  .image!
                                                  .isNotEmpty) {
                                                for (int i = 0;
                                                    i <
                                                        cubit
                                                            .supplierProductsModel!
                                                            .data![index]
                                                            .products!
                                                            .image!
                                                            .length;
                                                    i++) {
                                                  images.add(EndPoints
                                                          .products +
                                                      cubit
                                                          .supplierProductsModel!
                                                          .data![index]
                                                          .products!
                                                          .image![i]
                                                          .toString());
                                                }
                                              }
                                              NavigationUtils.navigateTo(
                                                  context: context,
                                                  destinationScreen:
                                                      AddNewSizeProductToMarketScreen(
                                                    productDetails: cubit
                                                        .supplierProductsModel!
                                                        .data![index],
                                                    images: images,
                                                  ));
                                            },
                                            text: "add_size".tr(),
                                            fontSize: 14.sp,
                                            borderRadius: 20.sp,
                                            height: 4.h,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Flexible(
                                          child: DefaultButton(
                                            onPress: () {
                                              if (cubit
                                                  .supplierProductsModel!
                                                  .data![index]
                                                  .productSizes!
                                                  .isNotEmpty) {
                                                NavigationUtils.navigateTo(
                                                    context: context,
                                                    destinationScreen:
                                                        MarketDetailsScreen(
                                                      productSizes: cubit
                                                          .supplierProductsModel!
                                                          .data![index]
                                                          .productSizes!,
                                                      image: EndPoints
                                                              .products +
                                                          cubit
                                                              .supplierProductsModel!
                                                              .data![index]
                                                              .products!
                                                              .image![0],
                                                      indexNumber: index,
                                                      name: cubit
                                                          .supplierProductsModel!
                                                          .data![index]
                                                          .products!
                                                          .name!,
                                                    ));
                                              }
                                            },
                                            text: "details".tr(),
                                            fontSize: 14.sp,
                                            borderRadius: 20.sp,
                                            height: 4.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: cubit.supplierProductsModel!.data!.length,
                      )
                    : Center(
                        child: Text(
                        "no_market".tr(),
                        style: AppTextStyle.subTitle(),
                      ));
          }),
        )
      ],
    );
  }

  Widget bodyItem({required String title, double? fontSize}) => Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.sp),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.sp),
            border: Border.all(),
          ),
          alignment: AlignmentDirectional.center,
          child: Text(
            title,
            style: AppTextStyle.title().copyWith(
              fontSize: fontSize ?? 14.sp,
            ),
          ),
        ),
      );
}
