import 'package:batami/helpers/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleSelectDialog extends StatelessWidget {

  SingleSelectDialog({Key? key, this.itemsList, this.hint, this.controller, this.callback}) : super(key: key);

  List? itemsList = [];
  TextEditingController? controller;
  String? hint;
  Function(dynamic item)? callback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: CustomColors.textColor,
      style: const TextStyle(letterSpacing: 1.5),

    validator: (value) {
              if (value ==
                  null || value.trim().isEmpty) {
                return "זהו שדה חובה";
              }
              return null;
            },
      decoration: InputDecoration(
        hintText: hint,
        helperText: hint,
        contentPadding: EdgeInsets.all(10.0),
        enabledBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: CustomColors.colorSecondary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: CustomColors.colorSecondary),
        ),
        focusColor: CustomColors.colorSecondary,
      ),
      onTap: (){
        Get.defaultDialog(
          title: hint!,
          backgroundColor: Colors.white,
          content: Container(
            height: Get.size.height * 0.2,
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: itemsList!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Text("${itemsList![index].name}"),
                    onTap: (){
                      callback!(itemsList![index]);
                      controller!.text = itemsList![index].name;
                      Get.back();
                    },
                  );
                },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.black54,);
              },
              ),
          ),
        );
      },
    );
  }
}
