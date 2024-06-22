import 'dart:io';

import 'package:batami/api/dio_singleton.dart';
import 'package:dio/dio.dart';

class GlobalService{
  Future<Response<dynamic>> getData() {
    return DioSingleton().getDio().post(
      "api/Inner/GetData",
    );
  }

  Future<Response<dynamic>> getVolunteerCard() {
    return DioSingleton().getDio().post(
      "mobile/GetVolunteerCard",
      options: Options(responseType: ResponseType.bytes),
    );
  }

}