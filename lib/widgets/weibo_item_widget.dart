import 'package:flutter/material.dart';

import 'package:flutter_best_practice/models/WeiboModel.dart';
import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/utils/date_util.dart';
import 'package:flutter_best_practice/widgets/text/match_text.dart';
import 'package:flutter_best_practice/widgets/text/parsed_text.dart';
import 'package:flutter_best_practice/widgets/video_widget.dart';

class WeiboItemWidget extends StatelessWidget {
  final WeiboModel mModel;
  final bool isDetail;

  WeiboItemWidget(this.mModel, this.isDetail);

  @override 
  Widget build(BuildContext context) {
    return _wholeItemWidget(context, mModel, isDetail);
  }
}

Widget _wholeItemWidget(BuildContext context, WeiboModel weiboItem, bool isDetail) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _authorRow(context, weiboItem),
        _textContent(context, weiboItem.content, isDetail),
        _mVedioLayout(context, weiboItem.vediourl),
      ]
    )
  );
}

Widget _authorRow(BuildContext context, WeiboModel weiboItem) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 2.0),
    child: Row(
      children: <Widget>[
        InkWell(
          onTap: () {

          },
          child: Container(
            margin: EdgeInsets.only(right: 5.0),
            child: weiboItem.userInfo.isvertify == 0
              ? Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: NetworkImage(weiboItem.userInfo.headUrl),
                      fit: BoxFit.cover
                    ),
                  ),
                )
              : Stack(
                  children: <Widget>[
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: NetworkImage(weiboItem.userInfo.headUrl),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        child: Image.asset(
                          weiboItem.userInfo.isvertify == 1
                            ? Constant.ASSETS_IMG + 'home_vertify.webp'
                            : Constant.ASSETS_IMG + 'home_vertify2.webp',
                          width: 15.0,
                          height: 15.0,  
                        ),
                      ),
                    ),
                  ],
              ),  
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                    child: Text(
                      weiboItem.userInfo.nick,
                      style: TextStyle(fontSize: 15.0, color: weiboItem.userInfo.ismember == 0 ? Colors.black : Color(0xfff86119))
                    ),
                  ),
                ),
                Center(
                  child: weiboItem.userInfo.ismember == 0
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: Image.asset(
                          Constant.ASSETS_IMG + 'home_memeber.webp',
                          width: 15.0,
                          height: 13.0,
                        ),
                      ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(6.0, 2.0, 0.0, 0.0),
              child: weiboItem.tail.isEmpty
                ? Text(
                    weiboItem.userInfo.decs,
                    style: TextStyle(color: Color(0xff808080), fontSize: 11.0)
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        DateUtil.getFormatTime(DateTime.fromMillisecondsSinceEpoch(weiboItem.createtime)),
                        style: TextStyle(color: Color(0xff808080), fontSize: 11.0)
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 7.0, right: 7.0),
                        child: Text(
                          '来自',
                          style: TextStyle(color: Color(0xff808080), fontSize: 11.0)
                        ),
                      ),
                      Text(
                        weiboItem.tail,
                        style: TextStyle(color: Color(0xff5b778d), fontSize: 11.0)
                      ),
                    ],
                ),
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: FractionalOffset.centerRight,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  '+ 关注',
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
              ),
            )
          )
        )
      ],
    ),
  );
}

Widget _textContent(BuildContext context, String mTextContent, bool isDetail) {
  if (!isDetail) {
    if (mTextContent.length > 150) {
      mTextContent = mTextContent.substring(0, 148) + ' ... ' + '全文';
    }
  }
  mTextContent = mTextContent.replaceAll("\\n", "\n");
  return Container(
    alignment: FractionalOffset.centerLeft,
    margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
    child: ParsedText(
      text: mTextContent,
      style: TextStyle(
        height: 1.5,
        fontSize: 15,
        color: Colors.black,
      ),
      parse: <MatchText>[
        MatchText(
          pattern: r"\[(@[^:]+):([^\]]+)\]",
          style: TextStyle(
            color: Color(0xff5b778d),
            fontSize: 15,
          ),
          renderText: ({String str, String pattern}) {
            Map<String, String> map = Map<String, String>();
            RegExp customRegExp = RegExp(pattern);
            Match match = customRegExp.firstMatch(str);
            map['display'] = match.group(1);
            map['value'] = match.group(2);
            print('正则:' + match.group(1) + '---' + match.group(2));
            return map;
          },
          onTap: (content, contentId) {

          }
        ),
        MatchText(
          pattern: '#.*?#',
          style: TextStyle(
            color: Color(0xff5b778d),
            fontSize: 15,
          ),
          renderText: ({String str, String pattern}) {
            Map<String, String> map = Map<String, String>();
            String idStr = str.substring(str.indexOf(":") + 1, str.lastIndexOf("#"));
            String showStr = str.substring(str.indexOf("#"), str.lastIndexOf("#") + 1).replaceAll(":" + idStr, "");
            map['display'] = showStr;
            map['value'] = idStr;
            return map;
          },
          onTap: () {

          }
        ),
        MatchText(
          pattern: '(\\[/).*?(\\])',
          style: TextStyle(
            fontSize: 15,
          ),
          renderText: ({String str, String pattern}) {
            Map<String, String> map = Map<String, String>();
            print('表情的正则:' + str);
            String mEmoji2 = "";
            try {
              String mEmoji = str.replaceAll(RegExp('(\\[/)|(\\])'), "");
              int mEmojiNew = int.parse(mEmoji);
              mEmoji2 = String.fromCharCode(mEmojiNew);
            } on Exception catch (_) {
              mEmoji2 = str;
            }
            map['display'] = mEmoji2;

            return map;
          }
        ),
        MatchText(
          pattern: '全文',
          style: TextStyle(
            color: Color(0xff5b778d),
            fontSize: 15,
          ),
          renderText: ({String str, String pattern}) {
            Map<String, String> map = Map<String, String>();
            map['display'] = '全文';
            map['display'] = '全文';
            return map;
          },
          onTap: () {

          }
        )
      ],
    )
  );
}

Widget _mVedioLayout(BuildContext context, String vedioUrl) {
  return Container(
    child: Container(
      margin: EdgeInsets.only(left: 15.0, right: 15.0),
      child: (vedioUrl.isEmpty || "null" == vedioUrl)
        ? Container()
        : Container(
            constraints: BoxConstraints(
              maxHeight: 250,
              maxWidth: MediaQuery.of(context).size.width,
              minHeight: 150,
              minWidth: 150
            ),
            child: VideoWidget(url: vedioUrl),
          )
    )
  );
}