import 'package:echo/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBg extends StatelessWidget {
  const CustomBg({Key? key, required this.body}) : super(key: key);
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.greenLightColor,
              AppColors.secondaryColor,
              AppColors.primarySwatchColor.withOpacity(.3),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),//background_signup
            // image: AssetImage("assets/images/bg.jpeg"),
            fit: BoxFit.contain,
          )
          ),
      child: body,
    );
  }
}
