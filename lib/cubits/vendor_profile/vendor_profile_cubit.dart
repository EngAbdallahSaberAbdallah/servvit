import 'dart:developer';

import 'package:echo/core/services/remote/dio/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/remote/dio/dio_helper.dart';
import '../../core/utils/scroll_controller_handler.dart';
import '../../model/order_model/order_model.dart';

part 'vendor_profile_state.dart';

class VendorProfileCubit extends Cubit<VendorProfileState> {
  VendorProfileCubit() : super(VendorProfileInitial()) {
    scrollControllerHandler.setActionToListen(
      action: () {
        if (scrollControllerHandler.currentScrollPosition > 150 &&
            !isFullScreen) {
          isFullScreen = true;
          emit(VendorProfileFullScreen());
        } else if (scrollControllerHandler.currentScrollPosition < 150 &&
            isFullScreen) {
          isFullScreen = false;
          emit(VendorProfileNotFullScreen());
        }
      },
    );
  }
  static VendorProfileCubit get(context) => BlocProvider.of(context);

  final ScrollControllerHandler scrollControllerHandler =
      ScrollControllerHandler(ScrollController());

  bool isFullScreen = false;
  void toggleFullScreen(bool fullScreen) {
    isFullScreen = fullScreen;
    emit(VendorProfileFullScreen());
  }

  /// get all notifications
  List<(String title, String content)> notifications = [];
  void getAllNotifications() async {
    emit(VendorProfileNotificationLoading());
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getAllNotifications,
        sendAuthToken: true,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        notifications = [];
        final data = response.data;
        notifications = (data['data'] as List).map<(String, String)>(
          (notification) {
            return (
              notification['title'],
              notification['content'],
            );
          },
        ).toList();

        print('list of notifications in all are ${notifications.length}');
        emit(VendorProfileNotificationSuccess());
      } else {
        emit(VendorProfileNotificationError('server error'));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(VendorProfileNotificationError(e.toString()));
      rethrow;
    }
  }

  void notificationsCount() async {
    emit(VendorProfileNotificationLoading());
    try {
      await DioHelper.getData(
              url: EndPoints.getAllNotifications, sendAuthToken: true)
          .then((response) {
        if (response.statusCode == 200) {
          print('response of notification data ${response.data}');
          List<dynamic> listOfNotifications = response.data['data'];
          print('list of notifications are ${listOfNotifications.length}');
          emit(VendorProfileNotificationSuccess(
              count: listOfNotifications.length));
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  /// get all orders
  void getAllOrders() async {
    emit(VendorProfileAllOrdersLoading());
    await Future.wait([
      getAcceptedOrders(),
      getRejectedOrders(),
      getPendingOrders(),
    ]);
    emit(VendorProfileAllOrdersSuccess());
  }

  void ordersCount() async {
    emit(VendorProfileAllOrdersLoading());
    await Future.wait([
      getAcceptedOrders(),
      getRejectedOrders(),
      getPendingOrders(),
    ]);

    List<dynamic> listOfOrders = [];
    listOfOrders.addAll(allAcceptedOrders);
    listOfOrders.addAll(allRejectedOrders);
    listOfOrders.addAll(allpendingOrders);
    emit(VendorProfileAllOrdersSuccess(count: listOfOrders.length));
  }

  /// get all accepted orders
  List<Orders> allAcceptedOrders = [];
  Future getAcceptedOrders() async {
    // emit(VendorProfileAcceptedOrdersLoading());

    try {
      final response = await DioHelper.getData(
        url: EndPoints.getMyAcceptedOrder,
        sendAuthToken: true,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        allAcceptedOrders = [];
        allAcceptedOrders = (response.data['orders'] as List).map<Orders>(
          (order) {
            return Orders.fromJson(order);
          },
        ).toList();
        log(allAcceptedOrders.toString());

        // emit(VendorProfileAcceptedOrdersSuccess());
      } else {
        emit(VendorProfileAcceptedOrdersError('server error'));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(VendorProfileAcceptedOrdersError(e.toString()));
      rethrow;
    }
  }

  // get all rejected orders
  List<Orders> allRejectedOrders = [];
  Future getRejectedOrders() async {
    // emit(VendorProfileRejectedOrdersLoading());
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getMyRejectedOrder,
        sendAuthToken: true,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        allRejectedOrders = [];
        allRejectedOrders = (response.data['orders'] as List).map<Orders>(
          (order) {
            return Orders.fromJson(order);
          },
        ).toList();
        // emit(VendorProfileRejectedOrdersSuccess());
      } else {
        emit(VendorProfileRejectedOrdersError('server error'));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(VendorProfileRejectedOrdersError(e.toString()));
      rethrow;
    }
  }

  // get all pending orders
  List<Orders> allpendingOrders = [];
  Future getPendingOrders() async {
    // emit(VendorProfilePendingOrdersLoading());
    try {
      final response = await DioHelper.getData(
        url: EndPoints.getMyPendingOrder,
        sendAuthToken: true,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        allpendingOrders = [];
        allpendingOrders = (response.data['orders'] as List).map<Orders>(
          (order) {
            return Orders.fromJson(order);
          },
        ).toList();
        // emit(VendorProfilePendingOrdersSuccess());
        // print("********************************************************************");
        // print(response.data);
        // print(allpendingOrders[0].orderItems!.length);
        // print("********************************************************************");
      } else {
        emit(VendorProfilePendingOrdersError('server error'));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(VendorProfilePendingOrdersError(e.toString()));
      rethrow;
    }
  }

  /// get all settings
  /// get all requests
}
