import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bottom_navigation_screens/main_screen.dart';

class ReviewSuccessScreen extends StatefulWidget {
  const ReviewSuccessScreen({super.key});

  @override
  State<ReviewSuccessScreen> createState() => _ReviewSuccessScreenState();
}

class _ReviewSuccessScreenState extends State<ReviewSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VendorMainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20.sp),
                child:Image.asset("assets/images/reviews_pop.png",fit: BoxFit.contain,width: MediaQuery.of(context).size.width*.5,color: AppColors.primaryColor,),
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40.w),
            child: Text("review_thanks".tr(),textAlign: TextAlign.center,style:  TextStyle(
                fontSize: MediaQuery.of(context).size.height*.02,
                fontWeight: FontWeight.w500,
                color: const Color(0xcc323232),
                fontFamily: 'Poppins'
            ),),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
