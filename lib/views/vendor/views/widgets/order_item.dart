import 'package:echo/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/number_format.dart';
import 'info_item_in_order_item.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.onDetailsTap,
    required this.orderId,
    required this.coast,
  });
  final void Function()? onDetailsTap;
  final int orderId;
  final String coast;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          clipBehavior: Clip.none,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
            side: BorderSide(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                //     SizedBox(height: 8.h),
                //     InfoItemInOrderItem(
                //       title: 'name',
                //       content: 'mohamed',
                //     ),
                //     SizedBox(height: 10.h),
                //     InfoItemInOrderItem(
                //         title: 'email', content: 'mohamed@gmail.com'),
                //     SizedBox(height: 10.h),
                //     InfoItemInOrderItem(
                //       title: 'phone',
                //       content: '01285453423',
                //     ),
                //   ],
                // ),
                // SizedBox(width: 10.w),
                Column(
                  children: [
                    SizedBox(height: 8.h),
                    InfoItemInOrderItem(
                      title: 'total cost',
                      content:
                          "${getNumberFormat('30024', convertAfter: 5)} EGY",
                    ),
                    //     SizedBox(height: 10.h),
                    //     InfoItemInOrderItem(
                    //         title: 'reminder cost',
                    //         content:
                    //             '${getNumberFormat('22374', convertAfter: 5)} EGY'),
                    //     SizedBox(height: 10.h),
                    //     InfoItemInOrderItem(
                    //         title: 'updated date',
                    //         dataIsDate: true,
                    //         content: '2023-10-05T13:41:15.000000Z'),
                    //     SizedBox(height: 20.h),
                  ],
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 3.h,
          end: 3.w,
          child: InkWell(
            onTap: onDetailsTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.r),
                  topLeft: Radius.circular(10.r),
                ),
                color: AppColors.primaryColor,
              ),
              child: Text(
                'Details',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: -5.h,
          start: 25.w,
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: Text(
              'Order id: $orderId',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.primaryColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
