import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fluro/fluro.dart';

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
    final router = Router();
    Routes.configureRoutes(router);
    Routes.router = router;

    return OKToast(
      child: MaterialApp(
        title: '微博',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        onGenerateRoute: Routes.router.generator,
        home: SplashPage(),
      ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      dismissOtherOnShow: true,
    );
  }
}
