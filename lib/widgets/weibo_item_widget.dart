import 'package:flutter/material.dart';

import 'package:flutter_best_practice/models/WeiboModel.dart';

class WeiboItemWidget extends StatelessWidget {
  WeiboModel mModel;
  bool isDetail;

  WeiboItemWidget(WeiboModel data, bool isDetail) {
    mModel = data;
    isDetail = isDetail;
  }

  @override 
  Widget build(BuildContext context) {
    return Center(child: Text('item'));
  }
}