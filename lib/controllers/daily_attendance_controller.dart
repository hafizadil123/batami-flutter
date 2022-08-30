import 'package:batami/api/dio_singleton.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/attendance/attendance_daily_response.dart';
import 'package:batami/model/attendance/save_shift_response.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyAttendanceController extends GetxController {
  var isLoading = false.obs;
  Rx<AttendanceDailyResponse> attendanceDaily = AttendanceDailyResponse().obs;
  RxString responseMsg = "".obs;
  RxBool responseResult = false.obs;

  Rx<WorkActivityItem> selectedWorkActivity =
      WorkActivityItem(id: null, name: "שדה פעילות").obs;

  Rx<AbsenceTypes> selectedAbsenceType =
      AbsenceTypes(id: null, name: "סוג היעדרות").obs;

  TextEditingController notesController = TextEditingController();

  var selectedTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

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

        if(attendanceDaily.value.lockScreenInfo?.isLockScreen ?? false){
          Get.offNamed("/lock_screen", parameters: {"lockScreenText": attendanceDaily.value.lockScreenInfo!.lockScreenText!});
        }

        for (int i = 0;
            i < attendanceDaily.value.workActivityItems!.length;
            i++) {
          if (attendanceDaily.value.workActivityItems![i].id ==
              attendanceDaily.value.workActivityCode) {
            selectedWorkActivity.value =
                attendanceDaily.value.workActivityItems![i];
          }
        }

        if(attendanceDaily.value.workActivityCode != null){
            selectedWorkActivity.value = attendanceDaily
                .value.workActivityItems!
                .firstWhere((p) => p.id == attendanceDaily.value.workActivityCode,
                orElse: () => WorkActivityItem(id: null, name: "שדה פעילות"));
        }

        // if(attendanceDaily.value.rowType != null){
          switch(attendanceDaily.value.rowType){
            case "attendance":
              selectedTabIndex.value = 0;
              break;
            case "absence":
              selectedTabIndex.value = 1;
              break;
            case "sick":
              selectedTabIndex.value = 2;
              break;
            default:
              selectedTabIndex.value = 0;
              break;
          }
        // } else{
        //   selectedTabIndex.value = 0;
        // }

        responseResult.value = attendanceDaily.value.result ?? false;
        responseMsg.value = attendanceDaily.value.message ?? "";
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void saveStartShift({String? actionType}) async {
    isLoading.value = true;
    var response;

    Map<String, dynamic> map = {};


    switch (actionType) {
      case "attendance":
        if ((selectedWorkActivity.value.demandNote ?? false) &&
            notesController.text.trim().isEmpty) {
          Get.defaultDialog(title: "", middleText: "שדה הערות נדרש");
        } else {
          map["workActivityCode"] = selectedWorkActivity.value.id;
          map["workActivityNote"] = notesController.text.trim();

          print(map);

          response = await DioSingleton()
              .getAttendanceService()
              .saveAttendanceEntrance(map);
        }
        break;
      case "absence":
        map["absenceCode"] = selectedAbsenceType.value.id;
        map["workActivityNote"] = notesController.text.trim();
        response = await DioSingleton()
            .getAttendanceService()
            .saveAbsenceEntrance(map);
        break;
      case "sick":
        map["workActivityNote"] = notesController.text.trim();
        response =
            await DioSingleton().getAttendanceService().saveSickEntrance(map);
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

      if(saveShiftResponse.lockScreenInfo?.isLockScreen ?? false){
        Get.offNamed("/lock_screen", parameters: {"lockScreenText": saveShiftResponse.lockScreenInfo!.lockScreenText!});
      }

      responseResult.value = saveShiftResponse.result ?? false;
      responseMsg.value = saveShiftResponse.message ?? "";
      if (responseResult.value) {
        // DefaultTabController.of(context!)!.animateTo(selectedTabIndex.value);
        getAttendanceDaily();
      }
    }
  }

  void saveEndShift() async {
    isLoading.value = true;
    var response;

    Map<String, dynamic> map = {};

    response = await DioSingleton().getAttendanceService().saveAnyExit(map);

    isLoading.value = false;

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      print(response);

      SaveShiftResponse saveShiftResponse =
          SaveShiftResponse.fromJson(response.data);

      if(saveShiftResponse.lockScreenInfo?.isLockScreen ?? false){
        Get.offNamed("/lock_screen", parameters: {"lockScreenText": saveShiftResponse.lockScreenInfo!.lockScreenText!});
      }

      responseResult.value = saveShiftResponse.result ?? false;
      responseMsg.value = saveShiftResponse.message ?? "";

      if (responseResult.value) {
        getAttendanceDaily();
      }
    }
  }

  void saveFullDay({String? actionType}) async {
    isLoading.value = true;
    var response;
    Map<String, dynamic> map = {};

    switch (actionType) {
      case "absence":
        map["absenceCode"] = selectedAbsenceType.value.id;
        response =
            await DioSingleton().getAttendanceService().saveFullAbsenceDay(map);
        break;
      case "sick":
        response =
            await DioSingleton().getAttendanceService().saveFullSickDay(map);
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

      if(saveShiftResponse.lockScreenInfo?.isLockScreen ?? false){
        Get.offNamed("/lock_screen", parameters: {"lockScreenText": saveShiftResponse.lockScreenInfo!.lockScreenText!});
      }

      responseResult.value = saveShiftResponse.result ?? false;
      responseMsg.value = saveShiftResponse.message ?? "";

      if (responseResult.value) {
        getAttendanceDaily();
      }
    }
  }
}
