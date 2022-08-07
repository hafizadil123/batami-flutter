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
              : DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TabBar(
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.white,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              decoration: TextDecoration.underline),
                          // unselectedLabelStyle: TextStyle(fontSize: 16.0,
                          // ),
                          indicator: BoxDecoration(
                            border: Border.all(color: CustomColors.colorMain),
                            color: CustomColors.colorMain.withAlpha(150),
                          ),
                          tabs: [
                            Tab(text: "נוכחות"),
                            Tab(
                              text: "היעדרות",
                            ),
                            Tab(
                              text: "מחלה",
                            ),
                          ]),
                      SizedBox(
                        height: 20.0,
                      ),
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
                      Expanded(
                        flex: 1,
                        child: TabBarView(
                          viewportFraction: 0.95,
                          children: [
                            _buildTabViewSection("attendance"),
                            _buildTabViewSection("absence"),
                            _buildTabViewSection("sickness"),
                            // _buildAttendanceSection(),
                            // _buildAbsenceSection(),
                            // _buildSickDaySection(),
                          ],
                        ),
                      ),
                      (controller.attendanceDaily.value.existingData ?? []).isNotEmpty
                          ? Expanded(
                              flex: 2,
                              child: _buildActivitiesTable(controller
                                      .attendanceDaily.value.existingData ??
                                  []))
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
        ));
  }

  Widget _buildTabViewSection(String actionType) {
    return Card(
      elevation: 10.0,
      child: ListView(
        shrinkWrap: true,
        children: [
          actionType == "attendance"
              ? _buildWorkActivityDropdown()
              : actionType == "absence"
                  ? _buildAbsenceTypeDropdown()
                  : SizedBox.shrink(),
          SizedBox(
            height: 10.0,
          ),
          actionType == "attendance" &&
                  (controller.selectedWorkActivity.value.demandNote ?? false)
              ? TextFormField(
                  controller: controller.notesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 50,
                  cursorColor: CustomColors.colorSecondary,
                  style: const TextStyle(
                      color: CustomColors.colorSecondary, letterSpacing: 1.5),
                  decoration: const InputDecoration(
                    hintText: "הערות",
                    contentPadding: EdgeInsets.all(10.0),
                    focusColor: CustomColors.colorSecondary,
                    hintStyle: TextStyle(color: CustomColors.colorSecondary),
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(
            height: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildStartBtn(actionType: "attendance"),
              // _buildEndBtn(actionType: "attendance"),

              _buildStartBtn(actionType: actionType),
              _buildEndBtn(actionType: actionType),
              actionType == "absence" || actionType == "sickness"
                  ? _buildAllDayBtn(actionType: actionType)
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget _buildStartBtn({String? actionType}) {
    String textToDisplay = "";

    switch (actionType){
      case "attendance":
        textToDisplay = "כניסה";
        break;
      case "absence":
        textToDisplay = "היעדרות לכמה שעות וחוזר לנוכחות היום";
        break;
      case "sickness":
        textToDisplay = "היעדרות לכמה שעות וחוזר לנוכחות היום";
        break;
      default:
        textToDisplay = "";
        break;
    }


    return Container(
      width: 150,
      padding: EdgeInsets.all(20.0),
      child: ElevatedButton(
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
              ? textToDisplay
              : controller.attendanceDaily.value.latestStartTime ?? "",
          style: TextStyle(fontSize: 20.0,),
        ),
      ),
    );
  }

  Widget _buildEndBtn({String? actionType}) {

    String textToDisplay = "";

    switch (actionType){
      case "attendance":
        textToDisplay = "יציאה";
        break;
      case "absence":
        textToDisplay = "יציאה";
        break;
      case "sickness":
        textToDisplay = "יציאה";
        break;
      default:
        textToDisplay = "";
        break;
    }


    return Container(
      width: 150,
      padding: EdgeInsets.all(20.0),
      child: ElevatedButton(
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
          textToDisplay,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  Widget _buildAllDayBtn({String? actionType}) {

    String textToDisplay = "";

    switch (actionType){
      case "absence":
        textToDisplay = "היעדרות ללא חזרה היום לנוכחות";
        break;
      case "sickness":
        textToDisplay = "היעדרות ללא חזרה היום לנוכחות";
        break;
      default:
        textToDisplay = "";
        break;
    }


    return Container(
      width: 150,
      padding: EdgeInsets.all(20.0),
      child: ElevatedButton(
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
          textToDisplay,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  Widget _buildWorkActivityDropdown() {
    return DropdownButtonFormField(
            hint: Text(
                controller.selectedWorkActivity.value.name ?? "שדה פעילות"),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: CustomColors.colorSecondary),
            items: controller.attendanceDaily.value.workActivityItems?.map(
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

  Widget _buildActivitiesTable(List<ExistingData> existingDataList) {
    // List<DataRow> rows = [TableRow(
    //   children: [
    //     Text("פעילות", style: TextStyle(fontWeight: FontWeight.bold),),
    //     Text("שעת התחלה", style: TextStyle(fontWeight: FontWeight.bold),),
    //     Text("שעת סיום", style: TextStyle(fontWeight: FontWeight.bold),),
    //     Text("סוג היעדרות", style: TextStyle(fontWeight: FontWeight.bold),),
    //   ]
    // )];
    List<DataRow> rows = [];
    for (int i = 0; i < existingDataList.length; ++i) {
      rows.add(DataRow(cells: [
        DataCell(Text("${existingDataList[i].activity}")),
        DataCell(Text("${existingDataList[i].startTime}")),
        DataCell(Text("${existingDataList[i].endTime}")),
        DataCell(Text("${existingDataList[i].absenceName}")),
        DataCell(Text("${existingDataList[i].note ?? ""}")),
      ]));
    }
    return FittedBox(
      // scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          rows: rows,
          columns: [
            DataColumn(
              label: Text(
                "פעילות",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "שעת התחלה",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "שעת סיום",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "סוג היעדרות",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "הערה",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
