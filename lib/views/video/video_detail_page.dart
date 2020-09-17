import 'package:flutter/material.dart';

import 'package:flutter_best_practice/models/VideoModel.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel mVideo;

  VideoDetailPage(this.mVideo);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override 
  Widget build(BuildContext context) {
    return Text('视频详细页面');
  }
}