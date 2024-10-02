import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String? header;
  final TextStyle? headerStyle;
  final double maxHeight;
  final double minHeight;
  final Widget? child;
  const SliverHeaderDelegate({
    this.header,
    this.headerStyle,
    required this.maxHeight,
    required this.minHeight,
    this.child,
  }) : assert(header != null || child != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child ??
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey[300],
                  thickness: 1.h,
                  height: 10.h,
                  endIndent: 10.w,
                  indent: 15.w,
                ),
              ),
              Text(
                header!,
                style: headerStyle,
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey[300],
                  thickness: 1.h,
                  height: 10.h,
                  endIndent: 10.w,
                  indent: 15.w,
                ),
              ),
            ],
          ),
    );
  }

//! size of header when it displayed when no scrolling
  @override
  double get maxExtent => maxHeight;

//! size of header when it displayed on top
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
