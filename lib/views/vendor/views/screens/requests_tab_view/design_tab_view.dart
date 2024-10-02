import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/utils/functions.dart';
import 'package:echo/cubits/add_to_cart_designed/add_to_cart_designed_cubit.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/cubits/reject_designed_request/reject_designed_request_cubit.dart';
import 'package:echo/cubits/reject_designed_request/reject_designed_request_states.dart';
import 'package:echo/model/design_request/design_request_model.dart';
import 'package:echo/views/vendor/views/screens/bottom_navigation_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/services/local/cache_helper/cache_keys.dart';
import '../../../../../core/shared_components/custom_pop_up.dart';
import '../../../../../core/shared_components/default_button.dart';
import '../../../../../core/shared_components/default_cached_network_image.dart';
import '../../../../../core/shared_components/error_widget.dart';
import '../../../../../core/shared_components/show_product_design.dart';
import '../../../../../core/text_styles/app_text_style.dart';
import '../../../../../cubits/add_to_cart_designed/add_to_cart_designed_states.dart';
import '../../../../../cubits/design_request/design_request_cubit.dart';
import '../../../../../cubits/design_request/design_request_states.dart';

class DesignTabView extends StatefulWidget {
  const DesignTabView({super.key, required this.index});

  final int index;

  @override
  State<DesignTabView> createState() => _DesignTabViewState();
}

