import 'package:batami/controllers/apartment_faults/add_apartment_fault_controller.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/apartment_fault/apartment_faults_response.dart';
import 'package:batami/model/global/get_data_response.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddApartmentFaultScreen extends GetView<AddApartmentFaultController> {
  AddApartmentFaultScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<ApartmentFaultCategoryTypes>>
      apartmentFaultCategoryTypesMenuItems = [
    DropdownMenuItem(
      child: Text("קטגוריית תקלה"),
      value: ApartmentFaultCategoryTypes(id: null, name: "קטגוריית תקלה"),
    ),
    ...getAppData().apartmentFaultCategoryTypes.map(
      (val) {
        return DropdownMenuItem<ApartmentFaultCategoryTypes>(
          value: val,
          child: Text(val.name),
        );
      },
    ).toList(),
  ];

  List<DropdownMenuItem<ApartmentFaultTypes>> apartmentFaultTypesMenuItems = [
    DropdownMenuItem(
      child: Text("סוג תקלה"),
      value: ApartmentFaultTypes(
          id: null, name: "סוג תקלה", categoryCode: null, isMustLocation: null),
    ),
    ...getAppData().apartmentFaultTypes.map(
      (val) {
        return DropdownMenuItem<ApartmentFaultTypes>(
          value: val,
          child: Text(val.name!),
        );
      },
    ).toList(),
  ];

  @override
  Widget build(BuildContext context) {
    // controller.getApartmentFaults();

    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        backgroundColor: CustomColors.colorMain,
        titleTextStyle: TextStyle(fontSize: 15.0),
        title: Text("הוסף חדש"),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? getLoadingBar()
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      textWithHeading("מספר תקלה",
                          "${controller.apartmentFaultDetails!.id}"),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      textWithHeading("שם הדירה",
                          controller.apartmentFaultDetails!.apartmentName),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      textWithHeading("סטטוס תקלה",
                          controller.apartmentFaultDetails!.statusName),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      DropdownButtonFormField(
                        hint: Text(controller
                            .selectedApartmentFaultCategoryType.value.name),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: CustomColors.colorSecondary),
                        items: apartmentFaultCategoryTypesMenuItems,
                        validator: (value) {
                          if (controller.selectedApartmentFaultCategoryType
                                  .value.id ==
                              null) {
                            return "זהו שדה חובה";
                          }
                          return null;
                        },
                        onChanged: (ApartmentFaultCategoryTypes? val) {
                          controller.selectedApartmentFaultCategoryType.value =
                              val!;
                        },
                        decoration: const InputDecoration(
                          hintText: "קטגוריית תקלה",
                          contentPadding: EdgeInsets.all(10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusColor: CustomColors.colorSecondary,
                          hintStyle:
                              TextStyle(color: CustomColors.colorSecondary),
                        ),
                      ),
                      controller.selectedApartmentFaultCategoryType.value.id !=
                              null
                          ? DropdownButtonFormField(
                              hint: Text(controller
                                  .selectedApartmentFaultType.value.name!),
                              isExpanded: true,
                              iconSize: 30.0,
                              style:
                                  TextStyle(color: CustomColors.colorSecondary),
                              items: apartmentFaultTypesMenuItems,
                              validator: (value) {
                                if (controller
                                        .selectedApartmentFaultType.value.id ==
                                    null) {
                                  return "זהו שדה חובה";
                                }
                                return null;
                              },
                              onChanged: (ApartmentFaultTypes? val) {
                                controller.selectedApartmentFaultType.value =
                                    val!;
                              },
                              decoration: const InputDecoration(
                                hintText: "סוג תקלה",
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
                      Row(
                        children: [
                          Flexible(flex: 30, child: Text("תאריך התרחשות: ")),
                          Flexible(
                            flex: 70,
                            child: Container(
                              height: 100,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  controller.selectedOccurrenceDate.value =
                                      newDateTime;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      CheckboxListTile(
                        value: controller.isRecurring.value,
                        onChanged: (bool? val) {
                          controller.isRecurring.toggle();
                        },
                        title: Text("האם תקלה חוזרת"),
                      ),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      TextFormField(
                        controller: controller.faultDescriptionController,
                        maxLength: 110,
                        keyboardType: TextInputType.text,
                        cursorColor: CustomColors.colorSecondary,
                        style: const TextStyle(letterSpacing: 1.5),
                        decoration: const InputDecoration(
                          hintText: "תיאור תקלה",
                          contentPadding: EdgeInsets.all(10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusColor: CustomColors.colorSecondary,
                        ),
                      ),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      (controller.selectedApartmentFaultType.value
                                  .isMustLocation ??
                              false)
                          ? TextFormField(
                              controller: controller.locationController,
                              maxLength: 110,
                              keyboardType: TextInputType.text,
                              cursorColor: CustomColors.colorSecondary,
                              style: const TextStyle(letterSpacing: 1.5),
                              validator: (value) {
                                if ((controller.selectedApartmentFaultType.value
                                            .isMustLocation ??
                                        false) &&
                                    value == null) {
                                  return "זהו שדה חובה";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "מיקום",
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
                            )
                          : SizedBox.shrink(),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      Row(
                        children: [
                          Flexible(flex: 30, child: Text("תאריך טיפול: ")),
                          Flexible(
                            flex: 70,
                            child: Container(
                              height: 100,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  controller.selectedHandleDate.value =
                                      newDateTime;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      TextFormField(
                        controller: controller.handleDescriptionController,
                        keyboardType: TextInputType.text,
                        cursorColor: CustomColors.colorSecondary,
                        style: const TextStyle(letterSpacing: 1.5),
                        decoration: const InputDecoration(
                          hintText: "תיאור טיפול",
                          contentPadding: EdgeInsets.all(10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusColor: CustomColors.colorSecondary,
                        ),
                      ),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      TextFormField(
                        controller: controller.creatorController,
                        keyboardType: TextInputType.text,
                        cursorColor: CustomColors.colorSecondary,
                        style: const TextStyle(letterSpacing: 1.5),
                        decoration: const InputDecoration(
                          hintText: "פותח תקלה",
                          contentPadding: EdgeInsets.all(10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusColor: CustomColors.colorSecondary,
                        ),
                      ),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      TextFormField(
                        controller: controller.handlerController,
                        keyboardType: TextInputType.text,
                        cursorColor: CustomColors.colorSecondary,
                        style: const TextStyle(letterSpacing: 1.5),
                        decoration: const InputDecoration(
                          hintText: "סוגר תקלה",
                          contentPadding: EdgeInsets.all(10.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: CustomColors.colorSecondary),
                          ),
                          focusColor: CustomColors.colorSecondary,
                        ),
                      ),
                      Container(
                          height: 1,
                          width: Get.size.width,
                          color: CustomColors.colorSecondary),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.saveApartmentFault();
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
      ),
    );
  }
}
