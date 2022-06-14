import 'package:batami/api/dio_singleton.dart';
import 'package:dio/dio.dart';

class DocumentService {
  Future<Response<dynamic>> saveDocument(jsonObject) {
    return DioSingleton().getDio().post(
      "mobile/DocumentSave",
      data: jsonObject,
      options: Options(contentType: "multipart/form-data"),
    );
  }
}
