import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/core/utils/functions.dart';
import 'package:echo/cubits/supplier_market/supplier_market_cubit.dart';
import 'package:echo/cubits/supplier_market/supplier_market_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    SupplierMarketCubit.get(context).getSupplierOrders();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = SupplierMarketCubit.get(context);
    return BlocBuilder<SupplierMarketCubit, SupplierMarketStates>(
        builder: (context, state) {
      return state is GetSupplierOrdersLoadingState
          ? Center(child: CircularProgressIndicator())
          : cubit.supplierOrdersModel!.data!.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Column(
                              children: [
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     ProfilePicture(
                                //       imageType: ImageType.network,
                                //       imageLink:
                                //           Endpoints.clients +
                                //               cubit.supplierOrdersModel!
                                //                   .data![index].clients!.image.toString(),
                                //       size: 20.sp,
                                //     ),
                                //     SizedBox(
                                //       width: 10.w,
                                //     ),
                                //     Text(
                                //       cubit.supplierOrdersModel!.data![index]
                                //           .clients!.name!,
                                //       style: AppTextStyle.bodyText().copyWith(
                                //           fontSize: 14.sp,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                //-----------------------------------------------
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      " ${"createdAt".tr()}: ",
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                      Functions.convertDateToString(
                                                          date: cubit
                                                              .supplierOrdersModel!
                                                              .data![index]
                                                              .createdAt
                                                              .toString()),
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(height: 10.h),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      cubit.supplierOrdersModel!
                                                          .data![index].quantity
                                                          .toString(),
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      " ${"piece".tr()}",
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(height: 10.h),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      " ${"price".tr()} : ",
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                      cubit
                                                          .supplierOrdersModel!
                                                          .data![index]
                                                          .supplierProductSize!
                                                          .price1
                                                          .toString(),
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      " ${"pound".tr()}",
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(height: 10.h),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      " ${"size".tr()} : ",
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        cubit
                                                            .supplierOrdersModel!
                                                            .data![index]
                                                            .supplierProductSize!
                                                            .sizes!
                                                            .size
                                                            .toString(),
                                                        style: AppTextStyle
                                                                .bodyText()
                                                            .copyWith(
                                                          fontSize: 10.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(height: 10.h),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp),
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor)),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 5.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      " ${"color".tr()} : ",
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Text(
                                                      cubit
                                                          .supplierOrdersModel!
                                                          .data![index]
                                                          .supplierProductSize!
                                                          .supplierProduct!
                                                          .products!
                                                          .color!
                                                          .name!,
                                                      style: AppTextStyle
                                                              .bodyText()
                                                          .copyWith(
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    //-------------------------------------------
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300)),
                                            child: DefaultCachedNetworkImage(
                                              imageUrl: EndPoints.products +
                                                  cubit
                                                      .supplierOrdersModel!
                                                      .data![index]
                                                      .supplierProductSize!
                                                      .supplierProduct!
                                                      .products!
                                                      .image!
                                                      .first,
                                              imageHeight:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.12,
                                              imageWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 5.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.sp),
                                            ),
                                            child: Text(
                                              cubit
                                                  .supplierOrdersModel!
                                                  .data![index]
                                                  .supplierProductSize!
                                                  .supplierProduct!
                                                  .products!
                                                  .name
                                                  .toString(),
                                              style: AppTextStyle.bodyText()
                                                  .copyWith(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                //-----------------------------------
                                Row(
                                  children: [
                                    // Expanded(
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       if (cubit.supplierOrdersModel!
                                    //               .data![index].design
                                    //               .toString() ==
                                    //           "with") {
                                    //         showProductDesign(
                                    //           context: context,
                                    //           image:
                                    //               "https://echo.monsq.com/public/images/product_designs/" +
                                    //                   cubit
                                    //                       .supplierOrdersModel!
                                    //                       .data![index]
                                    //                       .designImage!,
                                    //           button: DefaultButton(
                                    //             onPress: () {
                                    //               Navigator.pop(context);
                                    //             },
                                    //             text: "close".tr(),
                                    //           ),
                                    //         );
                                    //       }
                                    //     },
                                    // child: Container(
                                    //   padding: EdgeInsets.symmetric(
                                    //       horizontal: 10.w, vertical: 5.h),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(5.sp),
                                    //       color: Colors.black
                                    //           .withOpacity(0.3)),
                                    //       child: Text(
                                    //         cubit.supplierOrdersModel!
                                    //                     .data![index].design
                                    //                     .toString() ==
                                    //                 "without"
                                    //             ? "without".tr()
                                    //             : cubit.supplierOrdersModel!
                                    //                         .data![index].design
                                    //                         .toString() ==
                                    //                     "with"
                                    //                 ? "with".tr()
                                    //                 : "with_donate".tr(),
                                    //         style: AppTextStyle.bodyText()
                                    //             .copyWith(
                                    //                 color: Colors.white,
                                    //                 fontSize: 12.sp),
                                    //         textAlign: TextAlign.center,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   width: 10.w,
                                    // ),
                                    // Expanded(
                                    //   child: cubit.supplierOrdersModel!
                                    //               .data![index].status
                                    //               .toString() ==
                                    //           "done"
                                    //       ? Container(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: 10.w,
                                    //               vertical: 5.h),
                                    //           decoration: BoxDecoration(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       9.sp),
                                    //               color: Colors.black
                                    //                   .withOpacity(0.3)),
                                    //           child: Text(
                                    //             "done".tr(),
                                    //             style: AppTextStyle.bodyText()
                                    //                 .copyWith(
                                    //                     color: Colors.white,
                                    //                     fontSize: 12.sp),
                                    //             textAlign: TextAlign.center,
                                    //           ),
                                    //         )
                                    //       : SizedBox(),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                  itemCount: cubit.supplierOrdersModel!.data!.length)
              : Center(
                  child: Text(
                  "no_orders".tr(),
                  style: AppTextStyle.subTitle(),
                ));
    });
  }
}
