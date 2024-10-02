import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/shared_components/show_product_design.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/model/order_model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:echo/core/utils/functions.dart';

class OrdersItem extends StatelessWidget {
  const OrdersItem(
      {Key? key,
      required this.orders,
      required this.onTap,
      required this.currentIndex,
      required this.index})
      : super(key: key);
  final Orders orders;
  final int currentIndex;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: AppColors.primaryColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${"order_num".tr()} : ${orders.id} ${"delivery_to".tr()} ${orders.governorate!.name}\n ${DateFormat.yMMMEd(CacheKeysManger.getLanguageFromCache()).format(DateTime.parse(orders.createdAt.toString()))}",
                      style: AppTextStyle.title()
                          .copyWith(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  Icon(
                    currentIndex == index
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ],
              ),
            ),
          ),
          if (currentIndex == index)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (orders.orderItems!.isNotEmpty)
                        ...List.generate(
                            orders.orderItems!.length,
                            (i) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            child: DefaultCachedNetworkImage(
                                              imageHeight: 110.sp,
                                              imageWidth: 90.sp,
                                              imageUrl: orders.orderItems![i]
                                                          .design ==
                                                      "with"
                                                  ? EndPoints.products +
                                                      orders
                                                          .orderItems![i]
                                                          .supplierProductSize!
                                                          .supplierProduct!
                                                          .products!
                                                          .image!
                                                          .first
                                                  : orders.orderItems![i]
                                                              .design ==
                                                          null
                                                      ? EndPoints.customized +
                                                          orders.orderItems![i]
                                                              .customizeImage
                                                              .toString()
                                                      : EndPoints.products +
                                                          orders
                                                              .orderItems![i]
                                                              .supplierProductSize!
                                                              .supplierProduct!
                                                              .products!
                                                              .image!
                                                              .first,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              if (orders.orderItems![i].type ==
                                                  "customize")
                                                Text(
                                                  "custom_product".tr(),
                                                  style: AppTextStyle.headLine()
                                                      .copyWith(fontSize: 17),
                                                ),
                                           
                                             
                                              if (orders
                                                          .orderItems![i]
                                                          .supplierProductSize != null ) if(orders
                                                          .orderItems![i]
                                                          .supplierProductSize!
                                                          .supplierProduct!
                                                          .products!
                                                          .name! !=
                                                      "" &&
                                                  orders
                                                          .orderItems![i]
                                                          .supplierProductSize!
                                                          .supplierProduct!
                                                          .products!
                                                          .name! !=
                                                      null &&
                                                  orders
                                                          .orderItems![i]
                                                          .supplierProductSize!
                                                          .supplierProduct!
                                                          .products!
                                                          .name! !=
                                                      "null")
                                                Text(
                                                  orders
                                                      .orderItems![i]
                                                      .supplierProductSize!
                                                      .supplierProduct!
                                                      .products!
                                                      .name!,
                                                  style: AppTextStyle.title()
                                                      .copyWith(fontSize: 16),
                                                ),
                                              if (orders.orderItems![i]
                                                          .quantity !=
                                                      "" &&
                                                  orders.orderItems![i]
                                                          .quantity !=
                                                      "null")
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${"quantity".tr()} : ",
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${orders.orderItems![i].quantity} ${"piece".tr()}",
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (orders.orderItems![i]
                                                          .pieceCost !=
                                                      "" &&
                                                  orders.orderItems![i]
                                                          .pieceCost !=
                                                      "null")
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${"unit_price".tr()} : ",
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${Functions.getNumberFormatFunc(orders.orderItems![i].pieceCost)} ${"pound".tr()}",
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (orders.orderItems![i]
                                                          .totalCostWithoutShipping !=
                                                      "" &&
                                                  orders.orderItems![i]
                                                          .totalCostWithoutShipping !=
                                                      "null")
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${"total_price".tr()} : ",
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${Functions.getNumberFormatFunc(orders.orderItems![i].totalCostWithoutShipping)} ${"pound".tr()}",
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional.topEnd,
                                                child: GestureDetector(
                                                  onTap: orders.orderItems![i]
                                                                  .design ==
                                                              "with" ||
                                                          orders.orderItems![i]
                                                                  .design ==
                                                              null
                                                      ? () {
                                                          // showDialog(
                                                          //     context: context,
                                                          //     builder: (context) =>
                                                          //         Container(
                                                          //           decoration: BoxDecoration(
                                                          //               image: DecorationImage(
                                                          //                 image: NetworkImage(
                                                          //                   orders.orderItems![i]
                                                          //                       .customizeImage != null
                                                          //                       ? EndPoints.customized +
                                                          //                       orders.orderItems![i]
                                                          //                           .customizeImage
                                                          //                           .toString()
                                                          //                       : EndPoints.products +
                                                          //                       orders
                                                          //                           .orderItems![i]
                                                          //                           .supplierProductSize!
                                                          //                           .supplierProduct!
                                                          //                           .products!
                                                          //                           .image!
                                                          //                           .first,
                                                          //                 ),
                                                          //               )),
                                                          //         ));
                                                          showProductDesign(
                                                              context: context,
                                                              image: orders
                                                                          .orderItems![
                                                                              i]
                                                                          .design !=
                                                                      "with"
                                                                  ? EndPoints
                                                                          .customized +
                                                                      orders
                                                                          .orderItems![
                                                                              i]
                                                                          .customizeImage
                                                                          .toString()
                                                                  : EndPoints
                                                                          .public +
                                                                      orders
                                                                          .orderItems![
                                                                              i]
                                                                          .designImage,
                                                              button:
                                                                  DefaultButton(
                                                                      onPress:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      text: "close"
                                                                          .tr()));
                                                        }
                                                      : null,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.w,
                                                            vertical: 5.w),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.sp),
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    child: Text(
                                                      orders.orderItems![i]
                                                                      .design ==
                                                                  "with" ||
                                                              orders
                                                                      .orderItems![
                                                                          i]
                                                                      .design ==
                                                                  null
                                                          ? "design_image".tr()
                                                          : orders
                                                                      .orderItems![
                                                                          i]
                                                                      .design ==
                                                                  "without"
                                                              ? "without".tr()
                                                              : "with_donate"
                                                                  .tr(),
                                                      style:
                                                          AppTextStyle.title()
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                        ],
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                )),
                      Row(
                        children: [
                          Text(
                            "${"before_vat".tr()} : ",
                            style: AppTextStyle.title().copyWith(fontSize: 16),
                          ),
                          Text(
                            "${orders.totalWithoutVat} ${"pound".tr()}",
                            style: AppTextStyle.title().copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${"vat".tr()} : ",
                            style: AppTextStyle.title().copyWith(fontSize: 16),
                          ),
                          Text(
                            "${orders.vat} ${"pound".tr()}",
                            style: AppTextStyle.title().copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${"shipping_cost".tr()} : ",
                            style: AppTextStyle.title().copyWith(fontSize: 16),
                          ),
                          Text(
                            "${orders.shippingCost} ${"pound".tr()}",
                            style: AppTextStyle.title().copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${"after_vat_shipping".tr()} : ",
                            style: AppTextStyle.title().copyWith(fontSize: 16),
                          ),
                          Expanded(
                            child: Text(
                              "${orders.totalCost!} ${"pound".tr()}",
                              style: AppTextStyle.title().copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
