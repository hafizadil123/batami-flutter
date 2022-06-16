import 'dart:io';

import 'package:batami/controllers/save_document_controller.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SaveDocumentScreen extends GetView<SaveDocumentController> {
  SaveDocumentScreen({Key? key}) : super(key: key);

  List<DropdownMenuItem<DocumentTypes>> documentTypesMenuItems = [
    DropdownMenuItem(
      child: Text("סוג מסמך"),
      value: DocumentTypes(id: null, name: "סוג מסמך"),
    ),
    ...getAppData().documentTypes.map(
      (val) {
        return DropdownMenuItem<DocumentTypes>(
          value: val,
          child: Text(val.name!),
        );
      },
    ).toList(),
  ];

  List<DropdownMenuItem<HmoTypes>> hmoTypesMenuItems = [
    DropdownMenuItem(
      child: Text("קופת חולים"),
      value: HmoTypes(id: null, name: "קופת חולים"),
    ),
    ...getAppData().hmoTypes.map(
      (val) {
        return DropdownMenuItem<HmoTypes>(
          value: val,
          child: Text(val.name!),
        );
      },
    ).toList(),
  ];

  List<DropdownMenuItem<Banks>> bankMenuItems = [
    DropdownMenuItem(
      child: Text("בנק"),
      value: Banks(id: null, name: "בנק"),
    ),
    ...getAppData().banks.map(
      (val) {
        return DropdownMenuItem<Banks>(
          value: val,
          child: Text(val.name!),
        );
      },
    ).toList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerNavigation(),
        appBar: AppBar(
          backgroundColor: CustomColors.colorMain,
          elevation: 0.0,
          title: Text("העלאת מסמכים"),
          titleTextStyle: TextStyle(fontSize: 15.0),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? getLoadingBar()
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DropdownButtonFormField(
                          hint:
                              Text(controller.selectedDocumentType.value.name!),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: CustomColors.colorSecondary),
                          items: documentTypesMenuItems,
                          onChanged: (DocumentTypes? val) {
                            controller.selectedDocumentType.value = val!;
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
                            hintStyle:
                                TextStyle(color: CustomColors.colorSecondary),
                          ),
                        ),
                        TextFormField(
                          controller: controller.descriptionController,
                          maxLength: 100,
                          keyboardType: TextInputType.text,
                          cursorColor: CustomColors.colorSecondary,
                          style: const TextStyle(letterSpacing: 1.5),
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
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("קישור למסמך"),
                            ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      title: "לשמור מסמך",
                                      middleText: "גלריה או מצלמה?",
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              pickFile();
                                            },
                                            child: Text("קבצים")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                              openCamera();
                                            },
                                            child: Text("מַצלֵמָה")),
                                      ]);
                                },
                                child: Text("בחר")),
                          ],
                        ),
                        Container(
                            height: 1,
                            width: Get.size.width,
                            color: CustomColors.colorSecondary),
                        _buildUIByDocumentType(
                            controller.selectedDocumentType.value.id),
                        ElevatedButton(
                            onPressed: () {
                              if (controller.descriptionController.text
                                  .trim()
                                  .isEmpty) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי", middleText: "נדרש תיאור");
                                return;
                              } else if (controller
                                      .selectedDocumentType.value.id ==
                                  null) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי",
                                    middleText: "נא להזין את סוג המסמך");
                                return;
                              } else if (controller.toUploadFile == null) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי", middleText: "נדרש קובץ");
                                return;
                              } else if (controller.toUploadFile!.lengthSync() >
                                  2000000) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי",
                                    middleText: "הקובץ צריך להיות פחות מ-2MB");
                                return;
                              } else if (controller
                                          .selectedDocumentType.value.id ==
                                      24 &&
                                  controller.selectedEndDate.value
                                          .millisecondsSinceEpoch <
                                      controller.selectedStartDate.value
                                          .millisecondsSinceEpoch) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי",
                                    middleText:
                                        "תאריך סיום קטן מתאריך התחלה, יש לתקן ולנסות שוב");
                              } else if (controller
                                          .selectedDocumentType.value.id ==
                                      24 &&
                                  controller.selectedHmoType.value.id == null) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי",
                                    middleText: "נא להזין את סוג hmo");
                              } else if (controller
                                          .selectedDocumentType.value.id ==
                                      5 &&
                                  controller.selectedBank.value.id == null) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי",
                                    middleText: "נא להיכנס לבנק");
                              } else if (controller
                                          .selectedDocumentType.value.id ==
                                      5 &&
                                  controller.bankBranchController.text
                                      .trim()
                                      .isEmpty) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי",
                                    middleText: "חובה סניף בנק");
                                return;
                              } else if (controller
                                          .selectedDocumentType.value.id ==
                                      5 &&
                                  controller.bankAccountController.text
                                      .trim()
                                      .isEmpty) {
                                Get.defaultDialog(
                                    title: "עֵרָנִי",
                                    middleText: "נדרש חשבון בנק");
                                return;
                              } else {
                                controller.saveDocument();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: CustomColors.colorSecondary,
                                fixedSize: const Size.fromWidth(250)),
                            child: const Text(
                              "שמור",
                              style: TextStyle(
                                color: CustomColors.black,
                                fontSize: 20.0,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
        ));
  }

  Widget _buildUIByDocumentType(int? documentTypeId) {
    switch (documentTypeId) {
      case 24:
        return ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Flexible(flex: 30, child: Text("תאריך התחלה: ")),
                Flexible(
                  flex: 70,
                  child: Container(
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        controller.selectedStartDate.value = newDateTime;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 1, width: 1, color: CustomColors.colorSecondary),
            Row(
              children: [
                Flexible(flex: 30, child: Text("תאריך סיום: ")),
                Flexible(
                  flex: 70,
                  child: Container(
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (DateTime newDateTime) {
                        controller.selectedEndDate.value = newDateTime;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 1, width: 1, color: CustomColors.colorSecondary),
            DropdownButtonFormField(
              hint: Text(controller.selectedHmoType.value.name ?? "קופת חולים"),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: CustomColors.colorSecondary),
              items: hmoTypesMenuItems,
              onChanged: (HmoTypes? val) {
                controller.selectedHmoType.value = val!;
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
            ),
          ],
        );
      case 43:
        return ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Flexible(flex: 30, child: Text("תאריך חתונה: ")),
                Flexible(
                  flex: 70,
                  child: Container(
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: controller.selectedMarriageDate.value,
                      onDateTimeChanged: (DateTime newDateTime) {
                        controller.selectedMarriageDate.value = newDateTime;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      case 5:
        return ListView(
          shrinkWrap: true,
          children: [
            DropdownButtonFormField(
              hint: Text(controller.selectedBank.value.name ?? "בנק"),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: CustomColors.colorSecondary),
              items: bankMenuItems,
              onChanged: (Banks? val) {
                controller.selectedBank.value = val!;
              },
              decoration: const InputDecoration(
                hintText: "בנק",
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
            ),
            TextFormField(
              controller: controller.bankBranchController,
              maxLength: 3,
              keyboardType: TextInputType.text,
              cursorColor: CustomColors.colorSecondary,
              style: const TextStyle(letterSpacing: 1.5),
              decoration: const InputDecoration(
                hintText: "סניף בנק",
                contentPadding: EdgeInsets.all(10.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.colorSecondary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.colorSecondary),
                ),
                focusColor: CustomColors.colorSecondary,
              ),
            ),
            TextFormField(
              controller: controller.bankAccountController,
              maxLength: 9,
              keyboardType: TextInputType.text,
              cursorColor: CustomColors.colorSecondary,
              style: const TextStyle(letterSpacing: 1.5),
              decoration: const InputDecoration(
                hintText: "חשבון בנק",
                contentPadding: EdgeInsets.all(10.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.colorSecondary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.colorSecondary),
                ),
                focusColor: CustomColors.colorSecondary,
              ),
            ),
          ],
        );
      case 23:
        return ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Flexible(flex: 30, child: Text("חודש נוכחות: ")),
                Flexible(
                  flex: 70,
                  child: SfDateRangePicker(
                    view: DateRangePickerView.year,
                    allowViewNavigation: false,
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      controller.selectedReportDate.value = args.value;
                      debugPrint("${args.value}");
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      default:
        return Container();
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      controller.toUploadFile = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  void openCamera() async {
    final XFile? photo = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 60);
    controller.toUploadFile = File(photo!.path);
  }
}
