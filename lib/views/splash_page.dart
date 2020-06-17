import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/utils/sp_util.dart';
import 'package:flutter_best_practice/routers/routers.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void _initSplash() {
    SpUtil.getInstance();
    Future.delayed(Duration(seconds: 5), () {
      //Navigator.pop(context);
      Routes.navigateTo(context, Routes.homePage, clearStack: true);
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'welcome_slogan.png',
                    width: 200.0,
                    height: 100.0,
                  ),
                ),
              ], 
            ),
          ) ,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'welcome_logo.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}