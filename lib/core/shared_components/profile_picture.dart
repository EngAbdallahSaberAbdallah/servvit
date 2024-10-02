import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../enums/image_type.dart';
import 'default_cached_network_image.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture(
      {Key? key,
      this.onTap,
      required this.imageType,
      required this.imageLink,
      this.size,
      this.hasEdit = false})
      : super(key: key);
  void Function()? onTap;
  ImageType imageType;
  dynamic imageLink;
  double? size;
  bool hasEdit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: size ?? 50.r,
              backgroundColor: Colors.grey.shade100,
              backgroundImage: imageLink == null || imageLink == ""
                  ? const AssetImage("assets/images/user.png")
                  : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: (imageLink == null)
                    ? null
                    : (imageType == ImageType.file)
                        ? Image.file(imageLink,
                            height: 120.h, width: 120.w, fit: BoxFit.contain)
                        : (imageType == ImageType.network)
                            ? DefaultCachedNetworkImage(
                                imageUrl: imageLink,
                                imageHeight: 120.h,
                                imageWidth: 120.w,
                              )
                            : (imageType == ImageType.asset)
                                ? Image.asset(imageLink,
                                    height: 120.h,
                                    width: 120.w,
                                    fit: BoxFit.contain)
                                : null,
              ),
            ),
            if (hasEdit)
              CircleAvatar(
                radius: 13.r,
                backgroundColor: Colors.grey[150],
                child: Icon(
                  Icons.edit,
                  size: 20.r,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
