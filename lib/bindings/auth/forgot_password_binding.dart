import 'package:batami/controllers/auth/fogot_password_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.replace(ForgotPasswordController());
  }
}
