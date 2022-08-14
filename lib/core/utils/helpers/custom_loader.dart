import 'package:flutter/material.dart';

class CustomLoader {
  static bool _isDialogOpen = false;
  static late NavigatorState _navigator;
  static init(NavigatorState navigator) => _navigator = navigator;

  static void display() {
    if (_isDialogOpen) return;
    showDialog(
      context: _navigator.context,
      builder: (_) => widget,
      barrierDismissible: false,
      useSafeArea: true,
    );
    _isDialogOpen = true;
  }

  static Widget get widget => WillPopScope(
        child: const Center(child: CircularProgressIndicator()),
        onWillPop: () {
          _isDialogOpen = false;
          return Future.value(false);
        },
      );

  static void remove() {
    if (_isDialogOpen) {
      _navigator.pop();
      _isDialogOpen = false;
    }
  }
}
