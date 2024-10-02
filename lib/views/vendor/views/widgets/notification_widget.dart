import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/utils/constants.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.message,
    required this.title,
  });
  final String message;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.primaryColor,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          showDialogWidget(
            context: context,
            title: title,
            content: message,
            actionsAlignment: MainAxisAlignment.center,
          );
        },
        leading: Icon(
          Icons.notifications,
          size: 30.w,
          color: AppColors.primaryColor.withOpacity(.8),
        ),
        title: Text(
          message,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                overflow: TextOverflow.ellipsis,
                fontSize: 12.sp,
                color: Color.fromRGBO(160, 160, 162, 1),
              ),
        ),
      ),
    );
  }
}
