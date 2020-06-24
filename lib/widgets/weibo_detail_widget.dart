import 'package:flutter/material.dart';

import 'package:flutter_best_practice/models/WeiboModel.dart';

class WeiboDetailWidget extends StatefulWidget {
  final WeiboModel mModel;

  WeiboDetailWidget({Key key, this.mModel}) : super(key: key);

  @override
  _WeiboDetailWidgetState createState() => _WeiboDetailWidgetState();
}

class _WeiboDetailWidgetState extends State<WeiboDetailWidget> {
  @override 
  Widget build(BuildContext context) {
    return Center(child: Text('detail'));
  }
}