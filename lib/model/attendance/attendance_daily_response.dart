class AttendanceDailyResponse {
  final String? currentDate;
  final bool? enabled;
  String? latestStartTime;
  String? latestEndTime;
  final bool? result;
  final String? message;

  final int? workActivityCode;
  final bool? displayWorkActivity;
  final List<WorkActivityItem>? workActivityItems;

  AttendanceDailyResponse(
      {this.currentDate,
      this.enabled,
      this.latestStartTime,
      this.latestEndTime,
      this.result,
      this.message,
      this.workActivityCode,
      this.displayWorkActivity,
      this.workActivityItems});

  factory AttendanceDailyResponse.fromJson(Map<String, dynamic> parsedJson) {
    return AttendanceDailyResponse(
      currentDate: parsedJson['currentDate'],
      enabled: parsedJson['enabled'],
      latestStartTime: parsedJson['latestStartTime'],
      latestEndTime: parsedJson['latestEndTime'],
      result: parsedJson['result'],
      message: parsedJson['message'],
      workActivityCode: parsedJson['workActivityCode'],
      displayWorkActivity: parsedJson['displayWorkActivity'],
      workActivityItems: List.from(parsedJson['workActivityItems'])
          .map((e) => WorkActivityItem.fromJson(e))
          .toList(),
    );
  }
}

class WorkActivityItem {
  final int? id;
  final String? name;

  WorkActivityItem({
    this.id,
    this.name,
  });

  factory WorkActivityItem.fromJson(Map<String, dynamic> parsedJson) {
    return WorkActivityItem(
      id: parsedJson['id'],
      name: parsedJson['name'],
    );
  }
}
