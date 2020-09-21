import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/models/VideoModel.dart';
import 'package:flutter_best_practice/utils/dio_util.dart';
import 'package:flutter_best_practice/utils/date_util.dart';

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
  void initState() {
    super.initState();
    getVideoList(true);
    mScrollController.addListener(() {
      var maxScroll = mScrollController.position.maxScrollExtent;
      var pixels = mScrollController.position.pixels;
      if (maxScroll == pixels) {
        if (!isloadingMore) {
          if (ishasMore) {
            setState(() {
              isloadingMore = true;
              mCurPage += 1;
            });
            Future.delayed(Duration(seconds: 3), () {
              getVideoList(false);
            });
          } else {
            setState(() {
              ishasMore = false;
            });
          }
        }
      }
    });
  }

  void getVideoList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params = FormData.fromMap({'pageNum': '$mCurPage', 'pageSize': '10'});
      DioUtil.getInstance().requestHttp(Constant.GetVideoHotList, 'post', params, (data) {
        List<VideoModel> list = List();
        data['data']['list'].forEach((data) {
          list.add(VideoModel.fromJson(data));
        });
        mVideoList = [];
        mVideoList = list;
        setState(() {});
      }, (error) {});

      DioUtil.getInstance().requestHttp(Constant.GetVideoHotBannerAdList, 'post', params, (data) {
        List<String> list = List();
        data['data'].forEach((data) {
          list.add(data.toString());
        });
        mBannerAdList = [];
        mBannerAdList = list;
        setState(() {});
      }, (error) {});
    } else {
      FormData params = FormData.fromMap({'pageNum': '$mCurPage', 'pageSize': '10'});
      DioUtil.getInstance().requestHttp(Constant.GetVideoHotList, 'post', params, (data) {
        List<VideoModel> list = List();
        data['data']['list'].forEach((data) {
          list.add(VideoModel.fromJson(data));
        });
        mVideoList.addAll(list);
        isloadingMore = false;
        ishasMore = list.length >= Constant.PAGE_SIZE;
        setState(() {});
      }, (error) {
        setState(() {
          isloadingMore = false;
          ishasMore = false;
        });
      });
    }
  }

  Widget _buildLoadMore() {
    return isloadingMore
      ? Container(
          child: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: SizedBox(
                      child: CircularProgressIndicator(strokeWidth: 2),
                      height: 12.0,
                      width: 12.0,
                    ),
                  ),
                  Text('加载中...'),
                ],
              )
            ),
          ),
        )
      : Container(
          child: ishasMore
            ? Container()
            : Center(
                child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    '没有更多数据',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                )
              ),
        );  
  }

  Widget getContentItem(BuildContext context, VideoModel mModel) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 100,
            width: MediaQuery.of(context).size.width * 3 / 8,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 3 /8,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage(Constant.ASSETS_IMG + 'img_default.png'),
                      image: NetworkImage(mModel.coverimg),
                    ),
                  ),
                ),
                Positioned(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              DateUtil.getFormatTime4(mModel.videotime).toString(),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white
                              ),
                            ),
                          )
                        ],
                      )
                    )
                  )
                )
              ],
            )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  child: Text(
                    mModel.introduce,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(2),
                  child: Text(
                    mModel.recommengstr,
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xfffb9213)
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color(0xfffef5e2),
                  ),
                ),
                Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text(
                      '@' + mModel.username,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey
                      ),
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          mModel.playnum.toString(),
                          style: TextStyle(
                            fontSize: 13, 
                            color: Colors.grey
                          ),
                        ),
                      ), 
                      Container(
                        child: Text(
                          '次观看 • ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Center(
                          child: Text(
                            DateUtil.getFormatTime(DateTime.fromMicrosecondsSinceEpoch(mModel.createtime)).toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey
                            ),
                          )
                        )
                      )
                    ],
                  )
                )
              ],
            )
          )
        ]
      )
    );
  }

  Widget mCenterBannerItemWidget(String mUrl) {
    return Container(
      child: ClipRRect(
        child: FadeInImage.assetNetwork(
          placeholder: Constant.ASSETS_IMG + 'img_default2.png', 
          image: mUrl,
        )
      )
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: RefreshIndicator(
        onRefresh: () async { getVideoList(true); },
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
                    if (mVideoList.isNotEmpty) {
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