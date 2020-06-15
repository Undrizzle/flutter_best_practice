import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static void show(String msg, {int duaration = 2000}) {
    if (msg == null) {
      return;
    }
    showToast(
      msg,
      duration: Duration(microseconds: duaration),
      dismissOtherToast: true
    );
  }
}