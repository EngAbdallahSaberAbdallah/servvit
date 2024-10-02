import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared_components/default_cached_network_image.dart';
import '../../../../core/text_styles/app_text_style.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem(
      {super.key,
      required this.img,
      required this.description,
      required this.name});
  final String img;
  final String description;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Color(0xffffffff),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.sp),
                child: DefaultCachedNetworkImage(
                  imageUrl: EndPoints.clients + img,
                  imageHeight: 50.h,
                  imageWidth: 50.h,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "\"${description}\"",
                style: AppTextStyle.bodyText(),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                name,
                style: AppTextStyle.title().copyWith(fontSize: 14.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
