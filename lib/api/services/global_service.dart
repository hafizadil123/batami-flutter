import 'package:dio/dio.dart';
import '../dio_singleton.dart';

class GlobalService{
  Future<Response<dynamic>> getData() {
    return DioSingleton().getDio().post(
      "api/Inner/GetData",
    );
  }

}