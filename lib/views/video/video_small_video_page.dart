import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:flutter_best_practice/models/VideoModel.dart';
import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/utils/dio_util.dart';
import 'package:flutter_best_practice/utils/date_util.dart';

class VideoSmallVideoPage extends StatefulWidget {
  @override 
  _VideoSmallVideoPageState createState() => _VideoSmallVideoPageState();
}

class _VideoSmallVideoPageState extends State<VideoSmallVideoPage> {
  bool isloadingMore = false;
  bool ishasMore = true;
  num mCurPage = 1;
  ScrollController mScrollController = ScrollController();
  List<VideoModel> mVideoList = [];

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

  void getVideoList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params = FormData.fromMap({'pageNum': '$mCurPage', 'pageSize': '10'});
      DioUtil.getInstance().requestHttp(Constant.GetVideoSmallList, 'post', params, (data) {
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
      DioUtil.getInstance().requestHttp(Constant.GetVideoSmallList, 'post', params, (data) {
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
            padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                    )
                  ),
                  Text('加载中...'),
                ],
              )
            ),
          )
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
                ),
            ),
        );
  }

  Widget getContentItem(BuildContext context, VideoModel mModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage(Constant.ASSETS_IMG + 'img_default2.png'),
                image: NetworkImage(mModel.coverimg)
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
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Image.asset(
                        Constant.ASSETS_IMG + 'video_play.png',
                        width: 15.0,
                        height: 15.0,
                      ),
                    ),
                    Text(
                      mModel.playnum.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white
                      )
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        DateUtil.getFormatTime4(mModel.videotime).toString(),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white
                        )
                      ),
                    )
                  ],
                )
              )
            )
          )
        ]
      )
    );
  }

  @override 
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double mGridItemHeight = 200;
    final double mGridItemWidth = size.width / 2;

    return Container(
      padding: EdgeInsets.only(top: 15),
      child: RefreshIndicator(
        onRefresh: () async { getVideoList(true); },
        child: CustomScrollView(
          controller: mScrollController,
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: mGridItemWidth / mGridItemHeight,
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
            ),
          ],
        )
      ),
    );
  } 
}