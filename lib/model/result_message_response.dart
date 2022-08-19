import 'package:batami/model/global/lock_screen_info.dart';

class ResultMessageResponse {
  final bool? result;
  final String? message;
  final LockScreenInfo? lockScreenInfo;

  ResultMessageResponse({
    this.result,
    this.message,
    this.lockScreenInfo
  });

  factory ResultMessageResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ResultMessageResponse(
      result: parsedJson['result'],
      message: parsedJson['message'],
      lockScreenInfo: LockScreenInfo.fromJson(parsedJson['lockScreenInfo']),
    );
  }
}
