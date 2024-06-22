import 'package:batami/controllers/card_image_controller.dart';
import 'package:get/get.dart';

class CardImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.replace(CardImageController());
  }
}