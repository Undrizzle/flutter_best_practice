import 'dart:convert' as convert;

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_best_practice/models/WeiboDetail.dart';
import 'package:flutter_best_practice/models/CommentList.dart';
import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/routers/routers.dart';
import 'package:flutter_best_practice/utils/dio_util.dart';
import 'package:flutter_best_practice/utils/date_util.dart';
import 'package:flutter_best_practice/views/weibo/weibo_comment_dialog_page.dart';

class VideoDetailCommentPage extends StatefulWidget {
  @override
  _VideoDetailCommentPageState createState() => _VideoDetailCommentPageState();
}

ScrollController mCommentScrollController = ScrollController();
List<Comment> mCommentList = [];
bool isCommentloadingMore = false;
bool isCommenthasMore = true;
num mCommentCurPage = 1;

class _VideoDetailCommentPageState extends State<VideoDetailCommentPage> {
  @override
  void initState() {
    super.initState();
    mCommentScrollController.addListener(() {
      if (mCommentScrollController.position.pixels == mCommentScrollController.position.maxScrollExtent) {
        if (!isCommentloadingMore) {
          if (isCommenthasMore) {
            setState(() {
              isCommentloadingMore = true;
              mCommentCurPage += 1;
            });
            Future.delayed(Duration(seconds: 3), () {
              getCommentDataLoadMore(mCommentCurPage, "1");
            });
          } else {
            setState(() {
              isCommenthasMore = false;
            });
          }
        }
      }
    });
    getCommentDataLoadMore(mCommentCurPage, "1");
  }

  void getCommentDataLoadMore(int page, String weiboId) {
    FormData formData = FormData.fromMap({"pageNum": page, "pageSize": Constant.PAGE_SIZE, "weiboid": weiboId});
    DioUtil.getInstance().requestHttp(Constant.GetVideoRecommendList, "post", formData, (data) {
      CommentList mComment = CommentList.fromJson(data['data']);
      setState(() {
        mCommentList.addAll(mComment.list);
        isCommentloadingMore = false;
        isCommenthasMore = mComment.list.length >= Constant.PAGE_SIZE;
      });
    }, (error) {
      setState(() {
        isCommentloadingMore = false;
        isCommenthasMore = false;
      });
    });
  }

