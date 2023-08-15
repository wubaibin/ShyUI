enum DayType { start, end }

/// 处理日期的方法
class DateUtil {
  /// 时间格式化
  /// ```
  /// [date] 时间
  /// [format] 格式化
  /// [modifier] 修饰符
  /// ```
  static String dateToString(
    DateTime date, {
    String format = 'yyyy-MM-dd HH:mm',
    String modifier = '-',
  }) {
    String year = '${date.year}';
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    String second = date.second.toString().padLeft(2, '0');
    if (format == 'yyyy-MM') {
      return '$year$modifier$month';
    }
    if (format == 'yyyy-MM-dd') {
      return '$year$modifier$month$modifier$day';
    }
    if (format == 'yyyy-MM-dd HH:mm') {
      return '$year$modifier$month$modifier$day $hour:$minute';
    }
    return '$year$modifier$month$modifier$day $hour:$minute:$second';
  }

  /// 一天开始和结束格式化
  /// ```
  /// [type] DayType.start 开始 DayType.end 结束
  /// [date] 日期 默认是今天
  /// [format] 格式化
  /// [modifier] 修饰符
  /// ```
  static String dateOfDay(
    DayType type, {
    DateTime? date,
    String format = 'yyyy-MM-dd HH:mm:ss',
    String modifier = '-',
  }) {
    final DateTime time = date ?? DateTime.now();
    if (type == DayType.start) {
      return dateToString(
        DateTime(time.year, time.month, time.day, 0, 0, 0),
        format: format,
        modifier: modifier,
      );
    }
    return dateToString(
      DateTime(time.year, time.month, time.day, 23, 59, 59),
      format: format,
      modifier: modifier,
    );
  }
}
