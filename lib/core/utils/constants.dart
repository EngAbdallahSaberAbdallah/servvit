import 'dart:io';

import 'package:echo/core/colors/app_colors.dart';
import 'package:echo/core/text_styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/profile/profile_model.dart';

File? file;
int catIndex = 0;
int? merchantId;
Future<String?> pickImageFromCamera() async {
  // var permission = await Permission.camera.request();
  // if (permission.isDenied) {
  //   permission = await Permission.camera.request();
  //   if (permission.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }
  // if (permission.isGranted || permission.isLimited) {
  //   return await ImagePicker().pickImage(source: ImageSource.camera).then(
  //     (image) {
  //       if (image != null) {
  //         return image.path;
  //       }
  //       return null;
  //     },
  //   );
  // }
  // return null;

  return await ImagePicker().pickImage(source: ImageSource.camera).then(
    (image) {
      if (image != null) {
        return image.path;
      }
      return null;
    },
  );
}

Future<String?> pickImageFromGallery() async {
  // var permission = await Permission.photos.request();
  // if (permission.isDenied) {
  //   permission = await Permission.manageExternalStorage.request();
  //   // if (permission.isPermanentlyDenied) {
  //   //   await openAppSettings();
  //   // }
  // }
  // log(permission.toString());
  // if (permission.isGranted || permission.isLimited) {
  //   return await ImagePicker().pickImage(source: ImageSource.gallery).then(
  //     (image) {
  //       if (image != null) {
  //         return image.path;
  //       }
  //       return null;
  //     },
  //   );
  // }
  // return null;
  return await ImagePicker().pickImage(source: ImageSource.gallery).then(
    (image) {
      if (image != null) {
        return image.path;
      }
      return null;
    },
  );
}

Future<List<String>> pickMultiImagesFromGallery() async {
  // Android TIRAMISU => Android 13
  // var permission = await Permission.photos.request();

  // if (permission.isDenied || permission.isPermanentlyDenied) {
  //   permission = await Permission.manageExternalStorage.request();
  // }

  // log(permission.toString());
  // if (permission.isGranted || permission.isLimited) {
  //   return await ImagePicker().pickMultiImage().then(
  //     (images) {
  //       if (images.isNotEmpty) {
  //         var imagesPaths = <String>[];
  //         for (var element in images) {
  //           imagesPaths.add(element.path);
  //         }
  //         return imagesPaths;
  //       }
  //       return [];
  //     },
  //   );
  // }
  // return [];

  return await ImagePicker().pickMultiImage().then(
    (images) {
      if (images.isNotEmpty) {
        var imagesPaths = <String>[];
        for (var element in images) {
          imagesPaths.add(element.path);
        }
        return imagesPaths;
      }
      return [];
    },
  );
}

void showDialogWidget({
  required BuildContext context,
  required String title,
  required String content,
  List<Widget>? actions,
  MainAxisAlignment? actionsAlignment,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      title: Text(title),
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 12.sp,
                color: Color.fromRGBO(160, 160, 162, 1),
              ),
        ),
      ),
      actionsAlignment: actionsAlignment,
      actions: actions ??
          [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  backgroundColor: AppColors.primaryColor),
              child: Text(
                'Ok',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
    ),
  );
}

void showSnackBar({
  required BuildContext context,
  String? message,
  SnackBarAction? action,
  Color? backgroundColor,
  Widget? content,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      content: content ??
          Text(
            message!,
            style: AppTextStyle.subTitle().copyWith(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
      action: action,
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 4),
    ),
  );
}

Data? ConsProfileData;

bool fromHome = false;
