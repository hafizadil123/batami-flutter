class AttendanceDailyResponse {
  final String? currentDate;
  final bool? enabled;
  String? latestStartTime;
  String? latestEndTime;
  final bool? result;
  final String? message;
  final int? workActivityCode;
  final List<WorkActivityItem>? workActivityItems;

  final bool? allowAttendanceStart;
  final bool? allowAttendanceEnd;
  final bool? allowAbsenceStart;
  final bool? allowAbsenceEnd;
  final bool? allowAbsenceAllDay;
  final bool? allowSickStart;
  final bool? allowSickEnd;
  final bool? allowSickAllDay;
  final List<ExistingData>? existingData;
  final int? absenceCode;
  final String? rowType;

  AttendanceDailyResponse({
    this.currentDate,
    this.enabled,
    this.latestStartTime,
    this.latestEndTime,
    this.result,
    this.message,
    this.workActivityCode,
    this.workActivityItems,
    this.allowAttendanceStart,
    this.allowAttendanceEnd,
    this.allowAbsenceStart,
    this.allowAbsenceEnd,
    this.allowAbsenceAllDay,
    this.allowSickStart,
    this.allowSickEnd,
    this.allowSickAllDay,
    this.existingData,
    this.absenceCode,
    this.rowType,
  });

  factory AttendanceDailyResponse.fromJson(Map<String, dynamic> parsedJson) {
    return AttendanceDailyResponse(
      currentDate: parsedJson['currentDate'],
      enabled: parsedJson['enabled'],
      latestStartTime: parsedJson['latestStartTime'],
      latestEndTime: parsedJson['latestEndTime'],
      result: parsedJson['result'],
      message: parsedJson['message'],
      workActivityCode: parsedJson['workActivityCode'],
      workActivityItems: parsedJson['workActivityItems'] != null
          ? List.from(parsedJson['workActivityItems'])
              .map((e) => WorkActivityItem.fromJson(e))
              .toList()
          : [],
      allowAttendanceStart: parsedJson['allowAttendanceStart'],
      allowAttendanceEnd: parsedJson['allowAttendanceEnd'],
      allowAbsenceStart: parsedJson['allowAbsenceStart'],
      allowAbsenceEnd: parsedJson['allowAbsenceEnd'],
      allowAbsenceAllDay: parsedJson['allowAbsenceAllDay'],
      allowSickStart: parsedJson['allowSickStart'],
      allowSickEnd: parsedJson['allowSickEnd'],
      allowSickAllDay: parsedJson['allowSickAllDay'],
      existingData: parsedJson['existingData'] != null
          ? List.from(parsedJson['existingData'])
              .map((e) => ExistingData.fromJson(e))
              .toList()
          : [],
      absenceCode: parsedJson['absenceCode'],
      rowType: parsedJson['rowType'],
    );
  }
}

class ExistingData {
  final int? id;
  final String? activity;
  final String? startTime;
  final String? endTime;
  final String? absenceName;
  final String? note;

  ExistingData({
    this.id,
    this.activity,
    this.startTime,
    this.endTime,
    this.absenceName,
    this.note,
  });

  factory ExistingData.fromJson(Map<String, dynamic> parsedJson) {
    return ExistingData(
      id: parsedJson['id'],
      activity: parsedJson['activity'],
      startTime: parsedJson['startTime'],
      endTime: parsedJson['endTime'],
      absenceName: parsedJson['absenceName'],
      note: parsedJson['note'],
    );
  }
}

class WorkActivityItem {
  final int? id;
  final String? name;
  final bool? demandNote;
  final String? defaultNote;

  WorkActivityItem({
    this.id,
    this.name,
    this.demandNote,
    this.defaultNote,
  });

  factory WorkActivityItem.fromJson(Map<String, dynamic> parsedJson) {
    return WorkActivityItem(
      id: parsedJson['id'],
      name: parsedJson['name'],
      demandNote: parsedJson['demandNote'],
      defaultNote: parsedJson['defaultNote'],
    );
  }
}
