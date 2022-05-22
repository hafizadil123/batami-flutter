import 'dart:io';

import 'package:batami/api/dio_singleton.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:batami/model/result_message_response.dart';
import 'package:batami/ui/home_screen.dart';
import 'package:batami/ui/nav_screens/daily_attendance_screen.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

class SaveDocumentController extends GetxController {
  var isLoading = false.obs;
  TextEditingController descriptionController = TextEditingController();
  File? toUploadFile;
  DocumentTypes? selectedDocumentType;

  void _saveDocument(File fileToUpload, String description) async {
    isLoading.value = true;

    dio.FormData data = dio.FormData.fromMap({
      "description": description,
      "DocumentTypeCode": selectedDocumentType!.id,
      "file": await dio.MultipartFile.fromFile(
        fileToUpload.path,
        filename: fileToUpload.path.split('/').last,
      ),
    });

    DioSingleton().getDocumentService().saveDocument(data).then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        ResultMessageResponse resultMessageResponse =
            ResultMessageResponse.fromJson(res.data);

        Get.defaultDialog(
                title: (resultMessageResponse.result ?? false)
                    ? "הַצלָחָה"
                    : "שְׁגִיאָה",
                middleText: resultMessageResponse.message ?? "")
            .then(
                (value) => Get.off(() => DailyAttendanceScreen(), binding: DailyAttendanceBinding()));
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }
}

class SaveDocumentScreen extends GetView<SaveDocumentController> {
  const SaveDocumentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerNavigation(),
        appBar: AppBar(
          backgroundColor: CustomColors.colorMain,
          elevation: 0.0,
          title: Text("לשמור מסמך"),
          titleTextStyle: TextStyle(fontSize: 15.0),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? getLoadingBar()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildDocumentTypeDropdown(),
                      TextFormField(
                        controller: controller.descriptionController,
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        cursorColor: CustomColors.colorSecondary,
                        style: const TextStyle(
                            color: CustomColors.colorSecondary,
                            letterSpacing: 1.5),
                        decoration: const InputDecoration(
                          hintText: "תיאור",
                          contentPadding: EdgeInsets.all(10.0),
                          focusColor: CustomColors.colorSecondary,
                          hintStyle:
                              TextStyle(color: CustomColors.colorSecondary),
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
                      ElevatedButton(
                          onPressed: () {
                            if (controller.descriptionController.text
                                .trim()
                                .isEmpty) {
                              Get.defaultDialog(
                                  title: "עֵרָנִי", middleText: "נדרש תיאור");
                              return;
                            } else if (controller.selectedDocumentType ==
                                null) {
                              Get.defaultDialog(
                                  title: "עֵרָנִי", middleText: "נא להזין את סוג המסמך");
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
                            } else {
                              controller._saveDocument(
                                controller.toUploadFile!,
                                controller.descriptionController.text.trim(),
                              );
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
        ));
  }

  Widget _buildDocumentTypeDropdown() {
    // סוג מסמך
    return DropdownButtonFormField(
      hint: controller.selectedDocumentType == null
          ? Text("סוג מסמך")
          : Text(
              controller.selectedDocumentType!.name,
              style: TextStyle(color: Colors.blue),
            ),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.blue),
      items: getAppData().documentTypes.map(
        (val) {
          return DropdownMenuItem<DocumentTypes>(
            value: val,
            child: Text(val.name),
          );
        },
      ).toList(),
      onChanged: (DocumentTypes? val) {
        controller.selectedDocumentType = val;
      },
    );
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

class SaveDocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.replace(SaveDocumentController());
  }
}
