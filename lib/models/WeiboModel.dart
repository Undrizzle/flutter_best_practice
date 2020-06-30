class WeiboModel {
  String weiboId;
  String categoryId;
  String content;
  UserInfo userInfo;
  List<String> picurl;
  String zfContent;
  String zfNick;
  String zfUserId;
  List<String> zfPicurl;
  String zfWeiBoId;
  String zfVedioUrl;
  bool containZf;
  String vediourl;
  String tail;
  int createtime;
  int zanStatus;
  int zhuanfaNum;
  int likeNum;
  int commentNum; 

  WeiboModel({
    this.weiboId,
    this.categoryId,
    this.content,
    this.userInfo,
    this.picurl,
    this.zfContent,
    this.zfNick,
    this.zfUserId,
    this.zfPicurl,
    this.zfWeiBoId,
    this.containZf,
    this.vediourl,
    this.zfVedioUrl,
    this.tail,
    this.createtime,
    this.zanStatus,
    this.zhuanfaNum,
    this.likeNum,
    this.commentNum
  });

  WeiboModel.fromJson(Map<String, dynamic> json) {
    weiboId = json['weiboId'];
    categoryId = json['categoryId'];
    content = json['content'];
    userInfo = json['userInfo'] != null
      ? UserInfo.fromJson(json['userInfo'])
      : null;
    picurl = json['picurl'].cast<String>();
    zfContent = json['zfContent'];
    zfNick = json['zfNick'];
    zfUserId = json['zfUserId'];
    zfPicurl = json['zfPicurl'].cast<String>();
    zfWeiBoId = json['zfWeiBoId'];
    containZf = json['containerZf'];
    vediourl = json['vediourl'];
    zfVedioUrl = json['zfVedioUrl'];
    createtime = json['createtime'];
    tail = json['tail'];
    zanStatus = json['zanStatus'];
    zhuanfaNum = json['zhuanfaNum'];
    likeNum = json['likeNum'];
    commentNum = json['commentNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['weiboId'] = this.weiboId;
    data['categoryId'] = this.categoryId;
    data['content'] = this.content;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['picurl'] = this.picurl;
    data['zfContent'] = this.zfContent;
    data['zfNick'] = this.zfNick;
    data['zfUserId'] = this.zfUserId;
    data['zfPicurl'] = this.zfPicurl;
    data['zfWeiBoId'] = this.zfWeiBoId;
    data['containZf'] = this.containZf;
    data['vediourl'] = this.vediourl;
    data['zfVedioUrl'] = this.zfVedioUrl;
    data['tail'] = this.tail;
    data['createtime'] = this.createtime;
    data['zanStatus'] = this.zanStatus;
    data['zhuanfaNum'] = this.zhuanfaNum;
    data['likeNum'] = this.likeNum;
    data['commentNum'] = this.commentNum;

    return data;
  }
}

class UserInfo {
  int id;
  String nick;
  String headUrl;
  String decs;
  int ismember;
  int isvertify;

  UserInfo({this.id, this.headUrl, this.decs, this.ismember, this.isvertify});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nick = json['nick'];
    headUrl = json['headurl'];
    decs = json['decs'];
    ismember = json['ismember'];
    isvertify = json['isvertify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['nick'] = this.nick;
    data['headurl'] = this.headUrl;
    data['decs'] = this.decs;
    data['ismember'] = this.ismember;
    data['isvertify'] = this.isvertify;

    return data;
  }
}