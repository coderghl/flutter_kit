extension DateUtils on int {
  /// year/month/day hour:minute:second
  String get timestampToDateTime {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return "${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute}:${date.second}";
  }

  /// year/month/day
  String get timestampToDate {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return "${date.year}/${date.month}/${date.day}";
  }

  /// hour:minute:second
  String get timestampToTime {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return "${date.hour}:${date.minute}:${date.second}";
  }

  /// hour:minute
  String get timestampToTimeWithoutSecond {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return "${date.hour}:${date.minute}";
  }

  /// time from now
  String get timestampToNow {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inSeconds > 0) {
      return "${difference.inSeconds} seconds ago";
    } else {
      return "just now";
    }
  }

  /// 年月日时分秒
  String get timestampToDateTimeZH {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return "${date.year}年${date.month}月${date.day}日 ${date.hour}:${date.minute}:${date.second}";
  }

  /// 年月日
  String get timestampToDateZH {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return "${date.year}年${date.month}月${date.day}日";
  }

  /// 时分秒
  String get timestampToTimeZH {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return "${date.hour}时${date.minute}分${date.second}秒";
  }

  /// 时分
  String get timestampToTimeWithoutSecondZH {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return "${date.hour}时${date.minute}分";
  }

  /// 距离现在的时间
  String get timestampToNowZH {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return "${difference.inDays}天前";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}小时前";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}分钟前";
    } else if (difference.inSeconds > 0) {
      return "${difference.inSeconds}秒前";
    } else {
      return "刚刚";
    }
  }
}
