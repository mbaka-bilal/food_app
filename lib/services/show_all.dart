import 'package:flutter/material.dart';

class ShowAll extends ChangeNotifier {
  bool _hide = false;

  bool fetchStatus() {
    return _hide;
  }

  void updateStatus() {
    _hide = !_hide;
    notifyListeners();
  }
}
