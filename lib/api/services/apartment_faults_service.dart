import 'package:batami/api/dio_singleton.dart';
import 'package:dio/dio.dart';

class ApartmentFaultsService {
  Future<Response<dynamic>> getApartmentFaultsList() {
    return DioSingleton().getDio().post(
      "api/Inner/GetApartmentFaultList",
      data: {"rows": 5, "sortBy": "created"}
    );
  }

  Future<Response<dynamic>> getApartmentFaultDetails(jsonObject) {
    return DioSingleton().getDio().post(
      "api/Inner/GetApartmentFaultDetails",
      data: jsonObject,
    );
  }

  Future<Response<dynamic>> saveApartmentFault(jsonObject) {
    return DioSingleton().getDio().post(
        "api/Inner/ApartmentFaultSave",
        data: jsonObject
    );
  }

  Future<Response<dynamic>> deleteApartmentFault(jsonObject) {
    return DioSingleton().getDio().post(
        "api/Inner/ApartmentFaultDelete",
        data: jsonObject
    );
  }
}
