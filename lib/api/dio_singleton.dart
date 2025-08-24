import 'dart:developer';

import 'package:batami/api/services/apartment_faults_service.dart';
import 'package:batami/api/services/attendance_service.dart';
import 'package:batami/api/services/document_service.dart';
import 'package:batami/api/services/global_service.dart';
import 'package:batami/helpers/constants.dart';
import 'package:batami/helpers/utils.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import 'services/auth_service.dart';

class DioSingleton {
  static final DioSingleton _dio_singleton = DioSingleton._internal();

  factory DioSingleton() {
    return _dio_singleton;
  }

  DioSingleton._internal();

  static Dio? dio;

  Dio getDio() {
    if (dio == null) {
      dio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          baseUrl: GLOBAL_IP));

      dio?.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        requestInterceptor(options);

        print("${options.uri}");

        return handler.next(options);
      }, onResponse: (response, handler) {
        switch(response.statusCode ?? 0) {
          case >= 200 && <300 : log(response.runtimeType.toString());
          case 401: logoutAndGoToLogin();
          case 500: showInternalServerErrorDialog();
          default: callLogErrorAPI(apiResponse: response);
        }
        return handler.next(response);
      }, onError: (DioException e, handler) {
        switch(e.response?.statusCode ?? 0) {
          case 401: logoutAndGoToLogin();
          case 500: showInternalServerErrorDialog();
          default: callLogErrorAPI(exception: e);
        }
        return handler.next(e); //continue
      }));
    }
    return dio!;
  }

  void showInternalServerErrorDialog() {
    Get.defaultDialog(
        title: "", middleText: "ארעה שגיאה יש לנסות שוב או לפנות למוקד בת עמי");
  }

  dynamic requestInterceptor(RequestOptions options) {
    if (GetStorage().read(PREF_AUTH_KEY) != null) {
      options.headers["authorization"] =
          "bearer ${GetStorage().read(PREF_AUTH_KEY)}";
    }

    print(options.headers["authorization"]);

    return options;
  }

  void responseInterceptor(Response response) {
    print("Response Status: ${response.statusCode}");
    print("Response Data: ${response.data}");
  }


  AuthService getAuthService() {
    return AuthService();
  }

  AttendanceService getAttendanceService() {
    return AttendanceService();
  }

  DocumentService getDocumentService() {
    return DocumentService();
  }

  GlobalService getGlobalService() {
    return GlobalService();
  }

  ApartmentFaultsService getApartmentFaultsService() {
    return ApartmentFaultsService();
  }
}
