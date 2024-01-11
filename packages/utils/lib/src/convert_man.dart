/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

const double _kMillisLimit = 1000.0;

const double _kSecondsLimit = 60 * _kMillisLimit;

const double _kMinutesLimit = 60 * _kSecondsLimit;

const double _kHourLimit = 24 * _kMinutesLimit;

const double _kDaysLimit = 30 * _kHourLimit;

class ConvertMan {
  
  ///日期格式转换
  static String time2string(DateTime date, {bool just = false}) {
    if (just) {
      return _getDateStr(date);
    }
    int subTimes =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (subTimes < _kMillisLimit) {
      return "刚刚";
    } else if (subTimes < _kSecondsLimit) {
      return (subTimes / _kMillisLimit).round().toString() + " 秒前";
    } else if (subTimes < _kMinutesLimit) {
      return (subTimes / _kSecondsLimit).round().toString() + "分钟前";
    } else if (subTimes < _kHourLimit) {
      return (subTimes / _kMinutesLimit).round().toString() + "小时前";
    } else if (subTimes < _kDaysLimit) {
      return (subTimes / _kHourLimit).round().toString() + "天前";
    } else {
      return _getDateStr(date);
    }
  }

  static String _getDateStr(DateTime date) {
    if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }
}
