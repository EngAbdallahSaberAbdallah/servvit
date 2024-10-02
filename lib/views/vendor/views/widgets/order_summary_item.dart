import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSummaryItem extends StatelessWidget {
  const OrderSummaryItem({
    super.key,
    required this.controller,
    required this.subTotal,
    this.shipping,
  });
  final TextEditingController controller;
  final String subTotal;
  final String? shipping;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Text('Order Summary',
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Text('subtotal:'),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text('$subTotal EGY'),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Text('shiping:'),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text('$shipping EGY'),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Text('add coupon code:'),
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 120.w,
                        height: 25.h,
                        child: Expanded(
                          child: TextFormField(
                            controller: controller,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Coupon Code',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 0.h,
                              ),
                              hintStyle: Theme.of(context).textTheme.bodySmall,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(Assets.imagesVendorImageProfile,
            //         height: 50, width: 50),
            //     SizedBox(height: 5.h),
            //     Text(
            //       'AM374',
            //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //             fontSize: 12.sp,
            //           ),
            //     ),
            //     SizedBox(height: 5.h),
            //     Image.asset(Assets.imagesTeaMug, height: 50, width: 50),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
