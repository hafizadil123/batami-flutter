class AttendanceDailyResponse {
  final String? currentDate;
  final bool? enabled;
  String? latestStartTime;
  String? latestEndTime;
  final bool? result;
  final String? message;

  AttendanceDailyResponse({
    this.currentDate,
    this.enabled,
    this.latestStartTime,
    this.latestEndTime,
    this.result,
    this.message,
  });

  factory AttendanceDailyResponse.fromJson(Map<String, dynamic> parsedJson) {
    return AttendanceDailyResponse(
      currentDate: parsedJson['currentDate'],
      enabled: parsedJson['enabled'],
      latestStartTime: parsedJson['latestStartTime'],
      latestEndTime: parsedJson['latestEndTime'],
      result: parsedJson['result'],
      message: parsedJson['message'],
    );
  }
}
