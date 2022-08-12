import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st/helpers/logger/logger_helper.dart';

/// Shared Preferences Service
class SpService extends GetxService {
  static late SharedPreferences _sp;

  /// 特殊情况使用
  SharedPreferences get rawSp => _sp;

  Future<SpService> init() async {
    _sp = await SharedPreferences.getInstance()
        .onError((error, stackTrace) async {
      logger.severe("SharedPreferences get instance error: $error");
      return SharedPreferences.getInstance();
    });

    return this;
  }

  /// 通用设置持久化数据
  static void setLocalStorage<T>(String key, T value) {
    final type = value.runtimeType.toString();

    switch (type) {
      case "String":
        setString(key, value as String);
        break;
      case "int":
        setInt(key, value as int);
        break;
      case "bool":
        setBool(key, value as bool);
        break;
      case "double":
        setDouble(key, value as double);
        break;
      case "List<String>":
        setStringList(key, value as List<String>);
        break;
      case "_InternalLinkedHashMap<String, String>":
        setMap(key, value as Map);
        break;
    }
  }

  /// 获取持久化数据
  static dynamic getLocalStorage<T>(String key) {
    final dynamic value = _sp.get(key);
    if (value.runtimeType.toString() == "String") {
      if (_isJson(value)) {
        return json.decode(value);
      }
    }
    return value;
  }

  /// 根据key存储int类型
  static Future<bool> setInt(String key, int value) {
    return _sp.setInt(key, value);
  }

  /// 根据key获取int类型
  static int? getInt(String key, {int defaultValue = 0}) {
    return _sp.getInt(key) ?? defaultValue;
  }

  /// 根据key存储double类型
  static Future<bool> setDouble(String key, double value) {
    return _sp.setDouble(key, value);
  }

  /// 根据key获取double类型
  static double? getDouble(String key, {double defaultValue = 0.0}) {
    return _sp.getDouble(key) ?? defaultValue;
  }

  /// 根据key存储字符串类型
  static Future<bool> setString(String key, String value) {
    return _sp.setString(key, value);
  }

  /// 根据key获取字符串类型
  static String? getString(String key, {String defaultValue = ""}) {
    return _sp.getString(key) ?? defaultValue;
  }

  /// 根据key存储布尔类型
  static Future<bool> setBool(String key, bool value) {
    return _sp.setBool(key, value);
  }

  /// 根据key获取布尔类型
  static bool? getBool(String key, {bool defaultValue = false}) {
    return _sp.getBool(key) ?? defaultValue;
  }

  /// 根据key存储字符串类型数组
  static Future<bool> setStringList(String key, List<String> value) {
    return _sp.setStringList(key, value);
  }

  /// 根据key获取字符串类型数组
  static List<String> getStringList(
    String key, {
    List<String> defaultValue = const [],
  }) {
    return _sp.getStringList(key) ?? defaultValue;
  }

  /// 根据key存储Map类型
  static Future<bool> setMap(String key, Map value) {
    return _sp.setString(key, json.encode(value));
  }

  /// 根据key获取Map类型
  static Map getMap(String key) {
    final jsonStr = _sp.getString(key) ?? "";
    return jsonStr.isEmpty ? Map : json.decode(jsonStr);
  }

  /// 获取持久化数据中所有存入的key
  static Set<String> getKeys() {
    return _sp.getKeys();
  }

  /// 获取持久化数据中是否包含某个key
  static bool containsKey(String key) {
    return _sp.containsKey(key);
  }

  /// 删除持久化数据中某个key
  static Future<bool> remove(String key) async {
    return _sp.remove(key);
  }

  /// 清除所有持久化数据
  static Future<bool> clear() async {
    return _sp.clear();
  }

  /// 重新加载所有数据,仅重载运行时
  static Future<void> reload() async {
    return _sp.reload();
  }

  /// 判断是否是json字符串
  static bool _isJson(String value) {
    try {
      const JsonDecoder().convert(value);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
