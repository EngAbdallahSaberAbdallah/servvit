import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:echo/core/enums/constants.dart';
import 'package:echo/core/services/local/cache_helper/cache_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/services/local/cache_helper/cache_helper.dart';
import 'core/services/remote/dio/dio_helper.dart';
import 'cubits/observer/bloc_observer.dart';
import 'root/app_root.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  //
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessageOpenedApp;

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('khaled');
      print(message.notification!.title);
      print('Message also contained a notification: khaled');
    }
  });
  await DioHelper.init();
  await CacheHelper.init();
  FirebaseMessaging.instance.subscribeToTopic('all');
  if (CacheHelper.getData(key: "deviceToken") == null) {
    await FirebaseMessaging.instance.getToken().then((value) {
      CacheHelper.saveData(key: "deviceToken", value: value);
      CacheHelper.saveData(key: "lang", value: "ar");
    });
  }
  print(CacheKeysManger.getUserTokenFromCache());
  print(CacheKeysManger.getLanguageFromCache());

  AppConstants.firstRunTime = true;
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  // for support arabic local formatting
  initializeDateFormatting(CacheKeysManger.getLanguageFromCache()).then((value) => runApp(const AppRoot()));
}
