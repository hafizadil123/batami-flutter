import 'package:batami/api/services/apartment_faults_service.dart';
import 'package:batami/api/services/attendance_service.dart';
import 'package:batami/api/services/document_service.dart';
import 'package:batami/api/services/global_service.dart';
import 'package:batami/helpers/constants.dart';
import 'package:batami/helpers/utils.dart';
import 'package:dio/dio.dart';
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

        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          print(response.runtimeType.toString());
        } else {
          callLogErrorAPI(apiResponse: response);
        }
        return handler.next(response);
      }, onError: (DioException e, handler) {
        if (e.response != null) {
          callLogErrorAPI(exception: e);
          // handleResponseErrors(e.response!.statusCode!);
        }
        return handler.next(e); //continue
      }));
    }
    return dio!;
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
