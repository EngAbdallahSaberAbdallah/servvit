import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/enums/image_type.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/custom_dropdown_formfield.dart';
import 'package:echo/core/shared_components/default_button.dart';
import 'package:echo/core/shared_components/default_text_form_field.dart';
import 'package:echo/core/shared_components/profile_picture.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:echo/model/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/constants.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var businessNameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? businessType;
  String? government;
  String? governmentId;

  @override
  Widget build(BuildContext context) {
    nameController.text = ConsProfileData!.name ??"";
    emailController.text = ConsProfileData!.email ??"" ;
    businessNameController.text = ConsProfileData!.businessName ??"";
    phoneController.text = ConsProfileData!.phone ??"";
    addressController.text = ConsProfileData!.address ??"";
    governmentId = ConsProfileData!.governorateId ;
    government = ConsProfileData!.governorate!.name ;
    businessType = ConsProfileData!.businessName ;
    print("fayez.......: ${EndPoints.suppliers +ConsProfileData!.image.toString()}");

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {

                return ProfilePicture(
                  imageType: AuthCubit.get(context).profileImage == null ? ImageType.network : ImageType.file,
                  imageLink: AuthCubit.get(context).profileImage == null
                      ? EndPoints.suppliers +ConsProfileData!.image.toString()
                      : AuthCubit.get(context).profileImage,
                  hasEdit: true,
                  onTap: () {
                    AuthCubit.get(context).pickProfileImage();
                  },
                );
              }),
              SizedBox(height: 10.h),
              DefaultTextFormField(
                textInputType: TextInputType.text,
                controller: nameController,
                fillColor: Colors.white,
                isFilled: true,
                hintText: "enter_name".tr(),
                validationMsg: "req_enter_name".tr(),
              ),

              // SizedBox(height: 10.h),
              // DefaultTextFormField(
              //   textInputType: TextInputType.text,
              //   controller: nameArController,
              //   fillColor: Colors.white,
              //   isFilled: true,
              //   hintText: "enter_ar_name".tr(),
              //   validationMsg: "req_enter_ar_name".tr(),
              // ),
              SizedBox(height: 10.h),
              DefaultTextFormField(
                textInputType: TextInputType.emailAddress,
                controller: emailController,
                fillColor: Colors.white,
                isFilled: true,
                hintText: "enter_mail".tr(),
                validationMsg: "req_enter_mail".tr(),
              ),
              SizedBox(height: 10.h),
              DefaultTextFormField(
                textInputType: TextInputType.text,
                controller: businessNameController,
                fillColor: Colors.white,
                isFilled: true,
                hintText: "enter_business".tr(),
                validationMsg: "enter_business".tr(),
              ),
              // SizedBox(height: 10.h),
              // DefaultTextFormField(
              //   textInputType: TextInputType.text,
              //   controller: businessArNameController,
              //   fillColor: Colors.white,
              //   isFilled: true,
              //   hintText: "enter_ar_business".tr(),
              //   validationMsg: "enter_ar_business".tr(),
              // ),
              SizedBox(height: 10.h),
              DefaultTextFormField(
                textInputType: TextInputType.phone,
                controller: phoneController,
                fillColor: Colors.white,
                isFilled: true,
                hintText: "enter_phone".tr(),
                validationMsg: "enter_phone".tr(),
              ),
              // SizedBox(height: 10.h),
              // CustomDropDownButton(
              //     hintText: businessType??"",
              //     onChanged: (value) {
              //       int index = AuthCubit.get(context).businessTypes.indexOf(value!);
              //       businessTypeId = AuthCubit.get(context).businessTypesIds[index].toString();
              //       businessType = value;
              //     },
              //     items: AuthCubit.get(context).businessTypes,
              //     validator: (value) {
              //       return null;
              //     }),
              SizedBox(height: 10.h),
              CustomDropDownButton(
                  hintText: government??"",
                  onChanged: (value) {
                    int index = AuthCubit.get(context).governorates.indexOf(value!);
                    governmentId = AuthCubit.get(context).governoratesIds[index].toString();
                    government = value;
                  },
                  items: AuthCubit.get(context).governorates,
                  validator: (value) {
                    return null;
                  }),
              SizedBox(height: 10.h),
              DefaultTextFormField(
                textInputType: TextInputType.text,
                controller: addressController,
                fillColor: Colors.white,
                isFilled: true,
                hintText: "enter_address".tr(),
                validationMsg: "enter_address".tr(),
              ),
              SizedBox(height: 10.h),
              // DefaultTextFormField(
              //   textInputType: TextInputType.text,
              //   controller: addressArController,
              //   fillColor: Colors.white,
              //   isFilled: true,
              //   hintText: "enter_ar_address".tr(),
              //   validationMsg: "enter_ar_address".tr(),
              // ),
              // SizedBox(height: 20.h),
              BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {
                  if (state is UpdateProfileSuccessState) {
                    toast(text: state.message, color: Colors.green);
                    AuthCubit.get(context).profileImage=null;
                  }
                },
                builder: (context, state) => state is UpdateProfileLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: DefaultButton(
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                AuthCubit.get(context).updateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  address: addressController.text,
                                  businessName: businessNameController.text,
                                  governorateId: int.parse(governmentId!),
                                  context: context,
                                );
                              }
                            },
                            text: "update".tr()),
                      ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
