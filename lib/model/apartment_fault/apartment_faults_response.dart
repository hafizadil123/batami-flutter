import 'package:batami/model/global/lock_screen_info.dart';

class ApartmentFaultsResponse {
  List<Fault>? rows;
  int? total;
  int? page;
  int? records;
  bool? result;
  String? message;
  LockScreenInfo? lockScreenInfo;

  ApartmentFaultsResponse(
      {this.rows,
      this.total,
      this.page,
      this.records,
      this.result,
      this.message,
      this.lockScreenInfo,});

  ApartmentFaultsResponse.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      rows = <Fault>[];
      json['rows'].forEach((v) {
        rows!.add(Fault.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    records = json['records'];
    result = json['result'];
    message = json['message'];

    lockScreenInfo = LockScreenInfo.fromJson(json['lockScreenInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['page'] = page;
    data['records'] = records;
    data['result'] = result;
    data['message'] = message;
    data['lockScreenInfo'] = lockScreenInfo;
    return data;
  }
}

class Fault {
  String? isRecurring;
  int? id;
  String? occurrenceDate;
  String? statusName;
  String? faultDescription;
  String? location;
  String? handleDescription;
  String? handleDate;
  String? apartmentFaultTypeName;
  String? creator;
  String? handler;

  Fault(
      {isRecurring,
      this.id,
      this.occurrenceDate,
      this.statusName,
      this.faultDescription,
      this.location,
      this.handleDescription,
      this.handleDate,
      this.apartmentFaultTypeName,
      this.creator,
      this.handler});

  Fault.fromJson(Map<String, dynamic> json) {
    isRecurring = json['isRecurring'];
    id = json['id'];
    occurrenceDate = json['occurrenceDate'];
    statusName = json['statusName'];
    faultDescription = json['faultDescription'];
    location = json['location'];
    handleDescription = json['handleDescription'];
    handleDate = json['handleDate'];
    apartmentFaultTypeName = json['apartmentFaultTypeName'];
    creator = json['creator'];
    handler = json['handler'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isRecurring'] = isRecurring;
    data['id'] = id;
    data['occurrenceDate'] = occurrenceDate;
    data['statusName'] = statusName;
    data['faultDescription'] = faultDescription;
    data['location'] = location;
    data['handleDescription'] = handleDescription;
    data['handleDate'] = handleDate;
    data['apartmentFaultTypeName'] = apartmentFaultTypeName;
    data['creator'] = creator;
    data['handler'] = handler;
    return data;
  }
}
