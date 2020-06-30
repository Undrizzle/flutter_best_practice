import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_best_practice/models/WeiboModel.dart';

import 'package:flutter_best_practice/widgets/loading_container.dart';
import 'package:flutter_best_practice/widgets/weibo_detail_widget.dart';
import 'package:flutter_best_practice/widgets/weibo_item_widget.dart';
import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/utils/dio_util.dart';
import 'package:flutter_best_practice/utils/user_util.dart';
import 'package:flutter_best_practice/models/WeiboListModel.dart';

class WeiboListWidget extends StatefulWidget {
  final String mCatId;

  WeiboListWidget({Key key, @required this.mCatId}) : super(key: key);

  @override 
  _WeiboListWidgetState createState() => _WeiboListWidgetState();
}

class _WeiboListWidgetState extends State<WeiboListWidget> with AutomaticKeepAliveClientMixin {
  bool isRefreshLoading = true;
  bool isLoadingMore = false;
  bool isHasMore = true;
  num mCurPage = 1;
  List<WeiboModel> contentList = [];
  ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override 
  void initState() {
    super.initState();
    getSubDataRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('调用加载更多');
        if (!isLoadingMore) {
          if (isHasMore) {
            setState(() {
              isLoadingMore = true;
              mCurPage = 1;
            });
            getSubDataLoadMore(mCurPage);
          } else {
            print('没有更多数据了');
            setState(() {
              isHasMore = false;
            });
          }
        }
      }
    });
  }

  @override 
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> getSubDataRefresh() async {
    isLoadingMore = false;
    isHasMore = true;
    mCurPage = 1;

    FormData formData = FormData.fromMap({
      "catid": widget.mCatId,
      "pageNum": "1",
      "pageSize": Constant.PAGE_SIZE,
      "userId": UserUtil.getUserInfo().id,
    });

    await DioUtil.getInstance().requestHttp(Constant.GetWeibo, 'post', formData, (data) {
      print(data);
      WeiboListModel category = WeiboListModel.fromJson(data);
      contentList.clear();
      contentList.addAll(category.data.list);
      setState(() {
        isRefreshLoading = false;
      });
    }, (error) {
      print("接口异常：" + error.toString());
      setState(() {
        isRefreshLoading = false;
      });
    });
  }

  Future<void> getSubDataLoadMore(int page) async {
    FormData formData = FormData.fromMap({
      "catid": widget.mCatId,
      "pageNum": page,
      "pageSize": Constant.PAGE_SIZE,
      'userId': UserUtil.getUserInfo().id,
    });
    List<WeiboModel> mListRecords = List();
    await DioUtil.getInstance().requestHttp(Constant.GetWeibo, 'POST', formData, (data) {
      WeiboListModel category = WeiboListModel.fromJson(data);
      mListRecords = category.data.list;
      setState(() {
        contentList.addAll(mListRecords);
        isLoadingMore = false;
        isHasMore = mListRecords.length >= Constant.PAGE_SIZE;
      });
    }, (error) {
      setState(() {
        isLoadingMore = false;
        isHasMore = false;
      });
    });
  }

  Widget _buildLoadMore() {
    return isLoadingMore 
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
                    ),
                  ),
                  Text('加载中...'),
                ],
              ),
            ),
          ),
        )
      : Container(
          child: isHasMore 
            ? Container()
            : Center(
                child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    '没有更多数据了',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              )
        );  
  }

  Widget getContentItem(BuildContext context, int index, List<WeiboModel> mList) {
    WeiboModel model = mList[index];
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return WeiboDetailWidget(mModel: model);
        }));
      },
      child: WeiboItemWidget(model, false),
    );
  }

  @override 
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: isRefreshLoading,
        child: RefreshIndicator(
          onRefresh: getSubDataRefresh,
          child: ListView.builder(
            itemCount: contentList.length + 1,
            itemBuilder: (context, index) {
              if (index == contentList.length) {
                return _buildLoadMore();
              } else {
                return getContentItem(context, index, contentList);
              }
            },
            controller: _scrollController,
          )
        )
      )
    );
  }

}