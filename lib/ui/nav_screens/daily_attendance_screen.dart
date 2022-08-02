import 'package:batami/controllers/daily_attendance_controller.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/attendance/attendance_daily_response.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:batami/widgets/single_select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailyAttendanceScreen extends GetView<DailyAttendanceController> {
  const DailyAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getAttendanceDaily();

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
                      _buildAttendanceSection(),
                      _buildAbsenceSection(),
                      _buildSickDaySection(),
                    ],
                  ),
                ),
        ));
  }

  Widget _buildAttendanceSection() {
    return Card(
      elevation: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: RadioListTile(
              value: "נוכחות",
              groupValue: controller.selectedActionType.value,
              onChanged: (val) {
                controller.selectedActionType.value = val as String;
              },
              title: Text("נוכחות"),
              contentPadding: EdgeInsets.all(0),
            ),
          ),
          controller.selectedActionType.value == "נוכחות"
              ? Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildWorkActivityDropdown(),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStartBtn(actionType: "attendance"),
                          _buildEndBtn(actionType: "attendance"),
                        ],
                      ),
                      SizedBox(height: 10.0,),
                    ],
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildAbsenceSection() {
    return Card(
      elevation: 10.0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: RadioListTile(
              value: "היעדרות",
              groupValue: controller.selectedActionType.value,
              selected: controller.selectedActionType.value == "היעדרות",
              onChanged: (val) {
                controller.selectedActionType.value = val as String;
              },
              title: Text("היעדרות"),
              contentPadding: EdgeInsets.all(0),
            ),
          ),
          controller.selectedActionType.value == "היעדרות"
              ? Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildAbsenceTypeDropdown(),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStartBtn(actionType: "absence"),
                          _buildEndBtn(actionType: "absence"),
                          _buildAllDayBtn(actionType: "absence"),
                        ],
                      ),
                      SizedBox(height: 10.0,),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildSickDaySection() {
    return Card(
      elevation: 10.0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: RadioListTile(
              value: "מחלה",
              groupValue: controller.selectedActionType.value,
              toggleable: true,
              selected: controller.selectedActionType.value == "מחלה",
              onChanged: (val) {
                controller.selectedActionType.value = val as String;
              },
              title: Text("מחלה"),
              contentPadding: EdgeInsets.all(0),
            ),
          ),
          controller.selectedActionType.value == "מחלה"
              ? Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStartBtn(actionType: "sickness"),
                          _buildEndBtn(actionType: "sickness"),
                          _buildAllDayBtn(actionType: "sickness"),
                        ],
                      ),
                      SizedBox(height: 10.0,),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildStartBtn({String? actionType}) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(EdgeInsets.all(10.0))),
      onPressed: (actionType == "attendance" &&
                  (controller.attendanceDaily.value.allowAttendanceStart ??
                      false)) ||
              (actionType == "absence" &&
                  (controller.attendanceDaily.value.allowAbsenceStart ??
                      false)) ||
              (actionType == "sickness" &&
                  (controller.attendanceDaily.value.allowSickStart ?? false))
          ? () {
              controller.saveStartShift(actionType: actionType);
            }
          : null,
      child: Text(
        controller.attendanceDaily.value.latestStartTime == null
            ? "כניסה"
            : controller.attendanceDaily.value.latestStartTime ?? "",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _buildEndBtn({String? actionType}) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(EdgeInsets.all(10.0))),
      onPressed: (actionType == "attendance" &&
                  (controller.attendanceDaily.value.allowAttendanceEnd ??
                      false)) ||
              (actionType == "absence" &&
                  (controller.attendanceDaily.value.allowAbsenceEnd ??
                      false)) ||
              (actionType == "sickness" &&
                  (controller.attendanceDaily.value.allowSickEnd ?? false))
          ? () {
              controller.saveEndShift();
            }
          : null,
      child: Text(
        "יציאה",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _buildAllDayBtn({String? actionType}) {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(EdgeInsets.all(10.0))),
      onPressed: (actionType == "absence" &&
                  (controller.attendanceDaily.value.allowAbsenceAllDay ??
                      false)) ||
              (actionType == "sickness" &&
                  (controller.attendanceDaily.value.allowSickAllDay ?? false))
          ? () {
              controller.saveFullDay(actionType: actionType);
            }
          : null,
      child: Text(
        "כל היום",
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  Widget _buildWorkActivityDropdown() {
    return DropdownButtonFormField(
      hint: Text(controller.selectedWorkActivity.value.name ?? "שדה פעילות"),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: CustomColors.colorSecondary),
      items: controller.attendanceDaily.value.workActivityItems!.map(
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
          borderSide: BorderSide(color: CustomColors.colorSecondary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.colorSecondary),
        ),
        focusColor: CustomColors.colorSecondary,
        hintStyle: TextStyle(color: CustomColors.colorSecondary),
      ),
    );
  }

  Widget _buildAbsenceTypeDropdown() {
    return DropdownButtonFormField(
      hint: Text(controller.selectedWorkActivity.value.name ?? "שדה פעילות"),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: CustomColors.colorSecondary),
      items: getAppData().absenceTypes.map(
        (val) {
          return DropdownMenuItem<AbsenceTypes>(
            value: val,
            child: Text(val.name!),
          );
        },
      ).toList(),
      onChanged: (AbsenceTypes? val) {
        controller.selectedAbsenceType.value = val!;
      },
      decoration: const InputDecoration(
        hintText: "סוג היעדרות",
        contentPadding: EdgeInsets.all(10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.colorSecondary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.colorSecondary),
        ),
        focusColor: CustomColors.colorSecondary,
        hintStyle: TextStyle(color: CustomColors.colorSecondary),
      ),
    );
  }
}
