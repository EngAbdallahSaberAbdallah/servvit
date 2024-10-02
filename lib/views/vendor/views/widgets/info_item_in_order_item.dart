import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class InfoItemInOrderItem extends StatelessWidget {
  const InfoItemInOrderItem({
    super.key,
    this.dataIsDate = false,
    required this.title,
    required this.content,
  });
  final dataIsDate;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    // 1: knowing the pattern of date i get from api because it must provide pattern to parse the date you get from api
    // 2: parse it to DateTime to get the DateTime Object
    // 3: format this DateTime Object to the format i want as 'MMM yyyy EEEE, hh:mm a'
    var inputFormatDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'");

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.black.withOpacity(0.3),
          ),
          child: dataIsDate
              ? Text(
                  "${DateFormat('MMM yyyy EEEE, hh:mm a').format(inputFormatDate.parse(content))}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                )
              : Text(
                  content,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                ),
        ),
        Positioned(
          top: -5.h,
          left: 5.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Colors.white,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 10.sp,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
