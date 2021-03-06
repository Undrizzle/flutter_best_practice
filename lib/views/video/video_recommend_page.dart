import 'dart:convert' as convert;

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart' as fluro;

import 'package:flutter_best_practice/routers/routers.dart';
import 'package:flutter_best_practice/models/VideoModel.dart';
import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/utils/dio_util.dart';
import 'package:flutter_best_practice/utils/date_util.dart';

class VideoRecommendPage extends StatefulWidget {
  @override 
  _VideoRecommendPageState createState() => _VideoRecommendPageState();
}

class _VideoRecommendPageState extends State<VideoRecommendPage> {
  ScrollController mScrollController = ScrollController();
  List<VideoModel> mVideoList = [];
  num mCurPage = 1;
  bool isloadingMore = false;
  bool ishasMore = true;

  @override
  void initState() {
    super.initState();
    getVideoList(true);
    mScrollController.addListener(() {
      print("滑动到底部");
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

  getVideoList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params = FormData.fromMap({'pageNum': '$mCurPage', 'pageSize': '10'});
      DioUtil.getInstance().requestHttp(Constant.GetVideoRecommendList, 'post', params, (data) {
        List<VideoModel> list = List();
        data['data']['list'].forEach((data) {
          list.add(VideoModel.fromJson(data));
        });
        mVideoList = [];
        mVideoList = list;
        setState(() {});
      }, (error) {});
    } else {
      FormData params = FormData.fromMap({'pageNum': '$mCurPage', 'pageSize': '10'});
      DioUtil.getInstance().requestHttp(Constant.GetVideoRecommendList, 'post', params, (data) {
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
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      height: 12.0,
                      width: 12.0,
                    ),
                  ),
                  Text('加载中...'),
                ],
              )
            )
          )
        )
      : Container(
        child: ishasMore
            ? Container()
            : Center(
                child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    '没有更多数据了',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                )
            )
      );
  }

  Widget getContentItem(BuildContext context, VideoModel mModel) {
    return InkResponse(
      highlightColor: Colors.transparent,
      onTap: () {
        Routes.navigateTo(context, Routes.videoDetailPage,
            params: {
              'video': convert.jsonEncode(mModel),
            },
            transition: fluro.TransitionType.fadeIn);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage(Constant.ASSETS_IMG + 'img_default2.png'),
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
                          Container(
                            margin: EdgeInsets.only(left: 5, right: 3),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'video_play.png',
                              width: 15.0,
                              height: 15.0,
                            ),
                          ),
                          Text(
                            mModel.playnum.toString(),
                            style: TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Text(
                              DateUtil.getFormatTime4(mModel.videotime).toString(),
                              style: TextStyle(fontSize: 14.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 5),
            child: Text(
              mModel.introduce,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0, color: Colors.black)
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    (mModel.recommengstr == "null")
                        ? ((mModel.tag == "null")
                            ? Container()
                            : Text(
                                mModel.tag.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black
                                )
                              )
                          )
                        :
                          Container(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              mModel.recommengstr,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.orange
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              color: Color(0xfffef5e2),
                            ),
                          ),
                  ],
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 3),
                  child: Image.asset(
                    Constant.ASSETS_IMG + 'video_ver_more.png',
                    width: 15.0,
                    height: 15.0,
                  )
                )
              ],
            )
          )
        ]
      )
    );
  }

  @override 
  Widget build(BuildContext context) {
    final double mGridItemWidth = MediaQuery.of(context).size.width / 2;
    final double mGridItemHeight = 200;

    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: RefreshIndicator(
        onRefresh: () async { getVideoList(true); },
        child: CustomScrollView(
          controller: mScrollController,
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: (mGridItemWidth / mGridItemHeight),
                crossAxisCount: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return getContentItem(context, mVideoList[index]);
                },
                childCount: mVideoList.length
              ),
            ),
            SliverToBoxAdapter(
              child: _buildLoadMore(),
            )
          ]
        ),
      ),
    );
  } 
}