class _DesignTabViewState extends State<DesignTabView> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: BlocBuilder<DesignRequestCubit, DesignRequestState>(
        builder: (context, state) {
          if (state is GetDesignRequestSuccessState) {
            if (widget.index == 0) {
              List<Data> designList = [];
              state.model.data!.forEach((element) {
                if (element.design == "with") {
                  designList.add(element);
                }
              });
              return designList.isEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<DesignRequestCubit>()
                            .getAllDesignRequests();
                      },
                      child: ListView(
                        padding: EdgeInsets.only(bottom: 10.h),
                        children: [
                          GestureDetector(
                            onTap: () {
                              BottomNavbarCubit.get(context)
                                  .changeBottomNavbar(2);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VendorMainScreen()));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.primaryColor.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(30.sp),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: Padding(
                                  padding: EdgeInsets.all(5.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 13.sp,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15.sp,
                                        ),
                                        backgroundColor: AppColors.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "add_printed".tr(),
                                        style: AppTextStyle.title()
                                            .copyWith(fontSize: 13.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/no_sessions.svg",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            BottomNavbarCubit.get(context)
                                .changeBottomNavbar(2);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VendorMainScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(30.sp),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 13.sp,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15.sp,
                                      ),
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "add_printed".tr(),
                                      style: AppTextStyle.title()
                                          .copyWith(fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<DesignRequestCubit>()
                                  .getAllDesignRequests();
                            },
                            child: ListView.separated(
                              padding: EdgeInsets.only(bottom: 10.h),
                              itemCount: designList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10.sp),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    designList[index]
                                                        .supplierProductSize!
                                                        .supplierProduct!
                                                        .products!
                                                        .name!,
                                                    style: AppTextStyle.title(),
                                                    overflow: TextOverflow
                                                        .ellipsis, // Optional: adds ellipsis at the end if text overflows
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Expanded(
                                            //       child: Row(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment
                                            //                 .center,
                                            //         children: [
                                            //           Column(
                                            //             children: [
                                            //               Container(
                                            //                 decoration:
                                            //                     BoxDecoration(
                                            //                         borderRadius:
                                            //                             BorderRadius.circular(40
                                            //                                 .sp),
                                            //                         border:
                                            //                             Border
                                            //                                 .all(
                                            //                           color: AppColors
                                            //                               .primaryColor,
                                            //                         )),
                                            //                 child: Padding(
                                            //                   padding: EdgeInsets
                                            //                       .symmetric(
                                            //                           horizontal:
                                            //                               20.sp,
                                            //                           vertical:
                                            //                               3.sp),
                                            //                   child: Text(
                                            //                     designList[index]
                                            //                             .quantity! +
                                            //                         "unit".tr(),
                                            //                     style: AppTextStyle
                                            //                             .title()
                                            //                         .copyWith(
                                            //                             fontSize:
                                            //                                 14.sp),
                                            //                   ),
                                            //                 ),
                                            //               )
                                            //             ],
                                            //           )
                                            //         ],
                                            //       ),
                                            //     ),
                                            //     designList[index].sentStatus ==
                                            //             "yes"
                                            //         ? SizedBox(width: 10.w)
                                            //         : SizedBox(),
                                            //     designList[index].sentStatus ==
                                            //             "yes"
                                            //         ?
                                            //     Expanded(
                                            //             child: Row(
                                            //               mainAxisAlignment:
                                            //                   MainAxisAlignment
                                            //                       .center,
                                            //               children: [
                                            //                 Column(
                                            //                   children: [
                                            //                     Container(
                                            //                       decoration:
                                            //                           BoxDecoration(
                                            //                               borderRadius: BorderRadius.circular(40
                                            //                                   .sp),
                                            //                               border:
                                            //                                   Border.all(
                                            //                                 color:
                                            //                                     AppColors.primaryColor,
                                            //                               )),
                                            //                       child:
                                            //                           Padding(
                                            //                         padding: EdgeInsets.symmetric(
                                            //                             horizontal: 20
                                            //                                 .sp,
                                            //                             vertical:
                                            //                                 3.sp),
                                            //                         child: Text(
                                            //                           designList[index]
                                            //                                   .totalCost! +
                                            //                               " " +
                                            //                               "pound"
                                            //                                   .tr(),
                                            //                           style: AppTextStyle
                                            //                                   .title()
                                            //                               .copyWith(
                                            //                                   fontSize: 14.sp),
                                            //                         ),
                                            //                       ),
                                            //                     )
                                            //                   ],
                                            //                 )
                                            //               ],
                                            //             ),
                                            //           )
                                            //         : SizedBox(),
                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 17.sp,
                                                            backgroundColor:
                                                                AppColors
                                                                    .primaryColor,
                                                            child: Icon(
                                                              Icons
                                                                  .factory_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 20.sp,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            "SU - " +
                                                                designList[
                                                                        index]
                                                                    .supplierProductSize!
                                                                    .supplierProduct!
                                                                    .supplierId
                                                                    .toString(),
                                                            style: AppTextStyle
                                                                    .title()
                                                                .copyWith(
                                                                    fontSize:
                                                                        14.sp),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      designList[index]
                                                                  .supplierProductSize!
                                                                  .sizes!
                                                                  .size !=
                                                              null
                                                          ? Text(
                                                              "${"size".tr()} : ${designList[index].supplierProductSize!.sizes!.size}",
                                                              style: AppTextStyle
                                                                  .subTitle(),
                                                            )
                                                          : const SizedBox(),
                                                      designList[index]
                                                                  .supplierProductSize!
                                                                  .supplierProduct!
                                                                  .products!
                                                                  .color!
                                                                  .name !=
                                                              null
                                                          ? Text(
                                                              "${"color".tr()} : ${designList[index].supplierProductSize!.supplierProduct!.products!.color!.name}",
                                                              style: AppTextStyle
                                                                  .subTitle(),
                                                            )
                                                          : const SizedBox(),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (designList[index]
                                                            .supplierProductSize!
                                                            .supplierProduct!
                                                            .products!
                                                            .image![0] !=
                                                        null ||
                                                    designList[index]
                                                        .supplierProductSize!
                                                        .supplierProduct!
                                                        .products!
                                                        .image![0]
                                                        .isNotEmpty)
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                    child: DefaultCachedNetworkImage(
                                                        imageUrl: EndPoints
                                                                .products +
                                                            designList[index]
                                                                .supplierProductSize!
                                                                .supplierProduct!
                                                                .products!
                                                                .image![0],
                                                        imageHeight:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.11,
                                                        fit: BoxFit.contain,
                                                        imageWidth:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3),
                                                  )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 3.sp),
                                                    child: Text(
                                                      designList[index]
                                                              .quantity!
                                                              .toString() +
                                                          "unit".tr(),
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                                  fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                                designList[index].sentStatus ==
                                                        "yes"
                                                    ? SizedBox(width: 10.w)
                                                    : SizedBox(),
                                                designList[index].sentStatus ==
                                                            "yes" &&
                                                        designList[index]
                                                                .totalCost !=
                                                            null
                                                    ? Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          border: Border.all(
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w,
                                                                  vertical:
                                                                      3.sp),
                                                          child: Text(
                                                            designList[index]
                                                                    .totalCost!
                                                                    .toString() +
                                                                " " +
                                                                "pound".tr(),
                                                            style: AppTextStyle
                                                                    .title()
                                                                .copyWith(
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            designList[index].sentStatus == "no"
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "waiting_cost".tr(),
                                                            style: AppTextStyle
                                                                .bodyText(),
                                                          ),
                                                          Text(
                                                            ".....",
                                                            style: AppTextStyle
                                                                .bodyText(),
                                                          ),
                                                          if (designList[index]
                                                                  .sentStatus ==
                                                              "yes")
                                                            SizedBox(
                                                                height: 10.w),
                                                          if (designList[index]
                                                                      .sentStatus ==
                                                                  "yes" &&
                                                              designList[index]
                                                                      .totalCost !=
                                                                  null)
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(40
                                                                              .sp),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                      )),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 20
                                                                            .sp,
                                                                        vertical:
                                                                            3.sp),
                                                                child: Text(
                                                                  designList[index]
                                                                          .totalCost!
                                                                          .toString() +
                                                                      " " +
                                                                      "pound"
                                                                          .tr(),
                                                                  style: AppTextStyle
                                                                          .title()
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      BlocConsumer<
                                                          AddToCartDesignedRequestCubit,
                                                          AddToCartDesignedRequestState>(
                                                        builder:
                                                            (context, state) {
                                                          return BlocBuilder<
                                                              DesignRequestCubit,
                                                              DesignRequestState>(
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is GetDesignRequestSuccessState) {
                                                                return Flexible(
                                                                  child:
                                                                      DefaultButton(
                                                                    onPress:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              AddToCartDesignedRequestCubit>()
                                                                          .AddToCartDesignedRequests(
                                                                              productId: designList[index].id.toString());
                                                                    },
                                                                    text: "add_to_card"
                                                                        .tr(),
                                                                    fontSize:
                                                                        12.sp,
                                                                    borderRadius:
                                                                        20.sp,
                                                                    height: 4.h,
                                                                  ),
                                                                );
                                                              } else {
                                                                return SizedBox();
                                                              }
                                                            },
                                                          );
                                                        },
                                                        listener: (BuildContext
                                                                context,
                                                            state) {
                                                          if (state
                                                              is GetAddToCartDesignedRequestSuccessState) {
                                                            Navigator.pop(
                                                                context);
                                                            Functions.addToCart(
                                                                context:
                                                                    context,
                                                                message:
                                                                    "add_to_cart_message"
                                                                        .tr());
                                                            // customPopUpDialog(
                                                            //   context: context,
                                                            //   icon:
                                                            //       "assets/images/success.png",
                                                            //   mainTitle:
                                                            //       "add_to_cart_message"
                                                            //           .tr(),
                                                            //   network: false,
                                                            // );
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 2),
                                                                () {
                                                              context
                                                                  .read<
                                                                      DesignRequestCubit>()
                                                                  .getAllDesignRequests();
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          } else if (state
                                                              is GetAddToCartDesignedRequestErrorState) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                CacheKeysManger
                                                                            .getLanguageFromCache() ==
                                                                        "ar"
                                                                    ? "حدث خطأ ما الرجاء المحاولة لاحقا"
                                                                    : "Something Went Error!",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTextStyle
                                                                        .subTitle()
                                                                    .copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ));
                                                            Navigator.pop(
                                                                context);
                                                          } else if (state
                                                              is GetAddToCartDesignedRequestLoadingState) {
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder: (context) =>
                                                                  WillPopScope(
                                                                onWillPop: () {
                                                                  return Future
                                                                      .value(
                                                                          false);
                                                                },
                                                                child:
                                                                    AlertDialog(
                                                                  insetPadding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          0),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  content:
                                                                      SizedBox(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              20),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          SpinKitCubeGrid(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            size:
                                                                                40.0,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "جاري ارسال الطلب".tr(),
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      BlocConsumer<
                                                          RejectDesignedRequestCubit,
                                                          RejectDesignedRequestState>(
                                                        builder:
                                                            (context, state) {
                                                          return BlocBuilder<
                                                              DesignRequestCubit,
                                                              DesignRequestState>(
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is GetDesignRequestSuccessState) {
                                                                return Flexible(
                                                                  child:
                                                                      DefaultButton(
                                                                    onPress:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              RejectDesignedRequestCubit>()
                                                                          .RejectDesignedRequests(
                                                                            requestId:
                                                                                designList[index].id.toString(),
                                                                          );
                                                                    },
                                                                    text: "reject"
                                                                        .tr(),
                                                                    fontSize:
                                                                        12.sp,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    borderRadius:
                                                                        20.sp,
                                                                    height: 4.h,
                                                                  ),
                                                                );
                                                              } else {
                                                                return SizedBox();
                                                              }
                                                            },
                                                          );
                                                        },
                                                        listener: (BuildContext
                                                                context,
                                                            state) {
                                                          if (state
                                                              is RejectDesignedRequestSuccessState) {
                                                            Navigator.pop(
                                                                context);
                                                            customPopUpDialog(
                                                              context: context,
                                                              icon:
                                                                  "assets/images/cancel.png",
                                                              mainTitle:
                                                                  "request_removed"
                                                                      .tr(),
                                                              network: false,
                                                            );
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 2),
                                                                () {
                                                              context
                                                                  .read<
                                                                      DesignRequestCubit>()
                                                                  .getAllDesignRequests();
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          } else if (state
                                                              is RejectDesignedRequestErrorState) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                CacheKeysManger
                                                                            .getLanguageFromCache() ==
                                                                        "ar"
                                                                    ? "حدث خطأ ما الرجاء المحاولة لاحقا"
                                                                    : "Something Went Error!",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTextStyle
                                                                        .subTitle()
                                                                    .copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ));
                                                            Navigator.pop(
                                                                context);
                                                          } else if (state
                                                              is RejectDesignedRequestLoadingState) {
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder: (context) =>
                                                                  WillPopScope(
                                                                onWillPop: () {
                                                                  return Future
                                                                      .value(
                                                                          false);
                                                                },
                                                                child:
                                                                    AlertDialog(
                                                                  insetPadding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          0),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  content:
                                                                      SizedBox(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              20),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          SpinKitCubeGrid(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            size:
                                                                                40.0,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "جاري ارسال الطلب".tr(),
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                                    ],
                                                  ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: DefaultButton(
                                                    onPress: () {
                                                      showProductDesign(
                                                          context: context,
                                                          image: EndPoints
                                                                  .public +
                                                              designList[index]
                                                                  .designImage!,
                                                          button: DefaultButton(
                                                              onPress: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              text: "close"
                                                                  .tr()));
                                                    },
                                                    text: "with_design".tr(),
                                                    fontSize: 12.sp,
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
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
            } else {
              List<Data> donateList = [];
              state.model.data!.forEach((element) {
                if (element.design != "with") {
                  donateList.add(element);
                }
              });
              return donateList.isEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<DesignRequestCubit>()
                            .getAllDesignRequests();
                      },
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              BottomNavbarCubit.get(context)
                                  .changeBottomNavbar(2);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VendorMainScreen()));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.primaryColor.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(30.sp),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: Padding(
                                  padding: EdgeInsets.all(5.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 13.sp,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15.sp,
                                        ),
                                        backgroundColor: AppColors.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "add_donation".tr(),
                                        style: AppTextStyle.title()
                                            .copyWith(fontSize: 13.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/no_sessions.svg",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            BottomNavbarCubit.get(context)
                                .changeBottomNavbar(2);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VendorMainScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(30.sp),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 13.sp,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 15.sp,
                                      ),
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "add_donation".tr(),
                                      style: AppTextStyle.title()
                                          .copyWith(fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<DesignRequestCubit>()
                                  .getAllDesignRequests();
                            },
                            child: ListView.separated(
                              itemCount: donateList.length,
                              padding: const EdgeInsets.only(bottom: 10),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10.sp),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  donateList[index]
                                                      .supplierProductSize!
                                                      .supplierProduct!
                                                      .products!
                                                      .name!,
                                                  style: AppTextStyle.title(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(40
                                                                            .sp),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                    )),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.sp,
                                                                      vertical:
                                                                          3.sp),
                                                              child: Text(
                                                                donateList[index]
                                                                        .quantity!
                                                                        .toString() +
                                                                    "unit".tr(),
                                                                style: AppTextStyle
                                                                        .title()
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                donateList[index].sentStatus ==
                                                        "yes"
                                                    ? SizedBox(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                .01)
                                                    : SizedBox(),
                                                donateList[index].sentStatus ==
                                                        "yes"
                                                    ? Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(40
                                                                              .sp),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                          )),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 20
                                                                            .sp,
                                                                        vertical:
                                                                            3.sp),
                                                                    child: Text(
                                                                      donateList[index]
                                                                              .totalCost!
                                                                              .toString() +
                                                                          " " +
                                                                          "pound"
                                                                              .tr(),
                                                                      style: AppTextStyle
                                                                              .title()
                                                                          .copyWith(
                                                                              fontSize: 14.sp),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 17.sp,
                                                            backgroundColor:
                                                                AppColors
                                                                    .primaryColor,
                                                            child: Icon(
                                                              Icons
                                                                  .factory_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 20.sp,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            "SU - " +
                                                                donateList[
                                                                        index]
                                                                    .supplierProductSize!
                                                                    .supplierProduct!
                                                                    .supplierId
                                                                    .toString(),
                                                            style: AppTextStyle
                                                                    .title()
                                                                .copyWith(
                                                                    fontSize:
                                                                        14.sp),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        "${"size".tr()} : ${donateList[index].supplierProductSize!.sizes!.size}",
                                                        style: AppTextStyle
                                                            .subTitle(),
                                                      ),
                                                      Text(
                                                        "${"color".tr()} : ${donateList[index].supplierProductSize!.supplierProduct!.products!.color!.name}",
                                                        style: AppTextStyle
                                                            .subTitle(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  child: DefaultCachedNetworkImage(
                                                      imageUrl: EndPoints
                                                              .products +
                                                          donateList[index]
                                                              .supplierProductSize!
                                                              .supplierProduct!
                                                              .products!
                                                              .image![0],
                                                      imageHeight:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.11,
                                                      fit: BoxFit.contain,
                                                      imageWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            donateList[index].sentStatus == "no"
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "waiting_cost".tr(),
                                                            style: AppTextStyle
                                                                .bodyText(),
                                                          ),
                                                          Text(
                                                            ".....",
                                                            style: AppTextStyle
                                                                .bodyText(),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      BlocConsumer<
                                                          AddToCartDesignedRequestCubit,
                                                          AddToCartDesignedRequestState>(
                                                        builder:
                                                            (context, state) {
                                                          return BlocBuilder<
                                                              DesignRequestCubit,
                                                              DesignRequestState>(
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is GetDesignRequestSuccessState) {
                                                                return Flexible(
                                                                  child:
                                                                      DefaultButton(
                                                                    onPress:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              AddToCartDesignedRequestCubit>()
                                                                          .AddToCartDesignedRequests(
                                                                              productId: donateList[index].id.toString());
                                                                    },
                                                                    text: "add_to_card"
                                                                        .tr(),
                                                                    fontSize:
                                                                        12.sp,
                                                                    borderRadius:
                                                                        20.sp,
                                                                    height: 4.h,
                                                                  ),
                                                                );
                                                              } else {
                                                                return SizedBox();
                                                              }
                                                            },
                                                          );
                                                        },
                                                        listener: (BuildContext
                                                                context,
                                                            state) {
                                                          if (state
                                                              is GetAddToCartDesignedRequestSuccessState) {
                                                            Navigator.pop(
                                                                context);
                                                            Functions.addToCart(
                                                                context:
                                                                    context,
                                                                message:
                                                                    "add_to_cart_message"
                                                                        .tr());
                                                            // customPopUpDialog(
                                                            //   context: context,
                                                            //   icon:
                                                            //       "assets/images/success.png",
                                                            //   mainTitle:
                                                            //       "add_to_cart_message"
                                                            //           .tr(),
                                                            //   network: false,
                                                            // );
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 2),
                                                                () {
                                                              context
                                                                  .read<
                                                                      DesignRequestCubit>()
                                                                  .getAllDesignRequests();
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          } else if (state
                                                              is GetAddToCartDesignedRequestErrorState) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                CacheKeysManger
                                                                            .getLanguageFromCache() ==
                                                                        "ar"
                                                                    ? "حدث خطأ ما الرجاء المحاولة لاحقا"
                                                                    : "Something Went Error!",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTextStyle
                                                                        .subTitle()
                                                                    .copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ));
                                                            Navigator.pop(
                                                                context);
                                                          } else if (state
                                                              is GetAddToCartDesignedRequestLoadingState) {
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder: (context) =>
                                                                  WillPopScope(
                                                                onWillPop: () {
                                                                  return Future
                                                                      .value(
                                                                          false);
                                                                },
                                                                child:
                                                                    AlertDialog(
                                                                  insetPadding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          0),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  content:
                                                                      SizedBox(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              20),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          SpinKitCubeGrid(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            size:
                                                                                40.0,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "جاري ارسال الطلب".tr(),
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      BlocConsumer<
                                                          RejectDesignedRequestCubit,
                                                          RejectDesignedRequestState>(
                                                        builder:
                                                            (context, state) {
                                                          return BlocBuilder<
                                                              DesignRequestCubit,
                                                              DesignRequestState>(
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is GetDesignRequestSuccessState) {
                                                                return Flexible(
                                                                  child:
                                                                      DefaultButton(
                                                                    onPress:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              RejectDesignedRequestCubit>()
                                                                          .RejectDesignedRequests(
                                                                            requestId:
                                                                                donateList[index].id.toString(),
                                                                          );
                                                                    },
                                                                    text: "reject"
                                                                        .tr(),
                                                                    fontSize:
                                                                        12.sp,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    borderRadius:
                                                                        20.sp,
                                                                    height: 4.h,
                                                                  ),
                                                                );
                                                              } else {
                                                                return SizedBox();
                                                              }
                                                            },
                                                          );
                                                        },
                                                        listener: (BuildContext
                                                                context,
                                                            state) {
                                                          if (state
                                                              is RejectDesignedRequestSuccessState) {
                                                            Navigator.pop(
                                                                context);
                                                            customPopUpDialog(
                                                              context: context,
                                                              icon:
                                                                  "assets/images/cancel.png",
                                                              mainTitle:
                                                                  "request_removed"
                                                                      .tr(),
                                                              network: false,
                                                            );
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 2),
                                                                () {
                                                              context
                                                                  .read<
                                                                      DesignRequestCubit>()
                                                                  .getAllDesignRequests();
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          } else if (state
                                                              is RejectDesignedRequestErrorState) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                CacheKeysManger
                                                                            .getLanguageFromCache() ==
                                                                        "ar"
                                                                    ? "حدث خطأ ما الرجاء المحاولة لاحقا"
                                                                    : "Something Went Error!",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: AppTextStyle
                                                                        .subTitle()
                                                                    .copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ));
                                                            Navigator.pop(
                                                                context);
                                                          } else if (state
                                                              is RejectDesignedRequestLoadingState) {
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder: (context) =>
                                                                  WillPopScope(
                                                                onWillPop: () {
                                                                  return Future
                                                                      .value(
                                                                          false);
                                                                },
                                                                child:
                                                                    AlertDialog(
                                                                  insetPadding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          0),
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  content:
                                                                      SizedBox(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              20),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          SpinKitCubeGrid(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            size:
                                                                                40.0,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "جاري ارسال الطلب".tr(),
                                                                            style:
                                                                                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                                    ],
                                                  ),
                                            // SizedBox(height: 10.h),
                                            // Row(
                                            //   children: [
                                            //     Flexible(
                                            //       child: DefaultButton(
                                            //         onPress: () {
                                            //           showProductDesign(
                                            //               context: context,
                                            //               image:Endpoints.public+ donateList[index].designImage!,
                                            //               button: DefaultButton(
                                            //                   onPress: () {
                                            //                     Navigator.pop(context);
                                            //                   },
                                            //                   text: "close".tr()));
                                            //         },
                                            //         text: "with_design".tr(),
                                            //         fontSize: 12.sp,
                                            //         borderRadius: 20.sp,
                                            //         height: 4.h,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
            }
          } else if (state is GetDesignRequestErrorState) {
            return CustomErrorWidget(
              onTap: () {
                context.read<DesignRequestCubit>().getAllDesignRequests();
              },
            );
          } else if (state is GetDesignRequestLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
