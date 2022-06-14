import 'package:batami/controllers/daily_attendance_controller.dart';
import 'package:get/get.dart';

class DailyAttendanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.replace(DailyAttendanceController());
  }
}