  Widget mCommentItem(BuildContext context, int index) {
    if (index == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15, top: 10, bottom: 10),
            alignment: Alignment.centerRight,
            child: Row(
              children: <Widget>[
                Image.asset(
                  Constant.ASSETS_IMG + 'weibo_comment_shaixuan.png',
                  width: 15.0,
                  height: 17.0,
                ),
                Container(
                  child: Text(
                    '按热度',
                    style: TextStyle(
                      color: Color(0xff596d86), 
                      fontSize: 12
                    )
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    if (index == mCommentList.length + 1) {
      return buildCommentLoadMore();
    }

    Widget mCommentReplyWidget;
    if (mCommentList[index - 1].commentreplynum == 0) {

    } else if (mCommentList[index - 1].commentreplynum == 1) {
      mCommentReplyWidget = Container(
        padding: EdgeInsets.all(5),
        child: RichText(
          text: TextSpan(
            text: mCommentList[index - 1].commentreply[0].fromuname + ': ',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xff45587e),
            ),
            children: <TextSpan>[
              TextSpan(
                text: mCommentList[index - 1].commentreply[0].content,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xff333333)
                )
              )
            ]
          )
        )
      );
    } else if (mCommentList[index - 1].commentreplynum == 2) {
      mCommentReplyWidget = Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: RichText(
                text: TextSpan(
                  text: mCommentList[index - 1].commentreply[0].fromuname + ': ',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xff45587e)
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: mCommentList[index - 1].commentreply[0].content,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xff333333)
                      )
                    )
                  ]
                )
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              child: RichText(
                text: TextSpan(
                  text: mCommentList[index - 1].commentreply[1].fromuname + ': ',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xff45587e)
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: mCommentList[index - 1].commentreply[1].content,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xff333333)
                      )
                    )
                  ]
                )
              )
            )
          ],
        )
      );
    } else {
      mCommentReplyWidget = Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: RichText(
                text: TextSpan(
                  text: mCommentList[index - 1].commentreply[0].fromuname + ': ',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xff45587e)
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: mCommentList[index - 1].commentreply[0].content,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xff333333)
                      )
                    )
                  ]
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              child: RichText(
                text: TextSpan(
                  text: mCommentList[index - 1].commentreply[1].fromuname + ': ',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xff333333)
                  )
                )
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Row(
                children: <Widget>[
                  Text(
                    '共' + mCommentList[index - 1].commentreplynum.toString() + '条回复 >',
                    style: TextStyle(
                      color: Color(0xff45587e),
                      fontSize: 12
                    )
                  )
                ],
              )
            )
          ],
        )
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: mCommentList[index - 1].fromuserisvertify == 0
                    ? Container(
                        width: 35.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(mCommentList[index - 1].fromhead),
                            fit: BoxFit.cover
                          ),
                        ),
                      )
                    : Stack(
                        children: <Widget>[
                          Container(
                            width: 35.0,
                            height: 35.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: NetworkImage(mCommentList[index -1].fromhead),
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              child: Image.asset(
                                (mCommentList[index - 1].fromuserisvertify == 1)
                                  ? Constant.ASSETS_IMG + 'home_vertify.webp'
                                  : Constant.ASSETS_IMG + 'home_vertify2.webp',
                                width: 15.0,
                                height: 15.0,  
                              )
                            )
                          )
                        ],
                    )  
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        child: Text(
                          mCommentList[index - 1].fromuname,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: mCommentList[index - 1].fromuserismember == 0 ? Color(0xff636363) : Color(0xfff86119)
                          )
                        )
                      )
                    ),
                    Center(
                      child: mCommentList[index - 1].fromuserismember == 0
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Image.asset(
                                Constant.ASSETS_IMG + 'home_member.webp',
                                width: 15.0,
                                height: 15.0,
                              )
                            )
                    )
                  ],
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      Routes.navigateTo(context, Routes.weiboCommentDetailPage,
                          params: {
                            'comment': convert.jsonEncode(mCommentList[index - 1]),
                          }, transition: TransitionType.fadeIn);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Text(
                            mCommentList[index - 1].content,
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 13
                            )
                          )
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xfff7f7f7),
                            borderRadius: BorderRadius.all(Radius.circular(4.0))
                          ),
                          margin: EdgeInsets.only(top: mCommentList[index - 1].commentreplynum == 0 ? 0 : 5, right: 15),
                          child: mCommentReplyWidget,
                        )
                      ],
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          DateUtil.getFormatTime2(DateTime.fromMicrosecondsSinceEpoch(mCommentList[index - 1].createtime)).toString(),
                          style: TextStyle(
                            color: Color(0xff909090),
                            fontSize: 11
                          )
                        )
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'icon_retweet.png',
                              width: 15.0,
                              height: 15.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'icon_comment.png',
                              width: 15.0,
                              height: 15.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Image.asset(
                              Constant.ASSETS_IMG + 'icon_like.png',
                              width: 15.0,
                              height: 15.0,
                            )
                          )
                        ]
                      )
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  height: 0.5,
                  color: Color(0xffe6e4e3)
                )
              ],
            )
          )
        ],
      )
    );
  }

  Widget buildCommentLoadMore() {
    return isCommentloadingMore
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
          )
      )
    : Container(
        child: isCommenthasMore
          ? Container()
          : Center(
              child: Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  '没有更多数据',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  )
                ),
              )
            )
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 50),
            child: ListView.builder(
              controller: mCommentScrollController,
              padding: EdgeInsets.all(0.0),
              itemBuilder: (BuildContext context, int index) {
                return mCommentItem(context, index);
              },
              itemCount: mCommentList.isEmpty ? 1 : mCommentList.length + 2,
            ),
          ),
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                color: Colors.white,
                height: 50,
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return WeiboCommentDialogPage("1", true, () {
                            mCommentScrollController.animateTo(
                              .0,
                              duration: Duration(microseconds: 100),
                              curve: Curves.ease
                            );
                            getCommentDataLoadMore(mCommentCurPage, "1");
                          });
                        }
                      ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffe4e2e8),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '说点什么',
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
                  ),
                )
              )
            )
          )
        ],
      )
    );
  }
}