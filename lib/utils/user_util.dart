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
}