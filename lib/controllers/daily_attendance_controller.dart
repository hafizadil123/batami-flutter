
import 'package:batami/api/dio_singleton.dart';
import 'package:batami/model/attendance/attendance_daily_response.dart';
import 'package:batami/model/attendance/save_shift_response.dart';
import 'package:get/get.dart';

class DailyAttendanceController extends GetxController {
  var isLoading = false.obs;
  Rx<AttendanceDailyResponse> attendanceDaily = AttendanceDailyResponse().obs;
  RxString responseMsg = "".obs;
  RxBool responseResult = false.obs;
  var startBtnEnabled = true.obs;
  var endBtnEnabled = true.obs;

  Rx<WorkActivityItem> selectedWorkActivity =
      WorkActivityItem(id: null, name: "שדה פעילות").obs;

  void getAttendanceDaily() async {
    isLoading.value = true;

    DioSingleton().getAttendanceService().getAttendanceDaily().then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        AttendanceDailyResponse attendanceDailyResponse =
        AttendanceDailyResponse.fromJson(res.data);

        attendanceDaily.value = attendanceDailyResponse;

        for (int i = 0;
        i < attendanceDaily.value.workActivityItems!.length;
        i++) {
          if (attendanceDaily.value.workActivityItems![i].id ==
              attendanceDaily.value.workActivityCode) {
            selectedWorkActivity.value =
            attendanceDaily.value.workActivityItems![i];
          }
        }

        responseResult.value = attendanceDaily.value.result ?? false;
        responseMsg.value = attendanceDaily.value.message ?? "";

        if (attendanceDaily.value.latestStartTime != null) {
          startBtnEnabled.value = false;
        }

        if (attendanceDaily.value.latestEndTime != null) {
          endBtnEnabled.value = false;
        }
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void saveStartShift() async {
    isLoading.value = true;

    Map<String, dynamic> map = {};
    map["workActivityCode"] = selectedWorkActivity.value.id;

    DioSingleton().getAttendanceService().saveStartShift(map).then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        SaveShiftResponse saveShiftResponse =
        SaveShiftResponse.fromJson(res.data);

        responseResult.value = saveShiftResponse.result ?? false;
        responseMsg.value = saveShiftResponse.message ?? "";

        startBtnEnabled.value = false;

        if (responseResult.value) {
          attendanceDaily.value.latestStartTime = saveShiftResponse.time;
        }
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void saveEndShift() async {
    isLoading.value = true;

    Map<String, dynamic> map = {};
    map["workActivityCode"] = selectedWorkActivity.value.id;

    DioSingleton().getAttendanceService().saveEndShift(map).then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        SaveShiftResponse saveShiftResponse =
        SaveShiftResponse.fromJson(res.data);

        responseResult.value = saveShiftResponse.result ?? false;
        responseMsg.value = saveShiftResponse.message ?? "";

        endBtnEnabled.value = false;

        if (responseResult.value) {
          attendanceDaily.value.latestEndTime = saveShiftResponse.time;
        }
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }
}