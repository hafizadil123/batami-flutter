import 'package:batami/controllers/auth/fogot_password_controller.dart';
import 'package:batami/controllers/auth/login_controller.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
              alignment: Alignment.center,
              child: const Text(
                "לשחזר סיסמה",
                style: TextStyle(
                  fontSize: 36.0,
                  color: CustomColors.colorMain,
                  fontWeight: FontWeight.bold,
                ),
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
                      controller: controller.contactInfoController,
                      keyboardType: TextInputType.text,
                      cursorColor: CustomColors.colorSecondary,
                      style: const TextStyle(
                          color: CustomColors.colorSecondary,
                          letterSpacing: 1.5),
                      decoration: const InputDecoration(
                        hintText: "דואל / נייד",
                        contentPadding: EdgeInsets.all(10.0),
                        focusColor: CustomColors.colorSecondary,
                        hintStyle:
                            TextStyle(color: CustomColors.colorSecondary),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (controller.usernameController.text
                              .trim()
                              .isEmpty) {
                            Get.defaultDialog(
                                title: "",
                                middleText: "שם משתמש לא יכול להיות ריק");
                            return;
                          } else if (controller.contactInfoController.text
                              .trim()
                              .isEmpty) {
                            Get.defaultDialog(
                                title: "",
                                middleText:
                                    "לא ניתן להשאיר את פרטי הקשר ריקים");
                            return;
                          } else {
                            controller.callForgotPassword(
                                controller.usernameController.text.trim(),
                                controller.contactInfoController.text.trim());
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
