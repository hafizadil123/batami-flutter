import 'package:flutter/material.dart';


typedef FutureVoidCallback = Future<void> Function();

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({required this.resumeCallBack, required this.detachedCallBack});

  late final FutureVoidCallback resumeCallBack;
  late final FutureVoidCallback detachedCallBack;

//  @override
//  Future<bool> didPopRoute()

//  @override
//  void didHaveMemoryPressure()

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        await detachedCallBack();
        break;
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }
//     _log.finest('''
// =============================================================
//                $state
// =============================================================
// ''');
  }

//  @override
//  void didChangeLocale(Locale locale)

//  @override
//  void didChangeTextScaleFactor()

//  @override
//  void didChangeMetrics();

//  @override
//  Future<bool> didPushRoute(String route)
}