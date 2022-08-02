
import 'package:batami/api/dio_singleton.dart';
import 'package:batami/model/attendance/attendance_daily_response.dart';
import 'package:batami/model/attendance/save_shift_response.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyAttendanceController extends GetxController {
  var isLoading = false.obs;
  Rx<AttendanceDailyResponse> attendanceDaily = AttendanceDailyResponse().obs;
  RxString responseMsg = "".obs;
  RxBool responseResult = false.obs;

  // var startBtnEnabled = true.obs;
  // var endBtnEnabled = true.obs;
  // var allDayBtnEnabled = true.obs;

  var selectedActionType = "נוכחות".obs;

  Rx<WorkActivityItem> selectedWorkActivity =
      WorkActivityItem(id: null, name: "שדה פעילות").obs;

  Rx<AbsenceTypes> selectedAbsenceType =
      AbsenceTypes(id: null, name: "סוג היעדרות").obs;

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

        // if (attendanceDaily.value.latestStartTime != null) {
        //   startBtnEnabled.value = false;
        // }
        //
        // if (attendanceDaily.value.latestEndTime != null) {
        //   endBtnEnabled.value = false;
        // }
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void saveStartShift({String? actionType}) async {
    isLoading.value = true;

    Map<String, dynamic> map = {};

    var response;

    switch(actionType){
      case "attendance":
        map["workActivityCode"] = selectedWorkActivity.value.id;
        response = await DioSingleton().getAttendanceService().saveAttendanceEntrance(map);
        break;
      case "absence":
        map["absenceCode"] = selectedAbsenceType.value.id;
        response = await DioSingleton().getAttendanceService().saveAbsenceEntrance(map);
        break;
      case "sickness":
        response = await DioSingleton().getAttendanceService().saveSickEntrance(map);
        break;
      default:
        response = null;
        break;
    }




    // DioSingleton().getAttendanceService().saveStartShift(map).then((res) {
      isLoading.value = false;

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        debugPrint(response);

        SaveShiftResponse saveShiftResponse =
        SaveShiftResponse.fromJson(response.data);

        responseResult.value = saveShiftResponse.result ?? false;
        responseMsg.value = saveShiftResponse.message ?? "";

        if (responseResult.value) {
          attendanceDaily.value.latestStartTime = saveShiftResponse.time;
        }
      }
    // }).catchError((error) {
    //   print(error);
    //   isLoading.value = false;
    // });
  }

  void saveEndShift() async {
    isLoading.value = true;

    DioSingleton().getAttendanceService().saveAnyExit().then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        SaveShiftResponse saveShiftResponse =
        SaveShiftResponse.fromJson(res.data);

        responseResult.value = saveShiftResponse.result ?? false;
        responseMsg.value = saveShiftResponse.message ?? "";

        if (responseResult.value) {
          attendanceDaily.value.latestEndTime = saveShiftResponse.time;
        }
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void saveFullDay({String? actionType}) async {
    isLoading.value = true;

    Map<String, dynamic> map = {};

    var response;

    switch(actionType){
      case "absence":
        map["absenceCode"] = selectedAbsenceType.value.id;
        response = await DioSingleton().getAttendanceService().saveFullAbsenceDay(map);
        break;
      case "sickness":
        response = await DioSingleton().getAttendanceService().saveFullSickDay(map);
        break;
      default:
        response = null;
        break;
    }

      isLoading.value = false;

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print(response);

        SaveShiftResponse saveShiftResponse =
        SaveShiftResponse.fromJson(response.data);

        responseResult.value = saveShiftResponse.result ?? false;
        responseMsg.value = saveShiftResponse.message ?? "";

        if (responseResult.value) {
          attendanceDaily.value.latestEndTime = saveShiftResponse.time;
        }
      }
  }
}