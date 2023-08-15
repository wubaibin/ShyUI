/// 返回String的处理方法
class StringUntil {
  /// 手机号隐藏中间4位
  static String phoneHideMid(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    if (value.length < 11) {
      return value;
    }
    return value.replaceRange(3, 7, '****');
  }

  /// 手机号加空格 xxx xxxx xxxx
  static String phoneSpaces(String? value) {
    if (value == null || value.isEmpty) {
      return "";
    }
    String formattedString = '';
    int index = 0;
    int firstChunkLength = 3;
    int remainingChunkLength = 4;
    if (value.length >= firstChunkLength) {
      formattedString += '${value.substring(index, index + firstChunkLength)} ';
      index += firstChunkLength;
    }
    while (index < value.length) {
      formattedString +=
          '${value.substring(index, index + remainingChunkLength)} ';
      index += remainingChunkLength;
    }
    return formattedString.trimRight();
  }

  /// 大于saveLength 就隐藏显示...
  /// ```
  /// [res] 值
  /// [saveLength] 保存的位数
  /// ```
  static String ellipsis(String? res, int saveLength) {
    if (res == null || res.isEmpty) {
      return "";
    }
    if (res.length >= saveLength + 1) {
      return '${res.substring(0, saveLength)}...';
    }
    return res;
  }

  /// 大于saveLength 就隐藏显示
  /// ```
  /// [res] 值
  /// [saveLength] 保存的位数
  /// ```
  static String visible(String? res, int saveLength) {
    if (res == null || res.isEmpty) {
      return "";
    }
    if (res.length >= saveLength + 1) {
      return res.substring(0, saveLength);
    }
    return res;
  }

  /// 将大于1000m转为km展示
  static String distance(num value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(2)}km';
    }
    return '${value.toStringAsFixed(0)}m';
  }

  /// 钱 除以100 然后转为 小数点后两位
  static String money(num? value) {
    if (value == null || value <= 0) {
      return '0.00';
    }
    return (value / 100).toStringAsFixed(2);
  }

  /// 秒转为分钟 不足一分钟为秒单位超过一个小时展示小时
  static String dayTime(num value) {
    if (value == 0) {
      return '0秒';
    }
    int hours = (value / 3600).floor();
    int minutes = ((value % 3600) / 60).floor();
    int seconds = (value % 60).floor();
    if (hours >= 1) {
      return "$hours小时$minutes分钟$seconds秒";
    }
    if (minutes > 0) {
      return "$minutes分钟$seconds秒";
    }
    return "$seconds秒";
  }

  /// 倒计时
  static String generateCountdownText(Duration countdown) {
    String countdownText = '';
    if (countdown.inHours > 0) {
      countdownText +=
          '${countdown.inHours % 24 <= 9 ? '0' : ''}${countdown.inHours % 24}小时';
    }
    if (countdown.inMinutes > 0) {
      countdownText +=
          '${countdown.inMinutes % 60 <= 9 ? '0' : ''}${countdown.inMinutes % 60}分钟';
    }
    countdownText +=
        '${countdown.inSeconds % 60 <= 9 ? '0' : ''}${countdown.inSeconds % 60}秒';
    return countdownText;
  }
}
