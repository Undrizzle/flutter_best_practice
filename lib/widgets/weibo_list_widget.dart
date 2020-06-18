import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:flutter_best_practice/widgets/loading_container.dart';
import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/utils/dio_util.dart';
import 'package:flutter_best_practice/utils/user_util.dart';

class WeiboListWidget extends StatefulWidget {
  String mCatId = '';

  WeiboListWidget({Key key, @required this.mCatId}) : super(key: key);

  @override 
  _WeiboListWidgetState createState() => _WeiboListWidgetState();
}

class _WeiboListWidgetState extends State<WeiboListWidget> with AutomaticKeepAliveClientMixin {
  bool isRefreshLoading = true;
  bool isLoadingMore = false;
  bool isHasMore = true;
  num mCurPage = 1;

  @override
  bool get wantKeepAlive => true;

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

    await DioUtil.getInstance().requestHttp(Constant.GetWeibo, 'POST', formData, (data) {

    }, (error) {

    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: isRefreshLoading,
        child: RefreshIndicator(
          onRefresh: getSubDataRefresh,
        )
      )
    );
  }

}