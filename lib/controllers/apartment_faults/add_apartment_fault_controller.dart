import 'dart:convert';

import 'package:batami/api/dio_singleton.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/apartment_fault/apartment_fault_details.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:batami/model/result_message_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddApartmentFaultController extends GetxController {
  var isLoading = false.obs;

  Rx<ApartmentFaultCategoryTypes> selectedApartmentFaultCategoryType = ApartmentFaultCategoryTypes(id: null, name: "קטגוריית תקלה", types: []).obs;

  Rx<ApartmentFaultTypes> selectedApartmentFaultType = ApartmentFaultTypes(id: null, name: "סוג תקלה", isMustLocation: null).obs;

  Rx<DateTime> selectedOccurrenceDate = DateTime.now().obs;
  RxBool isRecurring = false.obs;

  TextEditingController faultDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController apartmentFaultCategoryTypeController = TextEditingController();
  TextEditingController apartmentFaultTypeController = TextEditingController();

  ApartmentFaultDetails? apartmentFaultDetails;


  @override
  void onInit() {
    apartmentFaultDetails = Get.arguments[0];

    if (apartmentFaultDetails!.faultCategoryTypeCode != null &&
        apartmentFaultDetails!.faultCategoryTypeCode != 0) {
      selectedApartmentFaultCategoryType.value = getAppData()
          .apartmentFaultCategoryTypes
          .firstWhere(
              (p) => p.id == apartmentFaultDetails!.faultCategoryTypeCode,
              orElse: () => ApartmentFaultCategoryTypes(
                  id: null, name: "קטגוריית תקלה", types: []));

      apartmentFaultCategoryTypeController.text = selectedApartmentFaultCategoryType.value.name;

    }

    if (apartmentFaultDetails!.faultTypeCode != null &&
        apartmentFaultDetails!.faultTypeCode != 0) {
      selectedApartmentFaultType.value = selectedApartmentFaultCategoryType
          .value.types
          .firstWhere((p) => p.id == apartmentFaultDetails!.faultTypeCode,
              orElse: () => ApartmentFaultTypes(
                  id: null, name: "סוג תקלה", isMustLocation: null));

      apartmentFaultTypeController.text = selectedApartmentFaultType.value.name!;
    }

    if (apartmentFaultDetails!.occurrenceDate != null) {
      selectedOccurrenceDate.value = DateFormat('dd/MM/yyyy')
          .parse(apartmentFaultDetails!.occurrenceDate!);
    }

    isRecurring.value = apartmentFaultDetails!.isRecurring ?? false;

    super.onInit();
  }

  // void onApartmentFaultCategoryTypeChanged(ApartmentFaultCategoryTypes? val){
  //   selectedApartmentFaultCategoryType.value = val!;
  //
  //   apartmentFaultTypeItems = selectedApartmentFaultCategoryType.value.types.map(
  //         (val) {
  //       return DropdownMenuItem<ApartmentFaultTypes>(
  //         value: val,
  //         child: Text(val.name!),
  //       );
  //     },
  //   ).toList();
  // }
  //
  // void onApartmentFaultTypeChanged(ApartmentFaultTypes? val){
  //   selectedApartmentFaultType.value = val!;
  // }

  // ApartmentFaultCategoryTypes

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

    debugPrint(jsonEncode(apartmentFaultDetails!.toJson()));

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
            Get.toNamed('/apartment_faults');
          }
        });
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }
}
