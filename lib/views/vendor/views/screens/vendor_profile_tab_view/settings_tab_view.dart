import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/cubits/auth/auth_cubit.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/services/local/cache_helper/cache_keys.dart';
import '../../../../../core/shared_components/default_drop_down.dart';
import '../../../../../core/shared_components/default_text_form_field.dart';
import '../../../../../core/shared_components/toast.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../model/profile/profile_model.dart';

class SettingsTabView extends StatefulWidget {
  const SettingsTabView({super.key});

  @override
  State<SettingsTabView> createState() => _SettingsTabViewState();
}

class _SettingsTabViewState extends State<SettingsTabView> {
  var _formKey = GlobalKey<FormState>();
  late var nameController = TextEditingController();
  late var emailController = TextEditingController();
  late var phoneController = TextEditingController();
  late var addressController = TextEditingController();
  late var businessNameController = TextEditingController();
  late var businessTypeController = TextEditingController();
  late var governorateController = TextEditingController();

  late List<
          (String title, TextEditingController controller, FocusNode focusNode)>
      dataFields;
  bool readOnly = true;
  late Data userModel = Data(
      address: '',
      businessName: '',
      businessTypeId: '',
      createdAt: DateTime.now(),
      businessType: BusinessType(id: 0, name: ''),
      governorate: Governorate(name: '', id: 0),
      id: 0,
      name: '',
      email: '',
      governorateId: '',
      image: '',
      phone: '');
  String lang = CacheKeysManger.getLanguageFromCache();
  @override
  void initState() {
    super.initState();

    final profileModel = AuthCubit.get(context).profileModel;

    if (profileModel != null && profileModel.data != null) {
      userModel = profileModel.data!;
      dataFields = [
        (
          'name'.tr(),
          nameController..text = userModel!.name ?? '',
          FocusNode()
        ),
        (
          'email'.tr(),
          emailController..text = userModel!.email ?? '',
          FocusNode()
        ),
        (
          'phone'.tr(),
          phoneController..text = userModel!.phone ?? '',
          FocusNode()
        ),
        (
          'address_field'.tr(),
          addressController..text = userModel!.address ?? '',
          FocusNode()
        ),
        (
          'business_name_field'.tr(),
          businessNameController..text = userModel!.businessName ?? '',
          FocusNode()
        ),
      ];
      businessTypeController.text = userModel!.businessType?.name ?? '';
      governorateController.text = userModel!.governorate?.name ?? '';
    } else {
      dataFields = [];
    }
  }

  int? governmentId;

  String? governmentName;
  int? businessTypeId;

  String? businessTypeName;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    businessNameController.dispose();
    businessTypeController.dispose();
    governorateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: _buildBody(),
      ),
      floatingActionButton: readOnly
          ? null
          : BlocBuilder<AuthCubit, AuthStates>(
              builder: (context, state) {
                return FloatingActionButton(
                  onPressed: () {
                    // todo update profile
                    if (_formKey.currentState!.validate()) {
                      AuthCubit.get(context).updateProfile(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        address: addressController.text,
                        businessName: businessNameController.text,
                        businessTypeId: businessTypeId ??
                            AuthCubit.get(context)
                                .profileModel!
                                .data!
                                .businessType!
                                .id!,
                        governorateId: governmentId ??
                            AuthCubit.get(context)
                                .profileModel!
                                .data!
                                .governorate!
                                .id!,
                        context: context,
                      );
                      readOnly = true;
                    }
                  },
                  child: state is UpdateProfileLoadingState
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text('save'.tr()),
                );
              },
            ),
    );
  }

  ScrollController scorllController = ScrollController();
  Widget _buildBody() {
    var cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
      if (state is UpdateProfileSuccessState) {
        toast(text: state.message, color: Colors.green);
      }
    }, builder: (context, state) {
      return ListView.separated(
        itemCount: dataFields.length + 2,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return SizedBox(height: 10.h);
        },
        itemBuilder: (context, index) {
          if (index == dataFields.length) {
            //! business type
            return SizedBox(
              height: 40.h,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                leading: Container(
                  constraints: BoxConstraints(
                    minWidth: 60.w,
                    maxWidth: 100.w,
                  ),
                  child: Text(
                    'business_type_field'.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                  ),
                ),
                title: DefaultDropdown(
                  hintText: userModel.businessType!.name!,
                  value: businessTypeName,
                  list: AuthCubit.get(context).businessTypes,
                  onChange: (value) {
                    setState(() {
                      readOnly = false;
                      businessTypeController.text = value!;
                      log(businessTypeController.text);
                      int index = cubit.businessTypes.indexOf(value);
                      businessTypeId = cubit.businessTypesIds[index];
                      businessTypeName = value;
                    });
                  },
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Color.fromRGBO(174, 159, 159, 1),
                        fontSize: 12.sp,
                        height: 1,
                      ),
                ),
              ),
            );
          } else if (index == dataFields.length + 1) {
            //! governorate
            return SizedBox(
              height: 40.h,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                leading: Container(
                  constraints: BoxConstraints(
                    minWidth: 60.w,
                    maxWidth: 100.w,
                  ),
                  child: Text(
                    'governorate_field'.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                        ),
                  ),
                ),
                title: DefaultDropdown(
                  hintText: userModel.governorate!.name!,
                  value: governmentName,
                  list: cubit.governorates,
                  onChange: (value) {
                    setState(() {
                      readOnly = false;
                      governorateController.text = value!;
                      int index = cubit.governorates.indexOf(value);
                      governmentId = cubit.governoratesIds[index];
                      governmentName = value;
                    });
                  },
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Color.fromRGBO(174, 159, 159, 1),
                        fontSize: 12.sp,
                        height: 1,
                      ),
                ),
              ),
            );
          }
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            leading: Container(
              constraints: BoxConstraints(
                minWidth: 80.w,
                maxWidth: 80.w,
              ),
              child: Text(
                dataFields[index].$1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                    ),
              ),
            ),
            title: StatefulBuilder(
              builder: (context, setState) {
                return DefaultTextFormField(
                  readOnly: readOnly,
                  focusNode: dataFields[index].$3,
                  controller: dataFields[index].$2,
                  onChange: (data) {},
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Color.fromRGBO(174, 159, 159, 1),
                        fontSize: 12.sp,
                        height: 1,
                      ),
                  suffixIcon: InkWell(
                    onTap: () {
                      //* if the screen has profile image (isFullScreen == false)
                      // if (!VendorProfileCubit.get(context).isFullScreen) {
                      //   VendorProfileCubit.get(context)
                      //       .toggleFullScreen(true);
                      // }
                      this.setState(() {
                        readOnly = false;
                        FocusScope.of(context)
                            .requestFocus(dataFields[index].$3);
                      });
                    },
                    child: Image.asset(
                      Assets.imagesEditPen,
                      color: readOnly ? Colors.grey : AppColors.primaryColor,
                    ),
                  ),
                  textInputType:
                      index == 2 ? TextInputType.phone : TextInputType.text,
                );
              },
            ),
          );
        },
      );
    });
  }
}
