class DateUtil {
  static String getFormatTime(DateTime mDate) {
    String timestamp = "${mDate.month.toString().padLeft(2, '0')}-${mDate.day.toString().padLeft(2, '0')}";
    return timestamp;
  }

  static String getFormatTime2(DateTime mDate) {
    String timestamp = "${mDate.month.toString()}-${mDate.day.toString()}" + " " +
        "${mDate.hour.toString().padLeft(2, '0')}:${mDate.minute.toString().padLeft(2, '0')}";
    return timestamp;    
  }

  static String getFormatTime3(DateTime mDate) {
    String timestamp = "" + "${mDate.year.toString()}-${mDate.month.toString()}-${mDate.day.toString()}" +
        " " + "${mDate.hour.toString().padLeft(2, '0')}:${mDate.minute.toString().padLeft(2, '0')}";
    return timestamp;    
  }

  static String getFormatTime4(int mSecond) {
    var d = Duration(seconds: mSecond);
    return d.abs().inMinutes.toString() + ":" + (mSecond - d.abs().inMinutes * 60).toString().padLeft(2, '0');
  }
}