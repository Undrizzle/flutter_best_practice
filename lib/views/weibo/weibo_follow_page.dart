import 'package:flutter/material.dart';

import 'package:flutter_best_practice/widgets/weibo_list_widget.dart';

class WeiboFollowPage extends StatefulWidget {
  @override
  _WeiboFollowPageState createState() => _WeiboFollowPageState();
}

class _WeiboFollowPageState extends State<WeiboFollowPage> {
  @override
  Widget build(BuildContext context) {
    return WeiboListWidget(mCatId: "0");
  }
}