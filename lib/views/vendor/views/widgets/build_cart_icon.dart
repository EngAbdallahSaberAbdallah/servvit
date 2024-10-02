import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/vendor_add_to_cart/vendor_add_to_cart_cubit.dart';
import 'package:echo/views/vendor/views/screens/vendor_cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildCartIcon extends StatelessWidget {
  const BuildCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorAddToCartCubit, VendorAddToCartState>(
      buildWhen: (previous, current) {
        if (current is CartCountSuccessState ||
            current is CartCountLoadingState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Container(
          width: 50.w,
          height: 50.h,
          alignment: Alignment.center,
          // margin: EdgeInsets.symmetric(horizontal: 15.w),
          clipBehavior: Clip.none,
          child: Badge(
            backgroundColor: AppColors.bageBackground,
            isLabelVisible: true,
            largeSize: 20,
            label: state is CartCountSuccessState
                ? Text(state.count > 999 ? '999+' : "${state.count}")
                : SizedBox.square(
                    dimension: 10.r,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
            child: GestureDetector(
              onTap: () {
                NavigationUtils.navigateTo(
                  context: context,
                  destinationScreen: VendorCartScreen(),
                );
              },
              child: Container(
                height: 35.h,
                width: 35.w,
                padding: EdgeInsets.all(4.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(87, 116, 86, 1),
                ),
                child: Icon(
                  CupertinoIcons.cart_fill_badge_plus,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );

        // return Container(
        //   width: 50.w,
        //   height: 50.h,
        //   alignment: Alignment.center,
        //   margin: EdgeInsets.symmetric(horizontal: 15.w),
        //   clipBehavior: Clip.none,
        //   child: Badge.count(
        //     alignment: Alignment.topRight,
        //     count: state is CartCountSuccessState
        //         ? state.count
        //         : 0,
        //     isLabelVisible: true,
        //     largeSize: 20,
        //     child: GestureDetector(
        //       onTap: () {
        //         NavigationUtils.navigateTo(
        //           context: context,
        //           destinationScreen: VendorCartScreen(),
        //         );
        //       },
        //       child: Container(
        //         height: 35.h,
        //         width: 35.w,
        //         padding: EdgeInsets.all(4.w),
        //         alignment: Alignment.center,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Color.fromRGBO(87, 116, 86, 1),
        //         ),
        //         child: Icon(
        //           CupertinoIcons.cart_fill_badge_plus,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }
}
