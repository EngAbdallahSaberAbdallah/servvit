import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/core/utils/payment_constants.dart';
import 'package:echo/cubits/bottom_navbar/bottom_navbar_cubit.dart';
import 'package:echo/cubits/payment_method_cubit/payment_method_cubit.dart';
import 'package:echo/views/vendor/views/screens/bottom_navigation_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../core/services/remote/dio/end_points.dart';
import '../../../../../model/request_add_order/add_order_request_model.dart';

class CardPaymentScreen extends StatefulWidget {
  const CardPaymentScreen({
    super.key,
    required this.paymentStatus,
    required this.authToken,
  });
  final PaymentStatus? paymentStatus;
  final String authToken;

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            PaymentMethodCubit.get(context).setProgressBarValue(progress);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            log('$url');
          },
          onNavigationRequest: (NavigationRequest request) {

            if (request.url.startsWith(EndPoints.baseUrl)) {
              if(request.url.startsWith("success=true")){
                toast(text: "success_pay".tr(), color: Colors.green);

                BottomNavbarCubit.get(context).currentIndex=0;
                NavigationUtils.navigateReplacement(context: context, destinationScreen: VendorMainScreen());
              }else{
                toast(text: "error_pay".tr(), color: Colors.red);
                BottomNavbarCubit.get(context).currentIndex=0;
                NavigationUtils.navigateReplacement(context: context, destinationScreen: VendorMainScreen());
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.toString());
          },
        ),
      )
      ..loadRequest(Uri.parse(PaymentConstants.iFrame(widget.authToken)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
        listener: (context, state) {
          if (state is PaymentCardSuccess) {
            log('--------------------------------====================\n${state.toString()}');
            if (state.success) {
              toast(text: 'order_sccuess'.tr(), color: Colors.green)
                  .whenComplete(() {
                PaymentMethodCubit.get(context).pay();
              });
            } else {
              //todo dsiplay a problem error when success false;
              toast(text: 'payment_error'.tr(), color: Colors.red)
                  .whenComplete(() {
                Navigator.pop(context);
              });
            }
          }
        },
        builder: (context, state) {
          if (state is PaymentProgressValue) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                    value: state.progress / 100,
                    valueColor: AlwaysStoppedAnimation(Colors.amber),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    'payment_loading'.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            );
          }
          return WebViewWidget(
            layoutDirection: CacheKeysManger.getLanguageFromCache() == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            controller: controller,
          );
        },
      ),
    );
  }
}
