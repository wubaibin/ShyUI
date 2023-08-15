class HttpError {
  /// 返回错误的codes
  static Map<dynamic, String> codes = {
    '_500': "网络请求出错",
    '_502': "网络不给力502",
    '_503': "网络不给力503",
    '_400': "网络不给力400",
    '_401': "请重新登录",
    '_404': "网络连接异常404",
    'cancel': "请勿重复点击~",
    'unknown': "请检查网络设置",
    'receiveTimeout': "接收数据超时",
    'sendTimeout': '发送请求超时',
    'connectTimeout': "连接超时",
    'connectionError': "连接发生错误",
    'no_data': "服务端未返回值",
    '99999': "服务异常，请联系客服~~",
  };

  static Map<String, dynamic> type({required Map<String, dynamic> response}) {
    String msg = response['msg'] ?? codes['no_data'];
    dynamic code = response['code'] ?? codes['no_data'];
    return {
      'data': response['data'],
      'msg': msg,
      'code': code.toString(),
    };
  }
}
