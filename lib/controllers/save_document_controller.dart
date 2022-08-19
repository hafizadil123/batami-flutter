import 'dart:io';

import 'package:batami/api/dio_singleton.dart';
import 'package:batami/bindings/daily_attendance_binding.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:batami/model/result_message_response.dart';
import 'package:batami/ui/nav_screens/daily_attendance_screen.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SaveDocumentController extends GetxController {
  var isLoading = false.obs;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bankBranchController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();

  File? toUploadFile;

  // Rx<DocumentTypes> selectedDocumentType =
  //     DocumentTypes(id: null, name: "סוג מסמך").obs;
  Rx<HmoTypes> selectedHmoType = HmoTypes(id: null, name: "קופת חולים").obs;
  Rx<Banks> selectedBank = Banks(id: null, name: "בנק").obs;

  Rx<DateTime> selectedStartDate = DateTime.now().obs;
  Rx<DateTime> selectedEndDate = DateTime.now().obs;
  Rx<DateTime> selectedMarriageDate = DateTime.now().obs;
  Rx<DateTime> selectedReportDate = DateTime.now().obs;

  Rx<DocumentCategoryTypes> selectedDocumentCategoryType =
      DocumentCategoryTypes(id: null, name: "קטגוריית מסמך", documentTypes: [])
          .obs;
  Rx<DocumentTypes> selectedDocumentType = DocumentTypes(
    id: null,
    name: "סוג מסמך",
  ).obs;
  TextEditingController documentCategoryTypeController =
      TextEditingController();
  TextEditingController documentTypeController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void saveDocument() async {
    isLoading.value = true;

    Map<String, dynamic> toSubmitMap = {};
    toSubmitMap["description"] = descriptionController.text.trim();
    toSubmitMap["DocumentTypeCode"] = selectedDocumentType.value.id;
    toSubmitMap["file"] = await dio.MultipartFile.fromFile(
      toUploadFile!.path,
      filename: toUploadFile!.path.split('/').last,
    );

    switch (selectedDocumentType.value.id) {
      case 24:
        toSubmitMap["AttendanceStartDate"] =
            DateFormat('dd/MM/yyyy').format(selectedStartDate.value);
        toSubmitMap["AttendanceEndDate"] =
            DateFormat('dd/MM/yyyy').format(selectedEndDate.value);
        toSubmitMap["hmoTypeCode"] = selectedHmoType.value.id;
        break;
      case 43:
        toSubmitMap["marriageDate"] =
            DateFormat('dd/MM/yyyy').format(selectedMarriageDate.value);
        break;
      case 5:
        toSubmitMap["bankCode"] = selectedBank.value.id;
        toSubmitMap["bankBranch"] = bankBranchController.text.trim();
        toSubmitMap["bankAccount"] = bankAccountController.text.trim();
        break;
      case 23:
      case 40:
        toSubmitMap["reportDate"] =
            DateFormat('MM/yyyy').format(selectedReportDate.value);
        break;
      default:
        break;
    }

    debugPrint(toSubmitMap.toString());

    DioSingleton()
        .getDocumentService()
        .saveDocument(dio.FormData.fromMap(toSubmitMap))
        .then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        ResultMessageResponse resultMessageResponse =
            ResultMessageResponse.fromJson(res.data);

        if(resultMessageResponse.lockScreenInfo?.isLockScreen ?? false){
          Get.offNamed("/lock_screen", parameters: {"lockScreenText": resultMessageResponse.lockScreenInfo!.lockScreenText!});
        }

        Get.defaultDialog(
                title: (resultMessageResponse.result ?? false)
                    ? "הַצלָחָה"
                    : "שְׁגִיאָה",
                middleText: resultMessageResponse.message ?? "")
            .then((value) {
          if (resultMessageResponse.result ?? false) {
            Get.toNamed(
                getLoggedInUser().userType!.toLowerCase().contains('volunteer')
                    ? '/daily_attendance'
                    : '/save_document');
          }
        });
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }
}
