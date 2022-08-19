import 'package:batami/model/global/lock_screen_info.dart';

class SaveShiftResponse {
  final String? time;
  final bool? result;
  final String? message;
  final LockScreenInfo? lockScreenInfo;

  SaveShiftResponse({
    this.time,
    this.result,
    this.message,
    this.lockScreenInfo
  });

  factory SaveShiftResponse.fromJson(Map<String, dynamic> parsedJson) {
    return SaveShiftResponse(
      time: parsedJson['time'],
      result: parsedJson['result'],
      message: parsedJson['message'],
      lockScreenInfo: LockScreenInfo.fromJson(parsedJson['lockScreenInfo']),
    );
  }
}
