import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_best_practice/routers/application.dart';
import 'package:flutter_best_practice/routers/routers.dart';

// fluro路由跳转工具类
class NavigatorUtils {

  static push(BuildContext context, String path, {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  static pushResult(BuildContext context, String path, Function(Object) function, {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  // 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  // 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  // 跳到WebView页
  static goWebViewPage(BuildContext context, String title, String url) {
    // fluro不支持中文，需转换
    push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url={Uri.encodeComponent(url)}');
  }
}
