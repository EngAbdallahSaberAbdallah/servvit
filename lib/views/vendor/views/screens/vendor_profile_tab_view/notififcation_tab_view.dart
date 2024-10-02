import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/shared_components/error_widget.dart';
import 'package:echo/views/vendor/views/screens/vendor_profile_tab_view/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/text_styles/app_text_style.dart';
import '../../../../../cubits/vendor_profile/vendor_profile_cubit.dart';
import '../../widgets/notification_widget.dart';

class NotificationTabView extends StatefulWidget {
  const NotificationTabView({super.key});

  @override
  State<NotificationTabView> createState() => _NotificationTabViewState();
}

class _NotificationTabViewState extends State<NotificationTabView> with AutomaticKeepAliveClientMixin {
  initState() {
    super.initState();
  }





  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    VendorProfileCubit.get(context).getAllNotifications();
    VendorProfileCubit.get(context).notificationsCount();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    log('NotificationTabView');
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      child: BlocBuilder<VendorProfileCubit, VendorProfileState>(
        buildWhen: (previous, current) {
          if (current is VendorProfileNotificationSuccess ||
              current is VendorProfileNotificationLoading ||
              current is VendorProfileNotificationError) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state is VendorProfileNotificationSuccess) {
            var notifications = VendorProfileCubit.get(context).notifications;
            return notifications.isEmpty
                ? Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/no_noty.jpg",
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width * .3,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'no_noty_desc'.tr(),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.bodyText().copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                : ListView.separated(
                    controller: VendorProfileCubit.get(context)
                        .scrollControllerHandler
                        .scrollController,
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return NotificationWidget(
                        title: notifications[index].$1,
                        message: notifications[index].$2,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                  );
          }else if(state is VendorProfileNotificationLoading){
            return ShimmerLoadingWidget();
          }else{
            return  CustomErrorWidget(
              onTap: () {
                VendorProfileCubit.get(context).getAllNotifications();
                VendorProfileCubit.get(context).notificationsCount();
              },
            );
          }

        },
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
