import 'package:flutter/material.dart';

class SwitchProvider extends ChangeNotifier {
  bool _isOn = false;

  bool get isOn => _isOn;

  void toggleIsOn(bool newValue) {
    _isOn = newValue;
    notifyListeners();
  }
}
