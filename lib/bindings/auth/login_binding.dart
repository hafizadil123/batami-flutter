
import 'package:batami/controllers/auth/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.replace(LoginController());
  }
}