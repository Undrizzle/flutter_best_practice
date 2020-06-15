import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';


class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  static Future<bool> clear() {
    if (_prefs == null) return null;
    return _prefs.clear();
  }
}