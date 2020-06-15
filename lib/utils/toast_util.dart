import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(String msgStr) {
    Fluttertoast.showToast(
      msg: msgStr,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff4b4b4b),
      textColor: Colors.white,
      fontSize: 13.0
    );
  }
}