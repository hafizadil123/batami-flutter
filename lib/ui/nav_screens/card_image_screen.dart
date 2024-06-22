import 'package:batami/controllers/card_image_controller.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardImageScreen extends GetView<CardImageController> {
  const CardImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getVolunteerCard();
    return Scaffold(
      drawer: DrawerNavigation(),
      appBar: AppBar(
        backgroundColor: CustomColors.colorMain,
        elevation: 0.0,
        title: const Text("כרטיס מתנדב"),
        titleTextStyle: TextStyle(fontSize: 15.0),
      ),
      body: Obx(
        () => Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.memory(controller.cardImgBytes.value).image,
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),





    );
  }
}
