import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class AreaCityManager {
  AreaCityManager._internal();
  static final AreaCityManager instance = AreaCityManager._internal();

  // 省市列表
  final areaCityList = [];

  Future<List> getAreaCityData() async {
    if (areaCityList.isNotEmpty) return areaCityList;
    final list = await _loadAndDecodeJson('assets/json/area-city.json');
    areaCityList.addAll(list);
    return areaCityList;
  }

  Future<List> _loadAndDecodeJson(String assetsPath) async {
    final jsonData = await rootBundle.loadString(assetsPath);
    return jsonDecode(jsonData);
  }
}
