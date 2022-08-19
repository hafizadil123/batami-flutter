import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/widgets/drawer_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LockScreen extends StatelessWidget {

  LockScreen({Key? key}) : super(key: key){
    // print("Arguments: ${Get.parameters}");
    lockScreenText = Get.parameters["lockScreenText"];
  }

  String? lockScreenText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerNavigation(isLockScreen: true,),
      appBar: AppBar(
        backgroundColor: CustomColors.colorMain,
        elevation: 0.0,
        title: Text("מסך נעול"),
        titleTextStyle: TextStyle(fontSize: 15.0),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text("$lockScreenText", style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
