import 'package:flutter/material.dart';

import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/models/VideoModel.dart';

class VideoHotPage extends StatefulWidget {
  @override 
  _VideoHotPageState createState() => _VideoHotPageState();
}

class _VideoHotPageState extends State<VideoHotPage> {
  bool isloadingMore = false;
  bool ishasMore = true;
  num mCurPage = 1;
  ScrollController mScrollController = ScrollController();
  List<VideoModel> mVideoList = [];
  List<String> mBannerAdList = [];

  @override 
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: RefreshIndicator(
        onRefresh: pullToRefresh,
        child: CustomScrollView(
          controller: mScrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            Constant.ASSETS_IMG + 'video_hot_top1.png',
                            width: 45.0,
                            height: 45.0,
                          ),
                          Text(
                            '排行榜',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            Constant.ASSETS_IMG + 'video_hot_type2.png',
                            width: 45.0,
                            height: 45.0,
                          ),
                          Text(
                            '每周必看',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            Constant.ASSETS_IMG + 'video_hot_type3.png',
                            width: 45.0,
                            height: 45.0,
                          ),
                          Text(
                            '宝藏博主',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            Constant.ASSETS_IMG + 'video_hot_type4.png',
                            width: 45.0,
                            height: 45.0,
                          ),
                          Text(
                            '更多频道',
                            style: TextStyle(
                              fontSize: 14, 
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == mVideoList.length + 1) {
                    return _buildLoadMore();
                  } else if (index == 0 || index == 1 || index == 2) {
                    if (mVideoList.length != 0) {
                      return getContentItem(context, mVideoList[index]);
                    } else {
                      return Container();
                    }
                  } else if (index == 3) {
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Container(
                        height: 120,
                        child: Swiper(
                          outer: false,
                          pagination: SwiperPagination(
                            builder: DotSwiperPaginationBuilder(
                              size: 7,
                              space: 5,
                              activeSize: 7,
                              color: Color(0xfff0f0f0),
                              activeColor: Color(0xffd8d8d8),
                            ),
                            margin: EdgeInsets.all(0)
                          ),
                          itemBuilder: (c, i) {
                            return mCenterBannerItemWidget(mBannerAdList[i]);
                          },
                          itemCount: mBannerAdList.length,
                        ),
                      ),
                    );
                  } else {
                    return getContentItem(context, mVideoList[index - 1]);
                  }
                },
                childCount: mVideoList.length + 2,
              ),
            ),
          ],
        ),
      ),
    );
  } 
}