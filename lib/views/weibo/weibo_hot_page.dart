import 'package:flutter/material.dart';

import 'package:flutter_best_practice/widgets/weibo_list_widget.dart';

class WeiboHotPage extends StatefulWidget {
  @override
  _WeiboHotPageState createState() => _WeiboHotPageState();
}

class _WeiboHotPageState extends State<WeiboHotPage> {
  final List<String> _tabValues = ['热门', '同城', '榜单', '历史', '科技', '运动健身', '汽车', '搞笑', '电影愿', '财经', '社会', '房产', '股市', '军事'];
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _tabValues.length,
      vsync: ScrollableState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 0.5,
            color: Color(0xffbecbc2),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: 45,
                color: Color(0xffffffff),
                alignment: Alignment.center,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Color(0xffffffff),
                  labelColor: Color(0xffff3700),
                  unselectedLabelColor: Color(0xff666666),
                  labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  unselectedLabelStyle: TextStyle(fontSize: 16.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _controller,
                  tabs: _tabValues.map((_tabValue) => Tab(text: _tabValue)).toList(),
                ),
              ),
            ],
          ),
          Container(
            height: 0.5,
            color: Color(0xffbecbc2),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                WeiboListWidget(mCatId: "1"),
                WeiboListWidget(mCatId: "2"),
                WeiboListWidget(mCatId: "3"),
                WeiboListWidget(mCatId: "4"),
                WeiboListWidget(mCatId: "5"),
                WeiboListWidget(mCatId: "6"),
                WeiboListWidget(mCatId: "7"),
                WeiboListWidget(mCatId: "8"),
                WeiboListWidget(mCatId: "9"),
                WeiboListWidget(mCatId: "10"),
                WeiboListWidget(mCatId: "11"),
                WeiboListWidget(mCatId: "12"),
                WeiboListWidget(mCatId: "13"),
                WeiboListWidget(mCatId: "14"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
