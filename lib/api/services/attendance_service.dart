import 'package:batami/api/dio_singleton.dart';
import 'package:dio/dio.dart';

class AttendanceService {
  Future<Response<dynamic>> getAttendanceDaily() {
    return DioSingleton().getDio().post(
          "api/Inner/GetAttendanceDaily",
        );
  }

  Future<Response<dynamic>> saveAttendanceEntrance(jsonObject) {
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailySaveAttendanceEntrance",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveAbsenceEntrance(jsonObject) {
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailySaveAbsenceEntrance",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveSickEntrance(jsonObject) {
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailySaveSickEntrance",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveAnyExit(jsonObject) {
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailySaveAnyExit",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveFullAbsenceDay(jsonObject) {
    return DioSingleton().getDio().post(
          "api/Inner/AttendanceDailyFullAbsenceDay",
      data: jsonObject
        );
  }

  Future<Response<dynamic>> saveFullSickDay(jsonObject) {
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
