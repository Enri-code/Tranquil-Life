import 'package:flutter/material.dart';

class CustomLoader {
  static bool _isDialogOpen = false;
  static late NavigatorState _navigator;
  static init(BuildContext context) => _navigator = Navigator.of(context);

  static void display() {
    if (_isDialogOpen) return;
    showDialog(
      context: _navigator.context,
      builder: (_) => WillPopScope(
        child: const Center(child: CircularProgressIndicator()),
        onWillPop: () {
          _isDialogOpen = false;
          return Future.value(false);
        },
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
    _isDialogOpen = true;
  }

  static void remove() {
    if (_isDialogOpen) {
      _navigator.pop();
      _isDialogOpen = false;
    }
  }
}
