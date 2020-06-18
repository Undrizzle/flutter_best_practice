import 'package:flutter/material.dart';

import 'package:flutter_best_practice/views/weibo/weibo_follow_page.dart';
import 'package:flutter_best_practice/views/weibo/weibo_hot_page.dart';

class WeiboPage extends StatefulWidget {
  @override 
  _WeiboPageState createState() => _WeiboPageState();
}

class _WeiboPageState extends State<WeiboPage> with AutomaticKeepAliveClientMixin {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: TabBarWidget())
        ],
      ),
    );
  }

  @override 
  bool get wantKeepAlive => true;
}

TabController _controller;

class TabBarWidget extends StatefulWidget {
  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  final List<String> _tabValues = [
    '关注',
    '热门',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _tabValues.length,
      vsync: ScrollableState()
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 50,
                  color: Color(0xfff9f9f9),
                  alignment: Alignment.center,
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Color(0xffff3700),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Color(0xffff3700), width: 2),
                      insets: EdgeInsets.only(bottom: 7)
                    ),
                    labelColor: Color(0xff333333),
                    unselectedLabelColor: Color(0xff666666),
                    labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: TextStyle(fontSize: 16.0),
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _controller,
                    tabs: [
                      Tab(text: _tabValues[0]),
                      Tab(text: _tabValues[1])
                    ]
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Image.asset("assets/images/ic_main_add.png", width: 40.0, height: 40.0),
                      onPressed: () {
                        },
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[WeiboFollowPage(), WeiboHotPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}