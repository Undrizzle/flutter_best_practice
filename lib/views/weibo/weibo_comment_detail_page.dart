import 'package:flutter/material.dart';

import 'package:flutter_best_practice/models/WeiboDetail.dart';

class WeiboCommentDetailPage extends StatefulWidget {
  final Comment mCommentTop;

  WeiboCommentDetailPage(this.mCommentTop);

  @override
  _WeiboCommentDetailPageState createState() => _WeiboCommentDetailPageState();
}

class _WeiboCommentDetailPageState extends State<WeiboCommentDetailPage> {
  @override 
  Widget build(BuildContext context) {
    return Text('评论详细页');
  }
}