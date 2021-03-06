import 'package:batami/api/dio_singleton.dart';
import 'package:dio/dio.dart';

class AttendanceService {
  Future<Response<dynamic>> getAttendanceDaily() {
    return DioSingleton().getDio().post(
          "api/Inner/GetAttendanceDaily",
        );
  }

  Future<Response<dynamic>> saveStartShift(jsonObject) {
    return DioSingleton().getDio().post(
          "api/Inner/SaveStartShift",
      data: jsonObject,
        );
  }

  Future<Response<dynamic>> saveEndShift(jsonObject) {
    return DioSingleton().getDio().post(
          "api/Inner/SaveEndShift",
      data: jsonObject
        );
  }
}
