import 'package:batami/api/dio_singleton.dart';
import 'package:dio/dio.dart' as dio;

class GlobalService {
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

  Future<dio.Response<dynamic>> logAPIError(jsonObject) {
    return DioSingleton().getDio().post(
          "api/Inner/loginfo",
          data: jsonObject
        );
  }
}
