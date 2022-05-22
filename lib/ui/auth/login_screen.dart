import 'dart:convert';

import 'package:batami/api/dio_singleton.dart';
import 'package:batami/helpers/constants.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/auth/loggedin_user_response.dart';
import 'package:batami/model/auth/login_response.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:batami/ui/home_screen.dart';
import 'package:batami/ui/nav_screens/daily_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _loginUser(String username, String password) async {
    isLoading.value = true;

    Map<String, dynamic> params = {};

    params["username"] = username + "^13";
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
      print(error);
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
          Get.defaultDialog(title: "Success", middleText: "Logged In");
          Get.offAll(() => DailyAttendanceScreen(), binding: DailyAttendanceBinding());
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

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: Get.mediaQuery.size.height * 0.4,
              child: Image.asset(
                "lib/assets/images/batami_logo.png",
                fit: BoxFit.contain,
                width: Get.size.width * 0.4,
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Container(
              height: Get.mediaQuery.size.height * 0.4,
              child: Container(
                decoration: const BoxDecoration(
                    color: CustomColors.colorMain,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      controller: controller.usernameController,
                      keyboardType: TextInputType.number,
                      cursorColor: CustomColors.colorSecondary,
                      style: const TextStyle(
                          color: CustomColors.colorSecondary,
                          letterSpacing: 1.5),
                      decoration: const InputDecoration(
                        hintText: "תעודת זהות",
                        contentPadding: EdgeInsets.all(10.0),
                        focusColor: CustomColors.colorSecondary,
                        hintStyle:
                            TextStyle(color: CustomColors.colorSecondary),
                      ),
                    ),
                    TextFormField(
                      controller: controller.passwordController,
                      keyboardType: TextInputType.text,
                      cursorColor: CustomColors.colorSecondary,
                      style: const TextStyle(
                          color: CustomColors.colorSecondary,
                          letterSpacing: 1.5),
                      decoration: const InputDecoration(
                        hintText: "סיסמה",
                        contentPadding: EdgeInsets.all(10.0),
                        focusColor: CustomColors.colorSecondary,
                        hintStyle:
                            TextStyle(color: CustomColors.colorSecondary),
                      ),
                      obscureText: true,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (controller.usernameController.text
                              .trim()
                              .isEmpty) {
                            Get.defaultDialog(
                                title: "עֵרָנִי", middleText: "שם משתמש לא יכול להיות ריק");
                            return;
                          } else if (controller.passwordController.text
                              .trim()
                              .isEmpty) {
                            Get.defaultDialog(
                                title: "עֵרָנִי", middleText: "הסיסמה לא יכולה להיות ריקה");
                            return;
                          } else {
                            controller._loginUser(
                                controller.usernameController.text.trim(),
                                controller.passwordController.text.trim());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: CustomColors.colorSecondary,
                            fixedSize: const Size.fromWidth(250)),
                        child: const Text(
                          "כניסה",
                          style: TextStyle(
                            color: CustomColors.black,
                            fontSize: 20.0,
                          ),
                        )),
                    GestureDetector(
                      child: const Text(
                        "שכחתי סיסמה",
                        style: TextStyle(
                            color: CustomColors.colorSecondary,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            )
          ],
        ),
        Obx(() => controller.isLoading.value
            ? getLoadingBar()
            : const SizedBox.shrink()),
      ],
    ));
  }
}

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(() => LoginController());
    Get.replace(LoginController());
  }
}
