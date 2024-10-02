import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/utils/navigation_utility.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:echo/views/vendor/views/screens/payment_method/vendor_payment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/shared_components/custom_dropdown_formfield.dart';
import '../../../../../core/shared_components/toast.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../cubits/auth/auth_cubit.dart';
import '../../../../../cubits/payment_method_cubit/payment_method_cubit.dart';
import '../../../../../model/vendor_cart_model/vendor_cart_model.dart';
import '../../widgets/text_form_field_payment.dart';

class VendorPaymentInfoForm extends StatefulWidget {
  const VendorPaymentInfoForm({
    super.key,
    required this.cartItems,
  });
  final List<VendorCartModel> cartItems;

  @override
  State<VendorPaymentInfoForm> createState() => _VendorPaymentMethofState();
}

class _VendorPaymentMethofState extends State<VendorPaymentInfoForm> {
  var _formKey = GlobalKey<FormState>();
  var commercialRegisterController = TextEditingController();
  var couponController = TextEditingController();
  var shippingAddressController = TextEditingController();
  var emailAddressController = TextEditingController();

  late List<(String title, TextEditingController controller)> peronsInfoData;
  @override
  void initState() {
    super.initState();
    peronsInfoData = [
      (
        'commerical_register'.tr(),
        commercialRegisterController,
      ),
      (
        'email_address'.tr(),
        emailAddressController,
      ),
      (
        'shipping_address'.tr(),
        shippingAddressController,
      ),
      (
        'coupon'.tr(),
        couponController,
      ),
    ];
    // PaymentMethodCubit.get(context).getAllGovernorates();
    AuthCubit.get(context).getGovernorates();
  }

  @override
  void dispose() {
    peronsInfoData[0].$2.dispose();
    peronsInfoData[1].$2.dispose();
    peronsInfoData[2].$2.dispose();
    peronsInfoData[3].$2.dispose();
    super.dispose();
  }

  int? governmentId;

