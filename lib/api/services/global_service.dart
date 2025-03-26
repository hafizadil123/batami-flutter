import 'dart:io';

import 'package:batami/api/dio_singleton.dart';
import 'package:batami/helpers/utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../helpers/constants.dart';

class GlobalService{
  Future<dio.Response<dynamic>> getData() {
    return DioSingleton().getDio().post(
      "api/Inner/GetData",
    );
  }

  Future<dio.Response<dynamic>> getVolunteerCard() {
    return DioSingleton().getDio().post(
      "mobile/GetVolunteerCard",
      options: dio.Options(responseType: dio.ResponseType.bytes),
    );
  }
  static Future<void> logError(dio.DioException e ,  dio.Response<dynamic>? response) async {
    String page = Get.currentRoute;
    String apiEndpoint = e.requestOptions.path;
    String responseData = response?.data?.toString() ?? "No response received";
    getLoggedInUser();
    Map<String, dynamic> logData = {
      "username": getLoggedInUser().userName,
      "page": page,
      "action": apiEndpoint,
      "data": {
        "error": e.message,
        "statusCode": e.response?.statusCode,
        "response": responseData,
        "stackTrace": e.stackTrace?.toString(),      }
    };
    print("LogData ${logData}");

    try {
      await DioSingleton().getDio().post('$GLOBAL_IP/api/Inner/loginfo',
          data: logData,);
      print("Error log sent successfully");
    } catch (logError) {
      print("Failed to send error log: $logError");
      saveFailedLog(logData);
    }
  }

  static void saveFailedLog(Map<String, dynamic> logData) {
    GetStorage storage = GetStorage().read(PREF_AUTH_KEY);
    List<dynamic> failedLogs = storage.read<List<dynamic>>(FAILED_LOGS_KEY) ?? [];
    failedLogs.add(logData);
    storage.write(FAILED_LOGS_KEY, failedLogs);
    print("Log saved locally: ${logData["data"]["error"]}");
  }
}