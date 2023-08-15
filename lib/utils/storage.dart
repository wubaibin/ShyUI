import 'package:shared_preferences/shared_preferences.dart';

/// 缓存
class Storage {
  static final Storage _instance = Storage._();
  static SharedPreferences? _prefs;
  factory Storage() => _instance;
  Storage._() {
    _init();
  }

  void _init() async {
    await _preInit();
  }

  Future<void> _preInit() async {
    if (_prefs == null) {
      try {
        _prefs = await SharedPreferences.getInstance();
      } catch (e) {
        throw Exception('Failed to initialize SharedPreferences: $e');
      }
    }
  }

  Future<bool> set(String key, dynamic value) async {
    await _preInit();
    switch (value.runtimeType) {
      case int:
        return await _prefs?.setInt(key, value) ?? false;
      case double:
        return await _prefs?.setDouble(key, value) ?? false;
      case bool:
        return await _prefs?.setBool(key, value) ?? false;
      case String:
        return await _prefs?.setString(key, value) ?? false;
      case const (List<String>):
        return await _prefs?.setStringList(key, value) ?? false;
      default:
        throw Exception('Invalid value type!');
    }
  }

  Future<dynamic> get(String key) async {
    await _preInit();
    return _prefs?.get(key);
  }

  Future<bool> remove(String key) async {
    await _preInit();
    return await _prefs?.remove(key) ?? false;
  }

  Future<bool> clear() async {
    await _preInit();
    return await _prefs?.clear() ?? false;
  }
}
