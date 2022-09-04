import 'package:batami/firebase_options.dart';
import 'package:batami/helpers/constants.dart';
import 'package:batami/helpers/routes.dart';
import 'package:batami/helpers/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      // home: GetStorage().read(PREF_AUTH_KEY) != null
      //     ? DailyAttendanceScreen()
      //     : LoginScreen(),
      // initialBinding: GetStorage().read(PREF_AUTH_KEY) != null
      //     ? DailyAttendanceBinding()
      //     : LoginBinding(),


      initialRoute: GetStorage().read(PREF_AUTH_KEY) != null ? getLoggedInUser().userType!.toLowerCase().contains('volunteer') ?
      '/daily_attendance': '/save_document' : '/login',
      getPages: routes,

      debugShowCheckedModeBanner: false,
    );
  }
}
