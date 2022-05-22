import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugPrint("שלום ${getLoggedInUser().firstName}");

    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: CustomColors.colorMain,
          elevation: 0.0,
          title: Text("שלום ${getLoggedInUser().firstName}"),
          titleTextStyle: TextStyle(fontSize: 15.0),
        ),
        drawer: DrawerNavigation(),
        body: Column(
          children: [],
        ));
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<HomeController>(() => HomeController());
    Get.replace(HomeController());
  }
}
