import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/services/local/cache_helper/cache_helper.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:echo/core/services/remote/dio/dio_helper.dart';
import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:echo/core/shared_components/toast.dart';
import 'package:echo/cubits/auth/auth_states.dart';
import 'package:echo/model/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/constants.dart';

class   AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

  static AuthCubit get(context) => BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  File? profileImage;

  pickProfileImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);
      if (CacheKeysManger.getUserTokenFromCache() != '') {
        await updateProfile(
          name: profileModel!.data!.name!,
          phone: profileModel!.data!.phone!,
          email: profileModel!.data!.email!,
          address: profileModel!.data!.address!,
          businessName: profileModel!.data!.businessName,
          businessTypeId: profileModel!.data!.businessType!.id,
          governorateId: profileModel!.data!.governorate!.id!,
        );
      }

      emit(SuccessPickImage());
    }
  }

  List<String> governorates = [];
  List<int> governoratesIds = [];

  getGovernorates() {
    emit(GetGovernmentsLoadingState());
    DioHelper.getData(url: EndPoints.getGovernorates).then((value) async {
      if (value.statusCode == 200) {
        governorates.clear();
        governoratesIds.clear();
        for (int i = 0; i < value.data["data"].length; i++) {
          governorates.add(value.data["data"][i]["name"].toString());
          governoratesIds.add(value.data["data"][i]["id"]);
        }
        emit(GetGovernmentsSuccessState());
      } else {
        emit(GetGovernmentsErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetGovernmentsErrorState());
    });
  }

  List<String> businessTypes = [];
  List<int> businessTypesIds = [];

  getBusinessTypes() {
    emit(GetBusinessTypesLoadingState());
    DioHelper.getData(url: EndPoints.getBusinessTypes).then((value) async {
      if (value.statusCode == 200) {
        businessTypes.clear();
        businessTypesIds.clear();
        for (int i = 0; i < value.data["data"].length; i++) {
          businessTypes.add(value.data["data"][i]["name"].toString());
          businessTypesIds.add(value.data["data"][i]["id"]);
        }
        emit(GetBusinessTypesSuccessState());
      } else {
        emit(GetBusinessTypesErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetBusinessTypesErrorState());
    });
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    // required String password,
    required String address,
    String? businessName,
    int? businessTypeId,
    required int governorateId,
    required BuildContext context,
  }) async {
    emit(RegisterLoadingState());
    await DioHelper.postForm(
        url: CacheKeysManger.getUserTypeFromCache() == "Supplier"
            ? EndPoints.supplierRegister
            : EndPoints.userRegister,
        data: FormData.fromMap({
          "name": name,
          "email": email,
          // "password": password,
          "phone": phone,
          "address": address,
          "business_name": businessName,
          "business_type_id": businessTypeId,
          if (profileImage != null)
            "image": await MultipartFile.fromFile(profileImage!.path),
          "governorate_id": governorateId,
        })).then((value) {
      if (value.statusCode == 200) {
        emit(RegisterSuccessState(value.data["message"]));
      } else {
        toast(text: value.data["message"], color: Colors.red);
        emit(RegisterErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(RegisterErrorState());
    });
  }

  int userCode = 0;
  Future<void> login(
      {required String phone, required BuildContext context}) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
        url: CacheKeysManger.getUserTypeFromCache() == "Supplier"
            ? EndPoints.supplierLogin
            : EndPoints.userLogin,
        data: {
          "phone": phone,
        }).then((value) async {
      if (value.statusCode == 200) {
        print("************** Code is ******************");
        userCode = value.data["code"];
        //forTestOnly
        await AuthCubit.get(context).sendOtp(
          phone: phone,
          code: AuthCubit.get(context).userCode.toString(),
          context: context,
        );
        deviceToken(language: 'ar');
        emit(LoginSuccessState(value.data["message"]));
      } else if (value.statusCode == 422) {
        toast(text: value.data["message"], color: Colors.red);
        emit(LoginErrorState());
      } else {
        emit(LoginErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState());
    });
  }

  Future<void> addFcmTokenSupplier({required String token}) async {
    setTokenApi(token: token, endPoint: EndPoints.supplierFcmToken);
  }

  Future<void> addFcmTokenUser({required String token}) async {
    setTokenApi(token: token, endPoint: EndPoints.userFcmToken);
  }

  void setTokenApi({required String token, required String endPoint}) async {
    await DioHelper.postData(
        url: endPoint,
        sendAuthToken: true,
        data: FormData.fromMap({
          "ftoken": token,
        })).then((value) {
      print('token is $value and $token');
    });
  }

  void deviceToken({required String language}) async {
    await DioHelper.postData(url: EndPoints.userDeviceToken, data: {
      "userDeviceToken": language,
    });
  }

  Future<void> sendOtp({
    required String phone,
    required String code,
    required BuildContext context,
  }) async {
    emit(SendOtpLoadingState());
    await DioHelper.postData(
        url: CacheKeysManger.getUserTypeFromCache() == "Supplier"
            ? EndPoints.supplierCheckOtp
            : EndPoints.userCheckOtp,
        data: {
          "phone": phone,
          "code": code,
        }).then((value) async {
      if (value.statusCode == 200) {
        CacheHelper.saveData(
            key: "userToken", value: "${value.data["access_token"]}");
        emit(SendOtpSuccessState(value.data["message"]));
      } else if (value.statusCode == 422) {
        toast(text: value.data["message"], color: Colors.red);
        emit(SendOtpErrorState());
      } else {
        emit(SendOtpErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SendOtpErrorState());
    });
  }

  ProfileModel? profileModel;

  void getProfileData() async {
    emit(GetProfileDataLoadingState());

    await DioHelper.getData(
      url: CacheKeysManger.getUserTypeFromCache() == "Supplier"
          ? EndPoints.supplierProfileData
          : EndPoints.userProfileData,
      sendAuthToken: true,
    ).then((value) async {
      if (value.statusCode == 200) {
        profileModel = await ProfileModel.fromJson(value.data);
        ConsProfileData = profileModel!.data;
        // CacheKeysManger.saveProfileData(profileModel!);
        print("DIO:${profileModel!.data!.image}");
        emit(GetProfileDataSuccessState());
      } else {
        emit(GetProfileDataErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      // if (CacheKeysManger.getProfileDataFromShared() != null) {
      //   profileModel = ProfileModel.fromRawJson(
      //       CacheKeysManger.getProfileDataFromShared()!);
      // }
      emit(GetProfileDataErrorState());
    });
    // rethrow;
    // }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    await DioHelper.postData(
      url: CacheKeysManger.getUserTypeFromCache() == "Supplier"
          ? EndPoints.supplierLogout
          : EndPoints.userLogout,
      sendAuthToken: true,
    ).then((value) async {
      if (value.statusCode == 200) {
        CacheHelper.removeData(key: "userToken");
        CacheHelper.removeData(key: "type");
        emit(LogoutSuccessState(value.data["message"].toString()));
      } else {
        emit(LogoutErrorState());
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LogoutErrorState());
    });
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
    String? businessName,
    int? businessTypeId,
    required int governorateId,
    BuildContext? context,
  }) async {
    emit(UpdateProfileLoadingState());
    await DioHelper.postForm(
        url: CacheKeysManger.getUserTypeFromCache() == "Supplier"
            ? EndPoints.supplierUpdateProfile
            : EndPoints.userUpdateProfile,
        sendAuthToken: true,
        data: FormData.fromMap({
          "name": name,
          "email": email,
          "phone": phone,
          "address": address,
          "business_name": businessName,
          'business_type_id': businessTypeId,
          if (profileImage != null)
            "image": await MultipartFile.fromFile(profileImage!.path),
          "governorate_id": governorateId,
        })).then((value) {
      if (value.statusCode == 200) {
        getProfileData();
        emit(UpdateProfileSuccessState("updated_success".tr()));
      } else if (value.statusCode == 422) {
        toast(text: value.data["message"], color: Colors.red);
        emit(UpdateProfileErrorState());
      } else {
        emit(UpdateProfileErrorState());
        toast(text: 'something_happened'.tr(), color: Colors.red);
      }
    }).catchError((error) {
      log(error.toString());
      emit(UpdateProfileErrorState());
    });
  }
}
