import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_best_practice/routers/fluro_navigator.dart';
import 'package:flutter_best_practice/views/home/home_router.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void _initSplash() {
    Future.delayed(Duration(seconds: 5), () {
      NavigatorUtils.push(context, HomeRouter.homePage, replace: true);
    });
  }

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: const Text('每日精选，让你大开眼界'),
      )
    );
  }
}