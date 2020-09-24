import 'package:flutter/material.dart';

class WeiboCommentDialogPage extends StatefulWidget {
  final String mWeiboOrCommentId;
  final bool isReplyWeibo;
  final Function() notifyParent;

  WeiboCommentDialogPage(this.mWeiboOrCommentId, this.isReplyWeibo, this.notifyParent);

  @override
  _WeiboCommentDialogPageState createState() => _WeiboCommentDialogPageState();
}

class _WeiboCommentDialogPageState extends State<WeiboCommentDialogPage> {
  @override 
  Widget build(BuildContext context) {
    return Text('评论对话框页');
  }
}