import 'package:flutter/material.dart';

import 'package:flutter_best_practice/utils/toast_util.dart';
import 'package:flutter_best_practice/views/weibo_page.dart';
import 'package:flutter_best_practice/views/video_page.dart';
import 'package:flutter_best_practice/views/find_page.dart';
import 'package:flutter_best_practice/views/message_page.dart';
import 'package:flutter_best_practice/views/mine_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;
  var appBarTitles = ['微博', '视频', '发现', '消息', '我'];
  var currentPage;
  var tabImages;
  DateTime lastPopTime;

  final List<Widget> tabBodies = [
    WeiboPage(),
    VideoPage(),
    FindPage(),
    MessagePage(),
    MinePage()
  ];

  Image getTabImage(path) {
    return Image.asset(path, width: 25.0, height: 25.0);
  }

  void initData() {
    tabImages = [
      [
        getTabImage('assets/images/tabbar_index.png'),
        getTabImage('assets/images/tabbar_index_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_video.png'),
        getTabImage('assets/images/tabbar_video_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_find.png'),
        getTabImage('assets/images/tabbar_find_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_message.png'),
        getTabImage('assets/images/tabbar_message_highlighted.png')
      ],
      [
        getTabImage('assets/images/tabbar_mine.png'),
        getTabImage('assets/images/tabbar_mine_highlighted.png')
      ],
    ];
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return Text(
        appBarTitles[curIndex],
        style: TextStyle(fontSize: 13.0, color: Colors.black)
      );
    } else {
      return Text(
        appBarTitles[curIndex],
        style: TextStyle(fontSize: 13.0, color: Colors.black)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();
    final bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
      BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
      BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
      BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
      BottomNavigationBarItem(icon: getTabIcon(4), title: getTabTitle(4)),
    ];

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _tabIndex,
            items: bottomTabs,
            onTap: (index) async {
              setState(() {
                _tabIndex = index;
                currentPage = tabBodies[_tabIndex];
              });
            },
          ),
          body: SafeArea(
            child: IndexedStack(
              index: _tabIndex,
              children: tabBodies,
            ),
          ),
        ),
        onWillPop: () async {
          if (lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
            lastPopTime = DateTime.now();
            ToastUtil.show('再按一次退出应用');
            return false;
          } else {
            lastPopTime = DateTime.now();
            return true;
          }
        },
    );
  }
}