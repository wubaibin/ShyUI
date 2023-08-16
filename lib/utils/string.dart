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
}
