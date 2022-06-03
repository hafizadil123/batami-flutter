import 'package:batami/api/dio_singleton.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/attendance/attendance_daily_response.dart';
import 'package:batami/model/attendance/save_shift_response.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyAttendanceController extends GetxController {
  var isLoading = false.obs;
  Rx<AttendanceDailyResponse> attendanceDaily = AttendanceDailyResponse().obs;
  RxString responseMsg = "".obs;
  RxBool responseResult = false.obs;
  var startBtnEnabled = true.obs;
  var endBtnEnabled = true.obs;

  Rx<WorkActivityItem> selectedWorkActivity =
      WorkActivityItem(id: null, name: "שדה פעילות").obs;

  void _getAttendanceDaily() async {
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

  void _saveStartShift() async {
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

  void _saveEndShift() async {
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

        // _getAttendanceDaily();
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }
}

class DailyAttendanceScreen extends GetView<DailyAttendanceController> {
  const DailyAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller._getAttendanceDaily();

    debugPrint("שלום ${getLoggedInUser().firstName}");

    return Scaffold(
        drawer: DrawerNavigation(),
        appBar: AppBar(
          backgroundColor: CustomColors.colorMain,
          //שלום {0}
          title: Text("נוכחות יומית"),
          titleTextStyle: TextStyle(fontSize: 15.0),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? getLoadingBar()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "שלום ${getLoggedInUser().firstName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            decoration: TextDecoration.underline),
                      ),
                      Text(
                        "נוכחות יומית ${controller.attendanceDaily.value.currentDate}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            decoration: TextDecoration.underline),
                      ),
                      controller.responseMsg.value != null &&
                              controller.responseMsg.value.isNotEmpty
                          ? Text(
                              "${controller.responseMsg.value}",
                              style: !controller.responseResult.value
                                  ? TextStyle(
                                      backgroundColor: Colors.yellow,
                                      color: Colors.red)
                                  : TextStyle(
                                      backgroundColor: Colors.green,
                                      color: Colors.white),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 20.0,
                      ),
                      (controller.attendanceDaily.value.displayWorkActivity ??
                              false)
                          ? DropdownButtonFormField(
                              hint: Text(
                                  controller.selectedWorkActivity.value.name ??
                                      "שדה פעילות"),
                              isExpanded: true,
                              iconSize: 30.0,
                              style:
                                  TextStyle(color: CustomColors.colorSecondary),
                              items: controller
                                  .attendanceDaily.value.workActivityItems!
                                  .map(
                                (val) {
                                  return DropdownMenuItem<WorkActivityItem>(
                                    value: val,
                                    child: Text(val.name!),
                                  );
                                },
                              ).toList(),
                              onChanged: (WorkActivityItem? val) {
                                controller.selectedWorkActivity.value = val!;
                              },
                              decoration: const InputDecoration(
                                hintText: "תיאור",
                                contentPadding: EdgeInsets.all(10.0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomColors.colorSecondary),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CustomColors.colorSecondary),
                                ),
                                focusColor: CustomColors.colorSecondary,
                                hintStyle: TextStyle(
                                    color: CustomColors.colorSecondary),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5.0),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10.0))),
                            onPressed: controller.startBtnEnabled.value &&
                                    (!(controller.attendanceDaily.value
                                            .displayWorkActivity ??
                                        false) ||
                                            controller.selectedWorkActivity
                                                    .value.id !=
                                                null)

                            // onPressed: (!(controller.attendanceDaily.value.displayWorkActivity ?? false)
                            //     && controller.startBtnEnabled.value) ||

                                ? () => controller._saveStartShift()
                                : null,
                            child: Text(
                              controller.startBtnEnabled.value
                                  ? "כניסה"
                                  : "${controller.attendanceDaily.value.latestStartTime ?? ""}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5.0),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(10.0))),
                            onPressed: controller.endBtnEnabled.value  &&
                                (!(controller.attendanceDaily.value
                                    .displayWorkActivity ??
                                    false) ||
                                    controller.selectedWorkActivity
                                        .value.id !=
                                        null)

                            // onPressed: (!(controller.attendanceDaily.value.displayWorkActivity ?? false)
                            //             && controller.endBtnEnabled.value)
                                ? () => controller._saveEndShift()
                                : null,
                            child: Text(
                              controller.endBtnEnabled.value
                                  ? "יציאה"
                                  : "${controller.attendanceDaily.value.latestEndTime ?? ""}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ));
  }
}

class DailyAttendanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.replace(DailyAttendanceController());
  }
}
