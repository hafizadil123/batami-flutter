import 'dart:convert';

import 'package:batami/api/dio_singleton.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/apartment_fault/apartment_fault_details.dart';
import 'package:batami/model/apartment_fault/apartment_faults_response.dart';
import 'package:batami/model/result_message_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApartmentFaultsController extends GetxController {
  var isLoading = false.obs;
  Rx<ApartmentFaultsResponse> apartmentFaults = ApartmentFaultsResponse().obs;

  void getApartmentFaults() async {
    isLoading.value = true;

    DioSingleton()
        .getApartmentFaultsService()
        .getApartmentFaultsList()
        .then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        ApartmentFaultsResponse apartmentFaultsResponse =
            ApartmentFaultsResponse.fromJson(res.data);

        apartmentFaults.value = apartmentFaultsResponse;

        if(apartmentFaults.value.lockScreenInfo?.isLockScreen ?? false){
          Get.offNamed("/lock_screen", parameters: {"lockScreenText": apartmentFaults.value.lockScreenInfo!.lockScreenText!});
        }

      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void deleteApartmentFault(int id) async {
    Get.back();
    isLoading.value = true;

    Map<String, dynamic> map = {};
    map["id"] = id;

    DioSingleton()
        .getApartmentFaultsService()
        .deleteApartmentFault(map)
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
            getApartmentFaults();
          }
        });
      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void getApartmentFaultDetails(int id, bool openAddFaultForm) async {
    isLoading.value = true;

    Map<String, dynamic> map = {};
    map["id"] = id;

    DioSingleton()
        .getApartmentFaultsService()
        .getApartmentFaultDetails(map)
        .then((res) {
      isLoading.value = false;

      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        print(res);

        ApartmentFaultDetails apartmentFaultDetailsResponse =
            ApartmentFaultDetails.fromJson(res.data);

        if(apartmentFaultDetailsResponse.lockScreenInfo?.isLockScreen ?? false){
          Get.offNamed("/lock_screen", parameters: {"lockScreenText": apartmentFaultDetailsResponse.lockScreenInfo!.lockScreenText!});
        }

        if(openAddFaultForm){
          Get.toNamed('/add_apartment_fault',
              arguments: [apartmentFaultDetailsResponse]);
        } else{
          showApartmentFaultDetailsDialog(apartmentFaultDetailsResponse);
        }

      }
    }).catchError((error) {
      print(error);
      isLoading.value = false;
    });
  }

  void showDeleteDialog(int id) {
    Get.defaultDialog(
        title: "",
        middleText: "האם אתה באמת רוצה למחוק את הפריט הזה?",
        actions: [
          ElevatedButton(
            onPressed: () => deleteApartmentFault(id),
            child: const Text("כן"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text("לְבַטֵל"),
          )
        ]);
  }

  void showApartmentFaultDetailsDialog(ApartmentFaultDetails faultDetails) {
    Get.dialog(
      Scaffold(
        appBar: AppBar(
          title: Text("פירוט תקלות הדירה"),
          backgroundColor: CustomColors.colorMain,
          titleTextStyle: TextStyle(fontSize: 15.0),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                textWithHeading("מספר תקלה", "${faultDetails.id}"),
                textWithHeading("שם הדירה", faultDetails.apartmentName),
                textWithHeading("סטטוס תקלה", faultDetails.statusName),
                textWithHeading("סוג תקלה", faultDetails.apartmentFaultTypeName),
                textWithHeading("תאריך התרחשות", faultDetails.occurrenceDate),
                textWithHeading("האם תקלה חוזרת", "${faultDetails.isRecurring}"),
                textWithHeading("תיאור תקלה", faultDetails.faultDescription),
                textWithHeading("מיקום", faultDetails.location),
                textWithHeading("תאריך טיפול", faultDetails.handleDate),
                textWithHeading("תיאור טיפול", faultDetails.handleDescription),
                textWithHeading("פותח תקלה", faultDetails.creator),
                textWithHeading("סוגר תקלה", faultDetails.handler),
              ],
            ),
          ),
        ),
      ),
      barrierColor: Colors.white,
    );
  }
}
