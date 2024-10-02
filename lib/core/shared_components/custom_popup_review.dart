import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/cubits/main/main_cubit.dart';
import 'package:echo/cubits/main/main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../views/vendor/views/screens/review_success.dart';
import '../colors/app_colors.dart';
import '../text_styles/app_text_style.dart';
import 'default_text_form_field.dart';

Future customPopUpReview({
  required BuildContext context,
  required TextEditingController message,
  required GlobalKey<FormState> formKey,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: BlocConsumer<MainCubit, MainState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                "send_opinion".tr(),
                                style: AppTextStyle.title()
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "message".tr(),
                              style: AppTextStyle.bodyText().copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            DefaultTextFormField(
                              textInputType: TextInputType.text,
                              controller: message,
                              maxLines: 3,
                              validationMsg: "field_req".tr(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      DefaultButton(
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<MainCubit>()
                                  .sendMyReview(message: message.text);
                            }
                          },
                          text: "sent_btn".tr())
                    ],
                  ),
                );
              },
              listener: (BuildContext context, MainState state)  {
                if (state is SendReviewSuccessState) {
                  message.clear();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReviewSuccessScreen()));// Prints after 1 second.


                } else if (state is SendReviewErrorState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ));
                }
                else if (state is SendReviewLoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => WillPopScope(
                      onWillPop: () {
                        return Future.value(false);
                      },
                      child: AlertDialog(
                        insetPadding: const EdgeInsets.all(0),
                        contentPadding: EdgeInsets.zero,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        content: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SpinKitCubeGrid(
                                  color: AppColors.primaryColor,
                                  size: 40.0,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "جاري ارسال الطلب".tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            )),
      ),
    );
