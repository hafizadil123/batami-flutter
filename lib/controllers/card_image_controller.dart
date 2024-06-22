import 'dart:typed_data';

import 'package:batami/api/dio_singleton.dart';
import 'package:get/get.dart';

class CardImageController extends GetxController {
  var isLoading = false.obs;
  var cardImgBytes = Uint8List.fromList([]).obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getVolunteerCard() async {
    isLoading.value = true;
    var response = await DioSingleton().getGlobalService().getVolunteerCard();

    isLoading.value = false;

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      print(response);
      cardImgBytes.value = Uint8List.fromList(response.data);
    }
  }
}
