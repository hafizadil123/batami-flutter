class SaveShiftResponse {
  final String? time;
  final bool? result;
  final String? message;

  SaveShiftResponse({
    this.time,
    this.result,
    this.message,
  });

  factory SaveShiftResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SaveShiftResponse(
      time: parsedJson['time'],
      result: parsedJson['result'],
      message: parsedJson['message'],
    );
  }
}
