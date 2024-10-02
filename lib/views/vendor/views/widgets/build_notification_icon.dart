import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/cubits/vendor_profile/vendor_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildNotificationIcon extends StatelessWidget {
  final dynamic onTap;
  const BuildNotificationIcon({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorProfileCubit, VendorProfileState>(
      buildWhen: (previous, current) {
        if (current is VendorProfileNotificationSuccess ||
            current is VendorProfileNotificationLoading ||
            current is VendorProfileNotificationError) {
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
            isLabelVisible: true,
            largeSize: 20,
            label: state is VendorProfileNotificationSuccess
                ? Text(state.count > 999 ? '999+' : "${state.count}")
                : SizedBox.square(
                    dimension: 10.r,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
            child: GestureDetector(
              onTap:onTap,
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
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