  String? governmentName;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Future(() async {
    //   governorates = CacheKeysManger.getLanguageFromCache() == 'ar'
    //       ? (await GovernoratorsGenerator.generate()).map((e) => e.ar).toList()
    //       : (await GovernoratorsGenerator.generate()).map((e) => e.en).toList();
    // }).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);

    return WillPopScope(
      onWillPop: () async {
        if (PaymentMethodCubit.get(context).state
            is GetShippingCostLoadingState) {
          toast(text: 'loading_hint'.tr(), color: AppColors.primaryColor);
          return false;
        }
        PaymentMethodCubit.get(context).selectedImage = null;
        return true;
      },
      child: Scaffold(
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
              if (PaymentMethodCubit.get(context).state
                  is GetShippingCostLoadingState) {
                toast(text: 'loading_hint'.tr(), color: AppColors.primaryColor);
              } else {
                PaymentMethodCubit.get(context).selectedImage = null;
                Navigator.pop(context);
              }
            },
            icon: SvgPicture.asset(
              Assets.imagesIconBackSquare,
              height: 20.h,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.w),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'payment_method'.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// info form
                  //! commerical register
                  Text(
                    peronsInfoData[0].$1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 10.sp,
                        ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    child: FormFieldPaymentMethod(
                      controller: peronsInfoData[0].$2,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'field_req'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  //! shipping address
                  Text(
                    peronsInfoData[1].$1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 10.sp,
                        ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    child: FormFieldPaymentMethod(
                      controller: peronsInfoData[1].$2,
                      textInputType: TextInputType.emailAddress,
                      //   validator: (value) {
                      //     const pattern =
                      //         r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                      //         r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                      //         r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                      //         r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                      //         r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                      //         r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                      //         r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                      //     final regex = RegExp(pattern);

                      //     return value!.isEmpty
                      //         ? 'field_req'.tr()
                      //         : !regex.hasMatch(value)? '${'field_req'.tr()} ${'ex'.tr()}: a@a.com':null;
                      //   },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    peronsInfoData[2].$1,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 10.sp,
                        ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    child: FormFieldPaymentMethod(
                      controller: peronsInfoData[2].$2,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'field_req'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  //! goverorate
                  Text(
                    "governorate".tr(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 10.sp,
                        ),
                  ),
                  SizedBox(height: 5.h),
                  BlocBuilder<AuthCubit, AuthStates>(
                    builder: (context, state) {
                      if (state is GetGovernmentsLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                          ),
                        );
                      }
                      int index =
                          cubit.governorates.indexOf(cubit.governorates[0]);
                      governmentId = cubit.governoratesIds[index];
                      return CustomDropDownButton(
                          hintText: "governorate".tr(),
                          valueTextStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 10.sp,
                                  ),
                          borderRadius: BorderRadius.circular(20.r),
                          onChanged: (value) {
                            setState(() {
                              int index = cubit.governorates.indexOf(value!);
                              governmentId = cubit.governoratesIds[index];
                              governmentName = value;
                            });
                          },
                          items: cubit.governorates,
                          validator: (value) {
                            if (value == null)
                              return "requiredMessages.governorate".tr();
                            return null;
                          });
                    },
                  ),
                  SizedBox(height: 10.h),
                  //! coupon
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: peronsInfoData[3].$1,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 10.sp,
                                  ),
                        ),
                        TextSpan(
                          text: ' (${'optional'.tr()})',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 10.sp,
                                    color: Color.fromRGBO(122, 121, 121, 1),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    child: FormFieldPaymentMethod(
                      controller: peronsInfoData[3].$2,
                      textInputType: TextInputType.text,
                      mandatory: false,
                      validator: (v) => null,
                    ),
                  ),

                  SizedBox(height: 15.h),
                  //! upload document
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'upload_document'.tr(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 10.sp,
                                  ),
                        ),
                        TextSpan(
                          text: ' (${'optional'.tr()})',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 10.sp,
                                    color: Color.fromRGBO(122, 121, 121, 1),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
                      builder: (context, state) {
                        //* if image is selected
                        if (PaymentMethodCubit.get(context).selectedImage !=
                            null) {
                          return FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: Color.fromRGBO(160, 160, 162, 1),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.file(
                                    File(PaymentMethodCubit.get(context)
                                        .selectedImage!),
                                    fit: BoxFit.contain,
                                    height: 100.h,
                                    width: 150.w,
                                  ),
                                  SizedBox(height: 5.h),
                                  InkWell(
                                    onTap: () {
                                      PaymentMethodCubit.get(context)
                                          .selectImage();
                                    },
                                    child: Text(
                                      'replace_image'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 14.sp,
                                            color: AppColors.primaryColor,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return InkWell(
                          onTap: () {
                            PaymentMethodCubit.get(context).selectImage();
                          },
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: Color.fromRGBO(160, 160, 162, 1),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.imagesUploadImage,
                                    height: 50.h,
                                    width: 50.w,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    'upload_image'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 14.sp,
                                          color: AppColors.primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: ElevatedButton(
                      onPressed: PaymentMethodCubit.get(context).state
                              is GetShippingCostLoadingState
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                //todo save the user info and navigate to last payment step
                                var profileModel =
                                    AuthCubit.get(context).profileModel;
                                PaymentMethodCubit.get(context)
                                    .paymentOrderRequest
                                  ..name = profileModel?.data?.name
                                  ..phone = profileModel?.data?.phone
                                  ..email = profileModel?.data?.email
                                  ..address = profileModel?.data?.address
                                  ..shippingAddress =
                                      shippingAddressController.text
                                  ..commericalRegisterNumber =
                                      commercialRegisterController.text
                                  ..governorateId = governmentId.toString()
                                  ..image = PaymentMethodCubit.get(context)
                                      .selectedImage
                                  ..couponCode = couponController.text.isEmpty
                                      ? null
                                      : couponController.text;

                                PaymentMethodCubit.get(context)
                                    .getShippingCost();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 10.w, vertical: 0.h),
                        minimumSize: Size(200.w, 30.h),
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child:
                          BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
                        listener: (context, state) {
                          //todo if it error like dose not delovery to any
                          if (state is GetShippingCostSuccessState) {
                            NavigationUtils.navigateTo(
                                context: context,
                                destinationScreen: VendorPaymentDetails());
                          }
                          if (state is GetShippingCostFailureState) {
                            toast(text: state.errorMessage, color: Colors.red);
                          }
                        },
                        builder: (context, state) {
                          if (state is GetShippingCostLoadingState) {
                            return SizedBox(
                              height: 15.h,
                              width: 15.w,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            );
                          }
                          return Text(
                            'check_out_continue'.tr(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
