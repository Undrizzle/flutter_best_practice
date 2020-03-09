import 'package:flutter/material.dart';

class BaseProvider<T> extends ChangeNotifier {
  T _instance;

  T get instance => _instance;

  void setData(T newData) {
    _instance = newData;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}