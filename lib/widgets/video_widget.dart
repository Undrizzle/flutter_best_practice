import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'package:flutter_best_practice/constant/constant.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final String previewImgUrl;
  final bool showProgressText;

  VideoWidget({
    Key key,
    this.url,
    this.previewImgUrl,
    this.showProgressText = true
  }) : super(key: key);

  _VideoWidgetState state;

  @override 
  State<StatefulWidget> createState() {
    state = _VideoWidgetState();
    return state;
  }

  updateUrl(String url) {
    state.setUrl(url);
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  VoidCallback listener;
  bool _showSeekBar = true;

  _VideoWidgetState() {
    listener = () {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  void initState() {
    super.initState();
    print('播放${widget.url}');
    _controller = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
            if (_controller.value.duration == _controller.value.position) {
              _controller.seekTo(Duration(seconds: 0));
              setState(() {});
            }
          }
        });
    _controller.setLooping(true);
    _controller.addListener(listener);
  }

  @override 
  void deactivate() {
    _controller.removeListener(listener);
    super.deactivate();
  }

  @override 
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget getPreviewImg() {
    return Image.network("https://ww4.sinaimg.cn/bmiddle/c5f4f0ecgy1g2pix22tf0j20c80hq1du.jpg");
  }

  String getMinuteSeconds(var inSeconds) {
    if (inSeconds == null || inSeconds <= 0) {
      return '00:00';
    }
    var tmp = inSeconds ~/ Duration.secondsPerMinute;
    var minute;
    if (tmp < 10) {
      minute = '0$tmp';
    } else {
      minute = '$tmp';
    }

    var tmp1 = inSeconds % Duration.secondsPerMinute;
    var seconds;
    if (tmp1 < 10) {
      seconds = '0$tmp1';
    } else {
      seconds = '$tmp1';
    }
    return '$minute:$seconds';
  }

  Widget getDurationText() {
    var txt;
    if (_controller.value.position == null || _controller.value.duration == null) {
      txt = '00:00';
    } else {
      txt = '${getMinuteSeconds(_controller.value.duration.inSeconds - _controller.value.position.inSeconds)}';
    }
    return Container(
      margin: EdgeInsets.only(bottom: 8, right: 8),
      child: Text(
        '$txt',
        style: TextStyle(
          color: Colors.white, 
          fontSize: 14.0
        ),
      )
    );
  }

  Widget getProgressContent() {
    return widget.showProgressText
      ? Align(
          alignment: Alignment.bottomRight,
          child: Offstage(
            child: getDurationText(),
            offstage: !widget.showProgressText,
          )
        )
      : Container();  
  }

  Widget getPlayController() {
    return Offstage(
      offstage: !_showSeekBar,
      child: Stack(
        children: <Widget>[
          Align(
            child: _controller.value.isPlaying
                ? null
                : IconButton(
                    iconSize: 45.0,
                    icon: Image.asset(Constant.ASSETS_IMG + 'ic_playing.png'),
                    onPressed: () {
                        _controller.play();
                    },
                  ),
            alignment: Alignment.center,
          ),
          getProgressContent(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Center(
              child: _controller.value.isBuffering
                ? CircularProgressIndicator()
                : null
            )
          )
        ]
      )
    );
  }

  @override 
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      GestureDetector(
        child: VideoPlayer(_controller),
        onTap: () {
          setState(() {
            _showSeekBar = !_showSeekBar;
          });
        },
      ),
      getPlayController(),
    ];

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        fit: StackFit.passthrough,
        children: children,
      ),
    );
  }

  void setUrl(String url) {
    if (mounted) {
      print('updateUrl');
      if (_controller != null) {
        _controller.removeListener(listener);
        _controller.pause();
      }
      _controller = VideoPlayerController.network(url)
          ..initialize().then((_) {
            setState(() {});
            if (_controller.value.duration == _controller.value.position) {
              _controller.seekTo(Duration(seconds: 0));
              setState(() {});
            }
          });
      _controller.addListener(listener);    
    }
  }
}