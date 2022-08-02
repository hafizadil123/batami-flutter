import 'package:batami/controllers/apartment_faults/apartment_faults_controller.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/model/apartment_fault/apartment_faults_response.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApartmentFaultsScreen extends GetView<ApartmentFaultsController> {
  const ApartmentFaultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getApartmentFaults();

    return Scaffold(
        drawer: DrawerNavigation(),
        appBar: AppBar(
          backgroundColor: CustomColors.colorMain,
          titleTextStyle: const TextStyle(fontSize: 15.0),
          title: const Text("רשימת תקלות לדירה"),
          actions: [
            IconButton(
                onPressed: () {
                  controller.getApartmentFaultDetails(0, true);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? getLoadingBar()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.apartmentFaults.value.rows?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _buildConversationsSingleItem(controller
                        .apartmentFaults.value.rows!
                        .elementAt(index));
                  },
                ),
        ));
  }

  Widget _buildConversationsSingleItem(Fault fault) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithHeading("מספר תקלה", "${fault.id}"),
                    textWithHeading("תאריך התרחשות", fault.occurrenceDate),
                    textWithHeading("סטטוס תקלה", fault.statusName),
                    textWithHeading("תיאור תקלה", fault.faultDescription),
                    textWithHeading("מיקום", fault.location),
                    textWithHeading("תיאור טיפול", fault.handleDescription),
                    textWithHeading("תאריך טיפול", fault.handleDate),
                    textWithHeading("סוג תקלה", fault.apartmentFaultTypeName),
                    textWithHeading("האם תקלה חוזרת", fault.isRecurring),
                    textWithHeading("פותח תקלה", fault.creator),
                    textWithHeading("סוגר תקלה", fault.handler),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed:
                          fault.handleDate != null && fault.handleDate!.isNotEmpty
                              ? null
                              : () {
                                  controller.getApartmentFaultDetails(
                                      fault.id!, true);
                                },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () => controller.showDeleteDialog(fault.id!),
                      icon: const Icon(Icons.delete)),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () => controller.getApartmentFaultDetails(fault.id!, false),
    );
  }
}
