import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.name,
    required this.image,
    this.onTap,
    required this.name2,
  }) : super(key: key);
  final String name;
  final String name2;
  final String image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 209.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Color.fromRGBO(87, 116, 86, 1),
                width: 1.w,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: 140.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: DefaultCachedNetworkImage(
                                  fit: BoxFit.contain,
                                  imageUrl: EndPoints.products + image,
                                  imageHeight:
                                      MediaQuery.of(context).size.height * 0.2,
                                  imageWidth:
                                      MediaQuery.of(context).size.width * 0.3),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.all(8.sp),
                            //   child: GestureDetector(
                            //     onTap: favoriteOnTap,
                            //     child: CircleAvatar(
                            //       backgroundColor: Colors.white,
                            //       radius: 15.sp,
                            //       child: Icon(isFav?Icons.favorite:Icons.favorite_border,color: AppColors.primaryColor,),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(name,
                            maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bodyText().copyWith(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade,
                                color: Colors.black)),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          name2,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.bodyText().copyWith(
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                        if (onTap != null) SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          if (onTap != null)
            SizedBox(
              width: double.infinity,
              height: 27.h,
              child: ElevatedButton(
                onPressed: onTap,
                child: Text(
                  "details".tr(),
                  style: AppTextStyle.subTitle()
                      .copyWith(color: Colors.black, fontSize: 13.sp),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  backgroundColor: Color.fromRGBO(186, 210, 88, 1),
                  minimumSize: Size(85.w, 20.h),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
