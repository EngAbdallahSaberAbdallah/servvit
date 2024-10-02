import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/enums/image_type.dart';
import 'package:echo/core/shared_components/custom_back_ground.dart';
import 'package:echo/core/shared_components/custom_dropdown_formfield.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_text_form_field.dart';
import 'package:echo/core/shared_components/profile_picture.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:echo/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var businessNameController = TextEditingController();

  var addressController = TextEditingController();

  var phoneController = TextEditingController();

  int? businessTypeId;
  int selectedIndexForBussiness = 0;

  String? businessTypeName;

  int? governmentId;
  int selectedIndexForGovernment = 0;

  String? governmentName;

  var formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('rebuild');
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit.get(context).profileImage = null;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomBg(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: BlocBuilder<AuthCubit, AuthStates>(
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    return Column(
                      children: [
                        SizedBox(height: 20.h),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       vertical: 10.h, horizontal: 10.w),
                        //   child: Align(
                        //     alignment: Alignment.topLeft,
                        //     child: DropdownButton(
                        //       hint: context.locale == Locale('ar')
                        //           ? Text('العربية')
                        //           : Text('English'),
                        //       borderRadius: BorderRadius.circular(15.r),
                        //       isDense: true,
                        //       items: <DropdownMenuItem<String>>[
                        //         DropdownMenuItem(
                        //             value: "ar", child: Text('العربية')),
                        //         DropdownMenuItem(
                        //             value: "en", child: Text('English')),
                        //       ],
                        //       onChanged: (lang) {
                        //         context.setLocale(Locale(lang!));
                        //       },
                        //     ),
                        //   ),
                        // ),

                        Image.asset(
                          "assets/images/logo.png",
                          height: 70.h,
                        ),
                        SizedBox(height: 10.h),
                        ProfilePicture(
                          imageType: cubit.profileImage == null
                              ? ImageType.asset
                              : ImageType.file,
                          imageLink: cubit.profileImage == null
                              ? "assets/images/user.png"
                              : cubit.profileImage,
                          hasEdit: true,
                          onTap: () {
                            cubit.pickProfileImage();
                          },
                        ),
                        SizedBox(height: 15.h),
                        DefaultTextFormField(
                          textInputType: TextInputType.text,
                          controller: nameController,
                          fillColor: Colors.white,
                          isFilled: true,
                          // hasBorder: true,
                          hintText: "name".tr(),
                          validationMsg: "requiredMessages.name".tr(),
                        ),
                        SizedBox(height: 10.h),
                        DefaultTextFormField(
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          fillColor: Colors.white,
                          isFilled: true,
                          hasBorder: true,
                          hintText: "email".tr(),
                          validationMsg: "requiredMessages.email".tr(),
                        ),
                        SizedBox(height: 10.h),
                        DefaultTextFormField(
                          textInputType: TextInputType.phone,
                          controller: phoneController,
                          fillColor: Colors.white,
                          isFilled: true,
                          hasBorder: true,
                          hintText: "phone".tr(),
                          validationMsg: "requiredMessages.phone".tr(),
                        ),
                        SizedBox(height: 10.h),

                        // DefaultTextFormField(
                        //   textInputType: TextInputType.visiblePassword,
                        //   controller: passwordController,
                        //   fillColor: Colors.white,
                        //   isFilled: true,
                        //   isPassword: true,
                        //   maxLines: 1,
                        //   hintText: "password".tr(),
                        //   validationMsg: "requiredMessages.password".tr(),
                        // ),
                        // SizedBox(height: 10.h),
                        // DefaultTextFormField(
                        //   textInputType: TextInputType.visiblePassword,
                        //   controller: confirmPasswordController,
                        //   fillColor: Colors.white,
                        //   isFilled: true,
                        //   isPassword: true,
                        //   maxLines: 1,
                        //   validator: (value) {
                        //     log('validate:$value');
                        //     if (value == null || value.isEmpty) {
                        //       return "requiredMessages.confirmPassword".tr();
                        //     }
                        //     if (value != passwordController.text) {
                        //       return "errorMessages.confirmPassword".tr();
                        //     }
                        //     return null;
                        //   },
                        //   hintText: "confirmPassword".tr(),
                        //   // validationMsg: "password dose not match",
                        // ),

                        SizedBox(height: 10.h),
                        CustomDropDownButton(
                          hintText: "businessType".tr(),
                          // valueTextStyle: Theme.of(context).textTheme.bodyLarge,
                          onChanged: (value) {
                            int index = cubit.businessTypes.indexOf(value!);
                            setState(() {
                              selectedIndexForBussiness = index;
                              businessTypeId = cubit.businessTypesIds[index];
                              businessTypeName = value;
                            });
                          },
                          items: cubit.businessTypes,
                          validator: (value) {
                            if (value == null)
                              return "requiredMessages.businessType".tr();
                            return null;
                          },
                          isFilled: true,
                          hasBorder: true,
                        ),
                        SizedBox(height: 10.h),
                        DefaultTextFormField(
                          textInputType: TextInputType.text,
                          controller: businessNameController,
                          fillColor: Colors.white,
                          isFilled: true,
                          hasBorder: true,
                          hintText: "businessName".tr(),
                          validationMsg: "requiredMessages.businessName".tr(),
                        ),
                        SizedBox(height: 10.h),
                        CustomDropDownButton(
                          hintText: "governorate".tr(),
                          // valueTextStyle: Theme.of(context).textTheme.bodyLarge,
                          onChanged: (value) {
                            int index = cubit.governorates.indexOf(value!);
                            setState(() {
                              selectedIndexForGovernment = index;
                              governmentId = cubit.governoratesIds[index];
                              governmentName = value;
                            });
                          },
                          items: cubit.governorates,
                          validator: (value) {
                            if (value == null)
                              return "requiredMessages.governorate".tr();
                            return null;
                          },
                          isFilled: true,
                          hasBorder: true,
                        ),
                        SizedBox(height: 10.h),
                        DefaultTextFormField(
                          textInputType: TextInputType.text,
                          controller: addressController,
                          fillColor: Colors.white,
                          isFilled: true,
                          hasBorder: true,
                          hintText: "address".tr(),
                          validationMsg: "requiredMessages.address".tr(),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: BlocConsumer<AuthCubit, AuthStates>(
                            listener: (context, state) {
                              if (state is RegisterSuccessState) {
                                toast(text: state.message, color: Colors.green);
                                NavigationUtils.navigateReplacement(
                                    context: context,
                                    destinationScreen: LoginScreen());
                              }
                            },
                            builder: (context, state) => state
                                    is RegisterLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : DefaultButton(
                                    onPress: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.register(
                                          name: nameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          // password: passwordController.text,
                                          address: addressController.text,
                                          businessName:
                                              businessNameController.text,
                                          businessTypeId:selectedIndexForBussiness == 0? cubit.businessTypesIds[0] :  businessTypeId,
                                          governorateId: selectedIndexForGovernment == 0? cubit.governoratesIds[0] : governmentId!,
                                          context: context,
                                        );
                                      }
                                      // if (cubit.profileImage == null) {
                                      //   toast(
                                      //       text:
                                      //           "Please Select your Profile Image",
                                      //       color: Colors.red);
                                      // }
                                    },
                                    text: "sign_up".tr(),
                                  ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
