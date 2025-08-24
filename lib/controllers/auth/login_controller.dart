import 'dart:convert';

import 'package:batami/api/dio_singleton.dart';
import 'package:batami/helpers/constants.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/auth/loggedin_user_response.dart';
import 'package:batami/model/auth/login_response.dart';
import 'package:batami/model/error_response.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginUser(String username, String password) async {
    isLoading.value = true;

    Map<String, dynamic> params = {};

    // params["username"] = username + "^13";
    params["username"] = username + "^15";
    params["password"] = password;
    params["grant_type"] = "password";

    DioSingleton().getAuthService().login(params).then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        LoginResponse loginResponse = LoginResponse.fromJson(res.data);

        GetStorage()
            .write(PREF_AUTH_KEY, loginResponse.accessToken)
            .then((value) {
          _getLoggedInUser();
        });
      }
    }).catchError((error) {
      // print(error.response.data["errorDescription"] ?? "");
      print(error);

      ErrorResponse errorResponse = ErrorResponse.fromJson(error.response.data);

      print("${errorResponse.errorDescription ?? ""}");
      Get.defaultDialog(
          title: "",
          middleText: "${errorResponse.errorDescription ?? ""}");
      isLoading.value = false;
    });
  }

  void _getLoggedInUser() async {
    isLoading.value = true;

    DioSingleton().getAuthService().getLoggedInUser().then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        LoggedInUser loggedInUser = LoggedInUser.fromJson(res.data);

        GetStorage()
            .write(PREF_LOGGED_IN_USER, jsonEncode(loggedInUser.toJson()))
            .then((value) {
          _getAppData();
        });
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void _getAppData() async {
    isLoading.value = true;

    DioSingleton().getGlobalService().getData().then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        GetData getData = GetData.fromJson(res.data);

        GetStorage()
            .write(PREF_APP_DATA, jsonEncode(getData.toJson()))
            .then((value) {
          Get.defaultDialog(title: "הַצלָחָה", middleText: "מְחוּבָּר");
          Get.offAllNamed(
              getLoggedInUser().userType!.toLowerCase().contains('volunteer')
                  ? '/daily_attendance'
                  : '/save_document');
        });
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  @override
  void onInit() {
    // usernameController.text = "549105118";
    // passwordController.text = "82c389";
    super.onInit();
  }
}
