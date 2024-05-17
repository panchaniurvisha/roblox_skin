import 'package:flutter/material.dart';

class RobloxskinMainJson extends ChangeNotifier {
  Map? _data;
  String? _version;
  static ValueNotifier<Map?> dataNotifier = ValueNotifier(null);

  Map? get data => _data;

  String? get version => _version;

  set data(Map? value) {
    _data = value;
    dataNotifier.value = value;
    notifyListeners();
  }

  set version(String? value) {
    _version = value;
    notifyListeners();
  }
}
