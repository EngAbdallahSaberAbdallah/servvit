import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/custom_pop_up.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/utils/functions.dart';
import 'package:echo/cubits/add_to_cart_customize/add_to_cart_customize_cubit.dart';
import 'package:echo/cubits/add_to_cart_customize/add_to_cart_customize_states.dart';
import 'package:echo/cubits/cancel_request/cancel_request_cubit.dart';
import 'package:echo/cubits/cancel_request/cancel_request_states.dart';
import 'package:echo/cubits/customize_request/customize_request_cubit.dart';
import 'package:echo/cubits/customize_request/customize_request_states.dart';
import 'package:echo/cubits/reject_customize_request/reject_customize_request_cubit.dart';
import 'package:echo/cubits/reject_customize_request/reject_customize_request_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/shared_components/default_button.dart';
import '../../../../../core/shared_components/default_cached_network_image.dart';
import '../../../../../core/shared_components/show_product_design.dart';
import '../../../../../core/text_styles/app_text_style.dart';
import '../../../../../core/utils/constants.dart';
import '../custom_product.dart';

class CustomizeTabView extends StatefulWidget {
  const CustomizeTabView({super.key});

  @override
  State<CustomizeTabView> createState() => _CustomizeTabViewState();
}

class _CustomizeTabViewState extends State<CustomizeTabView> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      child: BlocBuilder<CustomizeRequestCubit, CustomizeRequestState>(
        builder: (context, state) {
          if (state is GetCustomizeRequestSuccessState) {
            return state.model.all!.isEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<CustomizeRequestCubit>()
                          .getAllCustomizeRequests();
                    },
                    child: ListView(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (CacheKeysManger.getUserTokenFromCache() == "") {
                              file = null;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomProductScreen()));
                            }
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
                                      "add_customize".tr(),
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
                                    width:
                                        MediaQuery.of(context).size.width * .4,
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
                          if (CacheKeysManger.getUserTokenFromCache() == "") {
                            file = null;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomProductScreen()));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(.2),
                                borderRadius: BorderRadius.circular(30.sp),
                                border:
                                    Border.all(color: AppColors.primaryColor)),
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
                                    "add_customize".tr(),
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
                                .read<CustomizeRequestCubit>()
                                .getAllCustomizeRequests();
                          },
                          child: ListView.separated(
                            itemCount: state.model.all!.length,
                            itemBuilder: (context, index) {
                              return Container(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //       Row(
                                          //       children: [
                                          //       Expanded(
                                          //       child: Row(
                                          //         mainAxisAlignment:
                                          //         MainAxisAlignment.center,
                                          //         children: [
                                          //           Column(
                                          //             children: [
                                          //               Container(
                                          //                 decoration:
                                          //                 BoxDecoration(
                                          //                     borderRadius:
                                          //                     BorderRadius
                                          //                         .circular(40
                                          //                         .sp),
                                          //                     border:
                                          //                     Border.all(
                                          //                       color: AppColors
                                          //                           .primaryColor,
                                          //                     )),
                                          //                 child: Padding(
                                          //                   padding: EdgeInsets
                                          //                       .symmetric(
                                          //                       horizontal:
                                          //                       20.sp,
                                          //                       vertical:
                                          //                       3.sp),
                                          //                   child: Text(
                                          //                     state
                                          //                         .model
                                          //                         .all![index]
                                          //                         .quantity! +
                                          //                         "unit".tr(),
                                          //                     style: AppTextStyle
                                          //                         .title()
                                          //                         .copyWith(
                                          //                         fontSize:
                                          //                         14.sp),
                                          //                   ),
                                          //                 ),
                                          //               )
                                          //             ],
                                          //           )
                                          //         ],
                                          //       ),
                                          //     ),
                                          //     state.model.all![index]
                                          //         .sentStatus ==
                                          //         "yes"
                                          //         ? SizedBox(
                                          //       width: 10,
                                          //     )
                                          //         : SizedBox(),
                                          //     state.model.all![index]
                                          //         .sentStatus ==
                                          //         "yes"
                                          //         ? Expanded(
                                          //       child: Row(
                                          //         mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .center,
                                          //         children: [
                                          //           Column(
                                          //             children: [
                                          //               Container(
                                          //                 decoration:
                                          //                 BoxDecoration(
                                          //                     borderRadius:
                                          //                     BorderRadius.circular(40
                                          //                         .sp),
                                          //                     border:
                                          //                     Border
                                          //                         .all(
                                          //                       color: AppColors
                                          //                           .primaryColor,
                                          //                     )),
                                          //                 child: Padding(
                                          //                   padding: EdgeInsets
                                          //                       .symmetric(
                                          //                       horizontal: 20
                                          //                           .sp,
                                          //                       vertical:
                                          //                       3.sp),
                                          //                   child: Text(
                                          //                     state
                                          //                         .model
                                          //                         .all![
                                          //                     index]
                                          //                         .totalPrice! + " " +
                                          //                         "pound".tr(),
                                          //                     style: AppTextStyle
                                          //                         .title()
                                          //                         .copyWith(
                                          //                         fontSize:
                                          //                         14.sp),
                                          //                   ),
                                          //                 ),
                                          //               )
                                          //             ],
                                          //           )
                                          //         ],
                                          //       ),
                                          //     )
                                          //         : SizedBox(),
                                          //   ],
                                          // ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (state.model.all![index]
                                                                .description !=
                                                            null &&
                                                        state.model.all![index]
                                                                .description !=
                                                            "null")
                                                      Text(
                                                        "${"description".tr()} : ${state.model.all![index].description}",
                                                        style: AppTextStyle
                                                            .subTitle(),
                                                      ),
                                                    if (state.model.all![index]
                                                            .dimension !=
                                                        null)
                                                      Text(
                                                        "${"dimension".tr()} : ${state.model.all![index].dimension}",
                                                        style: AppTextStyle
                                                            .subTitle(),
                                                      ),
                                                    if (state.model.all![index]
                                                                .shape !=
                                                            null &&
                                                        state.model.all![index]
                                                                .shape !=
                                                            "null")
                                                      Text(
                                                        "${"shape".tr()} : ${state.model.all![index].shape ?? ""}",
                                                        style: AppTextStyle
                                                            .subTitle(),
                                                      ),
                                                    if (state.model.all![index]
                                                            .size !=
                                                        null)
                                                      Text(
                                                        "${"material".tr()} : ${state.model.all![index].size ?? ""}",
                                                        style: AppTextStyle
                                                            .subTitle(),
                                                      ),
                                                    SizedBox(height: 10.h),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.sp),
                                                          border: Border.all(
                                                            color: AppColors
                                                                .primaryColor,
                                                          )),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    20.sp,
                                                                vertical: 3.sp),
                                                        child: Text(
                                                          state
                                                                  .model
                                                                  .all![index]
                                                                  .quantity! +
                                                              "piece".tr(),
                                                          style: AppTextStyle
                                                                  .title()
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              if (state.model.all![index].image!
                                                  .isNotEmpty)
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  child: DefaultCachedNetworkImage(
                                                      imageUrl: state
                                                              .model
                                                              .all![index]
                                                              .image!
                                                              .isNotEmpty
                                                          ? EndPoints
                                                                  .customized +
                                                              state
                                                                  .model
                                                                  .all![index]
                                                                  .image!
                                                                  .first
                                                          : " ",
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
                                          state.model.all![index].sentStatus ==
                                                  "no"
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                        state.model.all![index]
                                                                    .sentStatus ==
                                                                "yes"
                                                            ? SizedBox(
                                                                width: 10,
                                                              )
                                                            : SizedBox(),
                                                        state.model.all![index]
                                                                    .sentStatus ==
                                                                "yes"
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(40
                                                                                .sp),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                        )),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          20.sp,
                                                                      vertical:
                                                                          3.sp),
                                                                  child: Text(
                                                                    state
                                                                            .model
                                                                            .all![
                                                                                index]
                                                                            .totalPrice! +
                                                                        " " +
                                                                        "pound"
                                                                            .tr(),
                                                                    style: AppTextStyle
                                                                            .title()
                                                                        .copyWith(
                                                                            fontSize:
                                                                                14.sp),
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.sp),
                                                          border: Border.all(
                                                            color: AppColors
                                                                .primaryColor,
                                                          )),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    20.sp,
                                                                vertical: 3.sp),
                                                        child: Text(
                                                          state
                                                                  .model
                                                                  .all![index]
                                                                  .totalPrice! +
                                                              " " +
                                                              "pound".tr(),
                                                          style: AppTextStyle
                                                                  .title()
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h,),
                                                    Row(
                                                      children: [
                                                        BlocConsumer<
                                                            AddToCartCustomizeRequestCubit,
                                                            AddToCartCustomizeRequestState>(
                                                          builder:
                                                              (context, state) {
                                                            return BlocBuilder<
                                                                CustomizeRequestCubit,
                                                                CustomizeRequestState>(
                                                              builder: (context,
                                                                  state) {
                                                                if (state
                                                                    is GetCustomizeRequestSuccessState) {
                                                                  return Flexible(
                                                                    child:
                                                                        DefaultButton(
                                                                      onPress:
                                                                          () {
                                                                        context
                                                                            .read<AddToCartCustomizeRequestCubit>()
                                                                            .AddToCartCustomizeRequests(productId: state.model.all![index].id.toString());
                                                                      },
                                                                      text: "add_to_card"
                                                                          .tr(),
                                                                      fontSize:
                                                                          12.sp,
                                                                      borderRadius:
                                                                          20.sp,
                                                                      height:
                                                                          4.h,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return SizedBox();
                                                                }
                                                              },
                                                            );
                                                          },
                                                          listener:
                                                              (BuildContext
                                                                      context,
                                                                  state) {
                                                            if (state
                                                                is GetAddToCartCustomizeRequestSuccessState) {
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
                                                              //   icon: "assets/images/success.png",
                                                              //   mainTitle: "add_to_cart_message".tr(),
                                                              //   network: false,
                                                              // );
                                                              Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                                  () {
                                                                context
                                                                    .read<
                                                                        CustomizeRequestCubit>()
                                                                    .getAllCustomizeRequests();
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            } else if (state
                                                                is GetAddToCartCustomizeRequestErrorState) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
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
                                                                          .title()
                                                                      .copyWith(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color:
                                                                              Colors.white),
                                                                ),
                                                                backgroundColor:
                                                                    Colors.red,
                                                              ));
                                                              Navigator.pop(
                                                                  context);
                                                            } else if (state
                                                                is GetAddToCartCustomizeRequestLoadingState) {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false,
                                                                builder:
                                                                    (context) =>
                                                                        WillPopScope(
                                                                  onWillPop:
                                                                      () {
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
                                                                            BorderRadius.circular(10)),
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
                                                                              color: AppColors.primaryColor,
                                                                              size: 40.0,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              "جاري ارسال الطلب".tr(),
                                                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                                            RejectCustomizeRequestCubit,
                                                            RejectCustomizeRequestState>(
                                                          builder:
                                                              (context, state) {
                                                            return BlocBuilder<
                                                                CustomizeRequestCubit,
                                                                CustomizeRequestState>(
                                                              builder: (context,
                                                                  state) {
                                                                if (state
                                                                    is GetCustomizeRequestSuccessState) {
                                                                  return Flexible(
                                                                    child:
                                                                        DefaultButton(
                                                                      onPress:
                                                                          () {
                                                                        context
                                                                            .read<RejectCustomizeRequestCubit>()
                                                                            .RejectCustomizeRequests(productId: state.model.all![index].id.toString());
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
                                                                      height:
                                                                          4.h,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return SizedBox();
                                                                }
                                                              },
                                                            );
                                                          },
                                                          listener:
                                                              (BuildContext
                                                                      context,
                                                                  state) {
                                                            if (state
                                                                is RejectCustomizeRequestSuccessState) {
                                                              Navigator.pop(
                                                                  context);
                                                              customPopUpDialog(
                                                                context:
                                                                    context,
                                                                icon:
                                                                    "assets/images/cancel.png",
                                                                mainTitle:
                                                                    "request_removed"
                                                                        .tr(),
                                                                network: false,
                                                              );
                                                              Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                                  () {
                                                                context
                                                                    .read<
                                                                        CustomizeRequestCubit>()
                                                                    .getAllCustomizeRequests();
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            } else if (state
                                                                is RejectCustomizeRequestErrorState) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
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
                                                                          .title()
                                                                      .copyWith(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color:
                                                                              Colors.white),
                                                                ),
                                                                backgroundColor:
                                                                    Colors.red,
                                                              ));
                                                              Navigator.pop(
                                                                  context);
                                                            } else if (state
                                                                is RejectCustomizeRequestLoadingState) {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false,
                                                                builder:
                                                                    (context) =>
                                                                        WillPopScope(
                                                                  onWillPop:
                                                                      () {
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
                                                                            BorderRadius.circular(10)),
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
                                                                              color: AppColors.primaryColor,
                                                                              size: 40.0,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Text(
                                                                              "جاري ارسال الطلب".tr(),
                                                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                                                                .customized +
                                                            state
                                                                .model
                                                                .all![index]
                                                                .image!
                                                                .first!,
                                                        button: DefaultButton(
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            text:
                                                                "close".tr()));
                                                  },
                                                  text: "with_design".tr(),
                                                  fontSize: 12.sp,
                                                  borderRadius: 20.sp,
                                                  height: 4.h,
                                                ),
                                              ),
                                              state.model.all![index]
                                                          .sentStatus ==
                                                      "no"
                                                  ? SizedBox(width: 10.w)
                                                  : SizedBox(),
                                              state.model.all![index]
                                                          .sentStatus ==
                                                      "no"
                                                  ? BlocConsumer<
                                                      CancelRequestCubit,
                                                      CancelRequestState>(
                                                      builder:
                                                          (context, state) {
                                                        return BlocBuilder<
                                                            CustomizeRequestCubit,
                                                            CustomizeRequestState>(
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is GetCustomizeRequestSuccessState) {
                                                              return Flexible(
                                                                  child:
                                                                      DefaultButton(
                                                                onPress: () {
                                                                  context.read<CancelRequestCubit>().CancelRequests(
                                                                      productId: state
                                                                          .model
                                                                          .all![
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                                },
                                                                text:
                                                                    "delete_request"
                                                                        .tr(),
                                                                icon: Icon(
                                                                  Icons
                                                                      .delete_outline,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                fontSize: 12.sp,
                                                                borderRadius:
                                                                    20.sp,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                height: 4.h,
                                                              ));
                                                            } else {
                                                              return SizedBox();
                                                            }
                                                          },
                                                        );
                                                      },
                                                      listener:
                                                          (BuildContext context,
                                                              CancelRequestState
                                                                  state) {
                                                        if (state
                                                            is CancelRequestSuccessState) {
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
                                                                    CustomizeRequestCubit>()
                                                                .getAllCustomizeRequests();
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        } else if (state
                                                            is CancelRequestErrorState) {
                                                          ScaffoldMessenger.of(
                                                                  context)
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
                                                                      .title()
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ));
                                                          Navigator.pop(
                                                              context);
                                                        } else if (state
                                                            is CancelRequestLoadingState) {
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
                                                                        .all(0),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                clipBehavior: Clip
                                                                    .antiAliasWithSaveLayer,
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
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
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
                                                                          "جاري ارسال الطلب"
                                                                              .tr(),
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 14),
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
                                                    )
                                                  : SizedBox(),
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
          } else if (state is GetCustomizeRequestErrorState) {
            return CustomErrorWidget(
              onTap: () {
                context.read<CustomizeRequestCubit>().getAllCustomizeRequests();
              },
            );
          } else if (state is GetCustomizeRequestLoadingState) {
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
