import 'package:batami/helpers/custom_colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  MyAppBar(this.title) : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? "",
        style: const TextStyle(
            color: CustomColors.colorSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 28.0),
      ),
      centerTitle: true,
      backgroundColor: CustomColors.colorMain,
      leading: null,
      elevation: 20,
      actions: [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
