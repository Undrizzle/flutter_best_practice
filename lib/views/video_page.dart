import 'package:flutter/material.dart';

import 'package:flutter_best_practice/models/VideoCategory.dart';
import 'package:flutter_best_practice/models/VideoCategoryList.dart';
import 'package:flutter_best_practice/utils/dio_util.dart';
import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/views/video/video_recommend_page.dart';
import 'package:flutter_best_practice/views/video/video_hot_page.dart';
import 'package:flutter_best_practice/views/video/video_small_video_page.dart';

class VideoPage extends StatefulWidget {
  @override 
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with TickerProviderStateMixin {
  TabController mTabController;
  List<VideoCategory> mTabList = List();

  @override
  void initState() {
    super.initState();
    mTabList.add(VideoCategory(id: 1, cname: '推荐'));
    mTabList.add(VideoCategory(id: 2, cname: '热门'));
    mTabList.add(VideoCategory(id: 3, cname: '小视频'));
    mTabController = TabController(length: mTabList.length, vsync: this);
    DioUtil.getInstance().requestHttp(Constant.GetVideoCategory, 'post', null, (data) {
      List<VideoCategory> mList = VideoCategoryList.fromJson(data['data']).data;
      setState(() {
        mTabList = mList;
        mTabController = TabController(length: mTabList.length, vsync: this);
      });
    }, (error) {
      print(error);
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 50,
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelColor: Color(0xfff78005),
                unselectedLabelColor: Color(0xff666666),
                labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                unselectedLabelStyle: TextStyle(fontSize: 16.0),
                indicatorSize: TabBarIndicatorSize.label,
                controller: mTabController,
                tabs: mTabList.map((value) {
                  return Text(value.cname);
                }).toList() 
              ),
            ),
            Container(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.only(top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: Color(0xffe4e2e8),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Center(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5, top: 2),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'find_top_search.png',
                              width: 12.0,
                              height: 15.0,
                            ),
                          ),
                          Text(
                            "大家都在搜：李文翰",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffee565656),
                            ),
                          ),
                        ],
                      )
                    ),
                  )
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                children: <Widget>[
                  VideoRecommendPage(),
                  VideoHotPage(),
                  VideoSmallVideoPage(),
                ],
                controller: mTabController,
              )
            )
          ],
        )
      ),
    );
  }
}