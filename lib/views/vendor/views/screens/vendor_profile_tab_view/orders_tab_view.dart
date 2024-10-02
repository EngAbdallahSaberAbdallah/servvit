import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:echo/views/vendor/views/screens/vendor_profile_tab_view/orders_item.dart';
import 'package:echo/views/vendor/views/screens/vendor_profile_tab_view/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../cubits/vendor_profile/vendor_profile_cubit.dart';


class OrdersTabView extends StatefulWidget {
  const OrdersTabView({Key? key}) : super(key: key);

  @override
  State<OrdersTabView> createState() => _OrdersTabViewState();
}

class _OrdersTabViewState extends State<OrdersTabView> {
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    VendorProfileCubit.get(context).getAllOrders();
  }

  int acceptedIndex = -1;
  int pendingIndex = -1;
  int rejectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorProfileCubit, VendorProfileState>(
      buildWhen: (previous, current) {
        //todo build when not full screen
        if (current is VendorProfileFullScreen ||
            current is VendorProfileNotFullScreen) {
          log(current.toString());
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is VendorProfileAllOrdersSuccess) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            controller: VendorProfileCubit.get(context)
                .scrollControllerHandler
                .scrollController,
            children: [
              SizedBox(height: 10.h),
              _buildAcceptedOrders(),
              SizedBox(height: 10.h),
              _buildPendingOrders(),
              // SizedBox(height: 10.h),
              // _buildRejectedOrders(),
            ],
          );

          // return Column(
          //   children: [
          //     //* try: customscrollview
          //     SizedBox(height: 10.h),
          //     _buildAcceptedOrders(),
          //     SizedBox(height: 10.h),
          //     _buildPendingOrders(),
          //     SizedBox(height: 10.h),
          //     _buildRejectedOrders(),
          //   ],
          // );
        } else if (state is VendorProfileAllOrdersLoading) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: ShimmerLoadingWidget());
        } else {
          return CustomErrorWidget(
            onTap: () {
              VendorProfileCubit.get(context).getAllOrders();
            },
          );
        }
      },
    );
  }

  Widget _buildAcceptedOrders() {
    bool isDropedDown = true;
    var orders = VendorProfileCubit.get(context).allAcceptedOrders;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isDropedDown = !isDropedDown;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.green,
                ),
                child: Row(
                  children: [
                    Text(
                      'accepted_orders'.tr(),
                      style: AppTextStyle.title().copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    isDropedDown
                        ? Icon(
                            Icons.arrow_drop_up,
                            color: AppColors.primaryColor,
                          )
                        : Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.h),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              child: !isDropedDown
                  ? SizedBox()
                  : SizedBox(
                      // height: orders.length * 75.h,
                      child: orders.isEmpty
                          ? Center(
                              child: Text(
                                'no_orders_founded'.tr(),
                                style: AppTextStyle.title()
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          : ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => OrdersItem(
                                onTap: () {
                                  if (acceptedIndex != index) {
                                    setState(() {
                                      acceptedIndex = index;
                                    });
                                  } else {
                                    setState(() {
                                      acceptedIndex = -1;
                                    });
                                  }
                                },
                                index: index,
                                currentIndex: acceptedIndex,
                                orders: orders[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemCount: orders.length,
                            ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPendingOrders() {
    bool isDropedDown = false;
    var orders = VendorProfileCubit.get(context).allpendingOrders;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isDropedDown = !isDropedDown;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.yellowAccent[700],
                ),
                child: Row(
                  children: [
                    Text(
                      'pending_orders'.tr(),
                      style: AppTextStyle.title().copyWith(color: Colors.white),
                    ),
                    Spacer(),
                    isDropedDown
                        ? Icon(
                            Icons.arrow_drop_up,
                            color: AppColors.primaryColor,
                          )
                        : Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.h),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              child: !isDropedDown
                  ? SizedBox()
                  : SizedBox(
                      // height: orders.length * 70.h,
                      child: orders.isEmpty
                          ? Center(
                              child: Text(
                                'no_orders_founded'.tr(),
                                style: AppTextStyle.title()
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          : ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => OrdersItem(
                                onTap: () {
                                  if (pendingIndex != index) {
                                    setState(() {
                                      pendingIndex = index;
                                    });
                                  } else {
                                    setState(() {
                                      pendingIndex = -1;
                                    });
                                  }
                                },
                                index: index,
                                currentIndex: pendingIndex,
                                orders: orders[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemCount: orders.length,
                            ),
                    ),
            ),
          ],
        );
      },
    );
  }

  // Widget _buildRejectedOrders() {
  //   bool isDropedDown = false;
  //   var orders = VendorProfileCubit.get(context).allRejectedOrders;
  //   return StatefulBuilder(
  //     builder: (context, setState) {
  //       return Column(
  //         children: [
  //           InkWell(
  //             onTap: () {
  //               setState(() {
  //                 isDropedDown = !isDropedDown;
  //               });
  //             },
  //             child: Container(
  //               padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
  //               margin: EdgeInsets.symmetric(horizontal: 10.w),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10.r),
  //                 color: Colors.red,
  //               ),
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     'rejected_orders'.tr(),
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   Spacer(),
  //                   isDropedDown
  //                       ? Icon(
  //                           Icons.arrow_drop_up,
  //                           color: AppColors.primaryColor,
  //                         )
  //                       : Icon(
  //                           Icons.arrow_drop_down,
  //                           color: Colors.white,
  //                         ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 5.h),
  //           AnimatedSize(
  //             duration: Duration(milliseconds: 300),
  //             child: !isDropedDown
  //                 ? SizedBox()
  //                 : SizedBox(
  //                     // height: orders.length * 70.h,
  //                     child: orders.isEmpty
  //                         ? Center(
  //                             child: Text('no_orders_founded'.tr()),
  //                           )
  //                         : ListView.separated(
  //                             physics: NeverScrollableScrollPhysics(),
  //                             shrinkWrap: true,
  //                             itemBuilder: (context, index) => OrdersItem(
  //                               onTap: () {
  //                                 if (rejectedIndex != index) {
  //                                   setState(() {
  //                                     rejectedIndex = index;
  //                                   });
  //                                 } else {
  //                                   setState(() {
  //                                     rejectedIndex = -1;
  //                                   });
  //                                 }
  //                               },
  //                               index: index,
  //                               currentIndex: rejectedIndex,
  //                               orders: orders[index],
  //                             ),
  //                             separatorBuilder: (context, index) => SizedBox(height: 10.h),
  //                             itemCount: orders.length,
  //                           ),
  //                   ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
