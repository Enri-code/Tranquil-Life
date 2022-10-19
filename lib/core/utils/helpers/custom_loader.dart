import 'package:flutter/material.dart';

abstract class CustomLoader {
  const CustomLoader._();

  static bool _isDialogOpen = false;
  static late NavigatorState _navigator;

  static init(NavigatorState navigator) => _navigator = navigator;

  static void display() async {
    if (_isDialogOpen) return;
    _isDialogOpen = true;
    await showDialog(
      context: _navigator.context,
      builder: (_) => widget(),
      barrierDismissible: false,
      useSafeArea: true,
    );
    _isDialogOpen = false;
  }

  static Widget widget([Color? color]) {
    return Center(child: CircularProgressIndicator(color: color));
  }

  static void remove() {
    if (!_isDialogOpen) return;
    _navigator.pop();
    _isDialogOpen = false;
  }
}
