import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart' as fluro;

import 'package:flutter_best_practice/routers/routers.dart';
import 'package:flutter_best_practice/views/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 状态栏设置
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffffffff),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Color(0xffffffff),
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = fluro.Router();
    Routes.configureRoutes(router);
    Routes.router = router;

    return Container(
      child: MaterialApp(
        title: '微博',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white
        ),
        onGenerateRoute: Routes.router.generator,
        home: SplashPage(),
      ),
    );
  }
}
