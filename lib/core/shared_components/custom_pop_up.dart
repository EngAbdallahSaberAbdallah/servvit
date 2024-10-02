import 'package:cached_network_image/cached_network_image.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../colors/app_colors.dart';

Future customPopUpDialog({
  required BuildContext context,
  Widget? button,
  bool network = true,
  required String? icon,
  required String? mainTitle,
}) =>
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * .25,
                    decoration: const BoxDecoration(color: Color(0xffF2F2F2)),
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: network
                          ? CachedNetworkImage(
                              imageUrl: icon!,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.secondaryColor,
                              )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Image.asset(
                              icon!,
                              fit: BoxFit.contain,
                            ),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(mainTitle!,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyText().copyWith(
                        color: const Color(0xcc323232),
                      )),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: button,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
