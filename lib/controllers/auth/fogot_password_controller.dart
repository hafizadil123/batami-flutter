import 'package:batami/api/dio_singleton.dart';
import 'package:batami/model/result_message_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();

  void callForgotPassword(String username, String contactInfo) async {
    isLoading.value = true;

    Map<String, dynamic> params = {};

    params["username"] = username;
    params["contanctInfo"] = contactInfo;

    DioSingleton().getAuthService().forgotPassword(params).then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        ResultMessageResponse resultMessageResponse =
            ResultMessageResponse.fromJson(res.data);

        if (resultMessageResponse.result ?? false) {
          Get.defaultDialog(
                  title: "הַצלָחָה",
                  middleText: "התאושש בהצלחה")
              .then((value) {
            Get.offAllNamed('/login');
          });
        } else {
          Get.defaultDialog(
              title: "עֵרָנִי", middleText: "${resultMessageResponse.message}");
        }
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
