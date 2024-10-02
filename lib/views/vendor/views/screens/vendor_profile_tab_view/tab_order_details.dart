import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/utils/assets.dart';

class TabOrderDetails extends StatefulWidget {
  const TabOrderDetails({super.key});

  @override
  State<TabOrderDetails> createState() => _TabOrderDetailsState();
}

class _TabOrderDetailsState extends State<TabOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.h,
        title: Image.asset(
          Assets.imagesLogo2,
          width: 100.w,
          height: 40.h,
          fit: BoxFit.contain,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            Assets.imagesIconBackSquare,
            height: 20.h,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Center(
        child: Text('TabOrderDetails'),
      ),
    );
  }
}
