import 'package:batami/api/dio_singleton.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class AttendanceService {
  Future<Response<dynamic>> getAttendanceDaily() {
    return DioSingleton().getDio().post(
          "api/Inner/GetAttendanceDaily",
        );
  }

  Future<Response<dynamic>> saveAttendanceEntrance(jsonObject) {
    jsonObject["date"] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    jsonObject["time"] = DateFormat('HH:mm').format(DateTime.now());
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailySaveAttendanceEntrance",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveAbsenceEntrance(jsonObject) {
    jsonObject["date"] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    jsonObject["time"] = DateFormat('HH:mm').format(DateTime.now());
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailySaveAbsenceEntrance",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveSickEntrance(jsonObject) {
    jsonObject["date"] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    jsonObject["time"] = DateFormat('HH:mm').format(DateTime.now());
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailySaveSickEntrance",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveAnyExit(jsonObject) {
    jsonObject["date"] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    jsonObject["time"] = DateFormat('HH:mm').format(DateTime.now());
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailySaveAnyExit",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveFullAbsenceDay(jsonObject) {
    jsonObject["date"] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    jsonObject["time"] = DateFormat('HH:mm').format(DateTime.now());
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailyFullAbsenceDay",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveFullSickDay(jsonObject) {
    jsonObject["date"] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    jsonObject["time"] = DateFormat('HH:mm').format(DateTime.now());
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailyFullSickDay",
      data: jsonObject
        );
  }

  // Future<Response<dynamic>> saveStartShift(jsonObject) {
  //   return DioSingleton().getDio().post(
  //         "api/Inner/SaveStartShift",
  //     data: jsonObject,
  //       );
  // }
  //
  // Future<Response<dynamic>> saveEndShift(jsonObject) {
  //   return DioSingleton().getDio().post(
  //         "api/Inner/SaveEndShift",
  //     data: jsonObject
  //       );
  // }
}
