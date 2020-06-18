class User {
  String id;
  String username;
  String nick;
  String headUrl;
  String desc;
  String gender;
  String followCount;
  String fanCount;
  int ismember;
  int isvertify;

  User({this.id, this.username, this.nick, this.headUrl, this.desc, this.gender, this.followCount, this.fanCount, this.ismember, this.isvertify});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nick = json['nick'];
    headUrl = json['headUrl'];
    desc = json['decs'];
    gender = json['gender'];
    followCount = json['followCount'];
    fanCount = json['fanCount'];
    ismember = json['ismember'];
    isvertify = json['isvertify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nick'] = this.nick;
    data['headUrl'] = this.headUrl;
    data['decs'] = this.desc;
    data['gender'] = this.gender;
    data['followCount'] = this.followCount;
    data['fanCount'] = this.fanCount;
    data['ismember'] = this.ismember;
    data['isvertify'] = this.isvertify;

    return data;
  }
}