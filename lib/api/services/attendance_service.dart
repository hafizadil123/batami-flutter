import 'dart:io';

import 'package:dio/dio.dart';

import '../dio_singleton.dart';

class AttendanceService {
  Future<Response<dynamic>> getAttendanceDaily() {
    return DioSingleton().getDio().post(
          "api/Inner/GetAttendanceDaily",
        );
  }

  Future<Response<dynamic>> saveStartShift() {
    return DioSingleton().getDio().post(
          "api/Inner/SaveStartShift",
        );
  }

  Future<Response<dynamic>> saveEndShift() {
    return DioSingleton().getDio().post(
          "api/Inner/SaveEndShift",
        );
  }
}
