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

  static bool getBool(String key, {bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs.getBool(key) ?? defValue;
  }

  static int getInt(String key, {int defValue = 0}) {
    if (_prefs == null) return defValue;
    return _prefs.getInt(key) ?? defValue;
  }

  static double getDouble(String key, {double defValue = 0.0}) {
    if (_prefs == null) return defValue;
    return _prefs.getDouble(key) ?? defValue;
  }

  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs.getString(key) ?? defValue;
  }

  static Future<bool> clear() {
    if (_prefs == null) return null;
    return _prefs.clear();
  }
}