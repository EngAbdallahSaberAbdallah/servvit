import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../colors/app_colors.dart';

class CustomErrorWidget extends StatelessWidget {
  CustomErrorWidget({
    super.key,
    required this.onTap
  });
Function ()? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/server_error.svg",
              width: MediaQuery.of(context).size.width * .25,
            ),
            SizedBox(
              height:10.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "no_internet".tr(),
                  style: TextStyle(
                      color: const Color(0xffA5A5A5),
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.height * .014),
                ),
                SizedBox(width: 10.sp,),
                GestureDetector(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    "assets/images/reload.svg",
                    width: MediaQuery.of(context).size.width * .07,
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
