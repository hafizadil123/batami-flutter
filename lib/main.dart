import 'dart:developer';

import 'package:batami/firebase_options.dart';
import 'package:batami/helpers/constants.dart';
import 'package:batami/helpers/routes.dart';
import 'package:batami/helpers/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const AndroidInitializationSettings androidInit =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings =
  InitializationSettings(android: androidInit);
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  await FirebaseMessaging.instance.requestPermission(provisional: true);

  // final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  // if (apnsToken != null) {
  //  // APNS token is available, make FCM plugin API requests...
  // }


FirebaseMessaging.instance.onTokenRefresh
    .listen((fcmToken) async {
       await GetStorage().write(PREF_DEVICE_TOKEN, fcmToken);
    })
    .onError((err) {
      // Error getting token.
    });


  log("DeviceToken: ${await FirebaseMessaging.instance.getToken()}");

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  try {
    runApp(MyApp());
  } catch(e) {
    log("Error during init: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel',
              'General Notifications',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
        );
      }
    });




    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("he", "IL"),
      ],
      locale: const Locale("he", "IL"),
      initialRoute: GetStorage().read(PREF_AUTH_KEY) != null ? getLoggedInUser().userType!.toLowerCase().contains('volunteer') ?
      '/daily_attendance': '/save_document' : '/login',
      getPages: routes,
      routingCallback: (routing){
        if(routing?.current == "/card_image"){
          NoScreenshot.instance.screenshotOff();
        } else {
          NoScreenshot.instance.screenshotOn();
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
