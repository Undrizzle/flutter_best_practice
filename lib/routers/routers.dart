import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart' as fluro;

import 'package:flutter_best_practice/views/home_page.dart';
import 'package:flutter_best_practice/views/mine/login_page.dart';

class Routes {
  static fluro.Router router;
  static String homePage = '/homePage';
  static String loginPage = '/loginPage';

  static void configureRoutes(fluro.Router router) {
    // 指定路由跳转错误返回页
    router.notFoundHandler = fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('未找到目标页');
        return Container();
      }
    );

    router.define(homePage, handler: fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => HomePage()
    ));
    router.define(loginPage, handler: fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => LoginPage()
    ));
  }

  static Future navigateTo(BuildContext context, String path,
      {Map<String, dynamic> params, bool clearStack = false, fluro.TransitionType transition = fluro.TransitionType.fadeIn}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = '?';
        } else {
          query = query + '\&';
        }
        query += '$key=$value';
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');

    path = path + query;
    return router.navigateTo(context, path, clearStack: clearStack, transition: transition);
  }
}