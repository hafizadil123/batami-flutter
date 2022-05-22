import 'dart:io';

import 'package:dio/dio.dart';

import '../dio_singleton.dart';

class AuthService {
  Future<Response<dynamic>> login(jsonObject) {
    return DioSingleton().getDio().post("Token",
        data: jsonObject,
      options: Options(contentType: Headers.formUrlEncodedContentType),);
  }

  Future<Response<dynamic>> getLoggedInUser() {
    return DioSingleton().getDio().post("api/Inner/GetLoggedInUser",);
  }
}
