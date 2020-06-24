import 'package:flutter_best_practice/utils/sp_util.dart';
import 'package:flutter_best_practice/models/UserModel.dart'; 

class UserUtil {
  static const String SP_USER_ID = 'sp_user_id';
  static const String SP_USER_NAME = 'sp_user_name';
  static const String SP_USER_NICK = 'sp_user_nick';
  static const String SP_USER_HEADURL = 'sp_user_headUrl';
  static const String SP_USER_DESC = 'sp_user_desc';
  static const String SP_USER_GENDER = 'sp_user_gender';
  static const String SP_USER_FAN = 'sp_user_fan';
  static const String SP_USER_FOLLOW = 'sp_user_follow';
  static const String SP_USER_ISMEMBER = 'sp_user_ismember';
  static const String SP_USER_ISVERTIFY = 'sp_user_isvertify';

  static const String SP_IS_ALLOGIN = 'sp_is_allogin';

  static User getUserInfo() {
    bool isLogin = SpUtil.getBool(SP_IS_ALLOGIN);
    if (isLogin == null || !isLogin) {
      return User();
    }
    User userInfo = User();
    userInfo.id = SpUtil.getString(SP_USER_ID);
    userInfo.username = SpUtil.getString(SP_USER_NAME);
    userInfo.nick = SpUtil.getString(SP_USER_NICK);
    userInfo.headUrl = SpUtil.getString(SP_USER_HEADURL);
    userInfo.desc = SpUtil.getString(SP_USER_DESC);
    userInfo.gender = SpUtil.getString(SP_USER_GENDER);
    userInfo.followCount = SpUtil.getString(SP_USER_FOLLOW);
    userInfo.fanCount = SpUtil.getString(SP_USER_FAN);
    userInfo.ismember = SpUtil.getInt(SP_USER_ISMEMBER);
    userInfo.isvertify = SpUtil.getInt(SP_USER_ISVERTIFY);

    return userInfo;
  }

  static User saveUserInfo(Map data) {
    if (data != null) {
      String id = data['id'];
      String username = data['username'];
      String nick = data['nick'];
      String headUrl = data['headurl'];
      String decs = data['decs'];
      String gender = data['gender'];
      String followCount = data['followCount'];
      String fanCount = data['fanCount'];
      int ismember = data['ismember'];
      int isvertify = data['isvertify'];

      SpUtil.putString(SP_USER_ID, id);
      SpUtil.putString(SP_USER_NAME, username);
      SpUtil.putString(SP_USER_NICK, nick);
      SpUtil.putString(SP_USER_HEADURL, headUrl);
      SpUtil.putString(SP_USER_DESC, decs);
      SpUtil.putString(SP_USER_GENDER, gender);
      SpUtil.putString(SP_USER_FOLLOW, followCount);
      SpUtil.putString(SP_USER_FAN, fanCount);
      SpUtil.putInt(SP_USER_ISMEMBER, ismember);
      SpUtil.putInt(SP_USER_ISVERTIFY, isvertify);
      SpUtil.putBool(SP_IS_ALLOGIN, true);
    }
  }

  static bool isLogin() {
    bool b = SpUtil.getBool(SP_IS_ALLOGIN);
    return b != null && b;
  }
}