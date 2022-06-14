import 'package:batami/controllers/apartment_faults/add_apartment_fault_controller.dart';
import 'package:get/get.dart';

class AddApartmentFaultBinding implements Bindings {
  @override
  void dependencies() {
    Get.replace(AddApartmentFaultController());
  }
}
