import 'package:batami/controllers/save_document_controller.dart';
import 'package:get/get.dart';

class SaveDocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.replace(SaveDocumentController());
  }
}
