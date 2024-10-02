import 'package:cached_network_image/cached_network_image.dart';
import 'package:echo/core/shared_components/default_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/app_colors.dart';


Future showProductDesign({
  required BuildContext context,
  required String image,
  required Widget? button,
}) =>
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
        onWillPop: ()async=>false,
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          content:  SizedBox(
            width: MediaQuery.of(context).size.width*.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height*.35,
                    decoration: const BoxDecoration(
                        color: Color(0xffF2F2F2)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.sp),
                      child:  Center(
                        child:DefaultCachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:image ,
                          imageHeight: MediaQuery.of(context).size.height * .3,
                          imageWidth: double.infinity,
                        ),
                        ),
                    )),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: button,
                ),
                SizedBox(height: 20.h,),
              ],
            ),
          ),

        ),
      );
      },);