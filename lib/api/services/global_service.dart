import 'package:batami/api/dio_singleton.dart';
import 'package:dio/dio.dart';

class GlobalService{
  Future<Response<dynamic>> getData() {
    return DioSingleton().getDio().post(
      "api/Inner/GetData",
    );
  }

}