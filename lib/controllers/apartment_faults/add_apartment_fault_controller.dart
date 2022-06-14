import 'dart:convert';

import 'package:batami/api/dio_singleton.dart';
import 'package:batami/model/apartment_fault/apartment_fault_details.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:batami/model/result_message_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AddApartmentFaultController extends GetxController {
  var isLoading = false.obs;

  // Rx<ApartmentFaultsResponse> apartmentFaults = ApartmentFaultsResponse().obs;

  Rx<ApartmentFaultCategoryTypes> selectedApartmentFaultCategoryType =
      ApartmentFaultCategoryTypes(id: null, name: "קטגוריית תקלה").obs;

  Rx<ApartmentFaultTypes> selectedApartmentFaultType = ApartmentFaultTypes(
          id: null, name: "סוג תקלה", categoryCode: null, isMustLocation: null)
      .obs;

  Rx<DateTime> selectedOccurrenceDate = DateTime.now().obs;
  Rx<DateTime> selectedHandleDate = DateTime.now().obs;
  RxBool isRecurring = false.obs;

  TextEditingController faultDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController handleDescriptionController = TextEditingController();
  TextEditingController creatorController = TextEditingController();
  TextEditingController handlerController = TextEditingController();

  ApartmentFaultDetails? apartmentFaultDetails;

  @override
  void onInit() {
    apartmentFaultDetails = Get.arguments[0];

    super.onInit();
  }

  void saveApartmentFault() async {
    isLoading.value = true;

    apartmentFaultDetails!.faultCategoryTypeCode =
        selectedApartmentFaultCategoryType.value.id;
    apartmentFaultDetails!.faultTypeCode = selectedApartmentFaultType.value.id;
    apartmentFaultDetails!.occurrenceDate =
        DateFormat('dd/MM/yyyy').format(selectedOccurrenceDate.value);
    apartmentFaultDetails!.isRecurring = isRecurring.value;

    apartmentFaultDetails!.result = null;
    apartmentFaultDetails!.message = null;

    if (faultDescriptionController.text.trim().isNotEmpty) {
      apartmentFaultDetails!.faultDescription =
          faultDescriptionController.text.trim();
    }

    if (selectedApartmentFaultType.value.isMustLocation ?? false) {
      apartmentFaultDetails!.location = locationController.text.trim();
    }

    if (handleDescriptionController.text.trim().isNotEmpty) {
      apartmentFaultDetails!.handleDescription =
          handleDescriptionController.text.trim();
    }

    if (creatorController.text.trim().isNotEmpty) {
      apartmentFaultDetails!.creator = creatorController.text.trim();
    }

    if (handlerController.text.trim().isNotEmpty) {
      apartmentFaultDetails!.handler = handlerController.text.trim();

      apartmentFaultDetails!.handleDate =
          DateFormat('dd/MM/yyyy').format(selectedHandleDate.value);
    }

    debugPrint("${jsonEncode(apartmentFaultDetails!.toJson())}");

    DioSingleton()
        .getApartmentFaultsService()
        .saveApartmentFault(apartmentFaultDetails!.toJson())
        .then((res) {
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
            .then((value) {
          if (resultMessageResponse.result ?? false) {
            Get.toNamed('/daily_attendance');
          }
        });
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }
}
