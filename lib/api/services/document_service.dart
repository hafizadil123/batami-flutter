import 'package:dio/dio.dart';
import '../dio_singleton.dart';

class DocumentService {
  Future<Response<dynamic>> saveDocument(jsonObject) {
    return DioSingleton().getDio().post(
      "mobile/DocumentSave",
      data: jsonObject,
      options: Options(contentType: "multipart/form-data"),
    );
  }
}
