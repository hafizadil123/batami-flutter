import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Theme.of(context).primaryColorDark,
      size: 30.0,
    );
  }
}