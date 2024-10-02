import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/cubits/main/main_cubit.dart';
import 'package:echo/cubits/main/main_state.dart';
import 'package:echo/views/vendor/views/screens/bottom_navigation_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/shared_components/custom_dropdown_formfield.dart';
import '../../../../core/shared_components/custom_pop_up.dart';
import '../../../../core/shared_components/default_text_form_field.dart';
import '../../../../core/text_styles/app_text_style.dart';
import '../../../../core/utils/navigation_utility.dart';
import '../../../../cubits/bottom_navbar/bottom_navbar_cubit.dart';

class ContactUs extends StatefulWidget {
  ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  int? selectedCountryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.h,
          title: Image.asset(
            "assets/images/logo2.png",
            width: 100.w,
            height: 40.h,
            fit: BoxFit.contain,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "contactUs".tr(),
                              style: AppTextStyle.headLine()
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "name".tr(),
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
                                  controller: nameController,
                                  validationMsg: "field_req".tr(),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "phone".tr(),
                                  style: AppTextStyle.bodyText().copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                DefaultTextFormField(
                                  textInputType: TextInputType.number,
                                  controller: phoneController,
                                  validationMsg: "field_req".tr(),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "email".tr(),
                                  style: AppTextStyle.bodyText().copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                DefaultTextFormField(
                                  textInputType: TextInputType.emailAddress,
                                  controller: emailController,
                                  validationMsg: "field_req".tr(),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "country".tr(),
                                  style: AppTextStyle.bodyText().copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                BlocBuilder<MainCubit, MainState>(
                                    builder: (context, state) {
                                  return state is GetAllCountriesLoadingState
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CustomDropDownButton(
                                          onChanged: (value) {
                                            int index = MainCubit.get(context)
                                                .countries
                                                .indexOf(value!);
                                            selectedCountryId =
                                                MainCubit.get(context)
                                                    .countriesIDs[index];
                                          },
                                          items:
                                              MainCubit.get(context).countries,
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty)
                                              return "country_req".tr();
                                            return null;
                                          },
                                          hintText: '',
                                        );
                                }),
                                SizedBox(
                                  height: 10.h,
                                ),
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
                                  controller: messageController,
                                  maxLines: 5,
                                  validationMsg: "field_req".tr(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocConsumer<MainCubit, MainState>(
                  builder: (BuildContext context, state) {
                    return DefaultButton(
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            MainCubit.get(context)
                                .sendRequestToTechnicalSupport(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    countryId: selectedCountryId!,
                                    message: messageController.text);
                          }
                        },
                        text: "sent_btn".tr());
                  },
                  listener: (BuildContext context, state) async {
                    if (state is SendRequestToTechnicalSupportSuccessState) {
                      customPopUpDialog(
                        context: context,
                        button: DefaultButton(
                          onPress: () {
                            Navigator.pop(context);
                            BottomNavbarCubit.get(context)
                                .changeBottomNavbar(0);
                            NavigationUtils.navigateReplacement(
                                context: context,
                                destinationScreen: VendorMainScreen());
                          },
                          text: "close".tr(),
                          borderRadius: 10.sp,
                        ),
                        icon: "assets/images/success.png",
                        network: false,
                        mainTitle: "successMessage".tr(),
                      );
                    } else if (state
                        is SendRequestToTechnicalSupportErrorState) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ));
                    } else if (state
                        is SendRequestToTechnicalSupportLoadingState) {
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
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
                                      "send_order".tr(),
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
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ));
  }
}
