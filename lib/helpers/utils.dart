import 'dart:convert';

import 'package:batami/helpers/constants.dart';
import 'package:batami/model/auth/loggedin_user_response.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void handleResponseErrors(int statusCode) {
  switch (statusCode) {
    case 400:
      Get.snackbar("Error", "User does not exist, please retry");
      break;
    case 401:
      Get.snackbar("Error", "Session expired, please login again");
      // SharedPrefs prefs = SharedPrefs();
      // prefs.clearPrefs().then((value) => Get.offAll(() => SplashPage()));
      break;
    case 403:
      Get.snackbar("Error", "Access to this resource is forbidden");
      break;
    case 404:
      Get.snackbar("Error", "Resource not found, please retry");
      break;
    case 405:
      Get.snackbar("Error", "Method not allowed, please retry");
      break;
    case 408:
      Get.snackbar("Error", "An unexpected timeout occurred, please retry");
      break;
    case 409:
      Get.snackbar("Error", "A conflict occurred, please retry");
      break;
    case 415:
      Get.snackbar("Error", "Unsupported media type, please retry");
      break;
    case 500:
      Get.snackbar(
          "Error", "An internal error occured on the server, please retry");
      break;
    default:
      Get.snackbar("Error", "An unexpected error occurred");
      break;
  }
}

LoggedInUser getLoggedInUser(){
  return LoggedInUser.fromJson(jsonDecode(GetStorage().read(PREF_LOGGED_IN_USER)));
}

GetData getAppData(){
  return GetData.fromJson(jsonDecode(GetStorage().read(PREF_APP_DATA)));
}

Widget getLoadingBar() {
  return const SpinKitWave(
    color: Colors.blueAccent,
  );
}

logoutAndGoToLogin() {
  // GetStorage().erase().then((value) => Get.offAll(() => LoginScreen(), binding: LoginBinding()));
  GetStorage().erase().then((value) => Get.offAllNamed('/login'));
}

Widget textWithHeading(String? heading, String? text){
  return RichText(
    text: TextSpan(
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(text: "$heading: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: text),
      ],
    ),
  );
}