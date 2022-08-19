import 'package:batami/controllers/auth/login_controller.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

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
                // "lib/assets/images/batami_logo.png",
                "lib/assets/logo/batami_logo_android.png",
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
                                title: "", middleText: "שם משתמש לא יכול להיות ריק");
                            return;
                          } else if (controller.passwordController.text
                              .trim()
                              .isEmpty) {
                            Get.defaultDialog(
                                title: "", middleText: "הסיסמה לא יכולה להיות ריקה");
                            return;
                          } else {
                            controller.loginUser(
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
                      onTap: () {
                        Get.toNamed('/forgot_password');
                      },
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
