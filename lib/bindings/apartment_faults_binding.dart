import 'package:batami/controllers/apartment_faults_controller.dart';
import 'package:get/get.dart';

class ApartmentFaultsBinding implements Bindings {
  @override
  void dependencies() {
    Get.replace(ApartmentFaultsController());
  }
}
