class AreaCityModel {
  AreaCityModel({
    List<dynamic>? citycode,
    String? adcode,
    String? name,
    String? center,
    String? level,
    List<Districts>? districts,
  }) {
    _citycode = citycode;
    _adcode = adcode;
    _name = name;
    _center = center;
    _level = level;
    _districts = districts;
  }

  AreaCityModel.fromJson(dynamic json) {
    if (json['citycode'] != null) {
      _citycode = [];
      if (json['citycode'] is String) {
        _citycode?.add(json['citycode']);
      } else {
        json['citycode'].forEach((v) {
          _citycode?.add(v);
        });
      }
    }
    _adcode = json['adcode'];
    _name = json['name'];
    _center = json['center'];
    _level = json['level'];
    if (json['districts'] != null) {
      _districts = [];
      json['districts'].forEach((v) {
        _districts?.add(Districts.fromJson(v));
      });
    }
  }
  List<dynamic>? _citycode;
  String? _adcode;
  String? _name;
  String? _center;
  String? _level;
  List<Districts>? _districts;
  AreaCityModel copyWith({
    List<dynamic>? citycode,
    String? adcode,
    String? name,
    String? center,
    String? level,
    List<Districts>? districts,
  }) =>
      AreaCityModel(
        citycode: citycode ?? _citycode,
        adcode: adcode ?? _adcode,
        name: name ?? _name,
        center: center ?? _center,
        level: level ?? _level,
        districts: districts ?? _districts,
      );
  List<dynamic> get citycode => _citycode ?? [];
  String get adcode => _adcode ?? '';
  String get name => _name ?? '';
  String get center => _center ?? '';
  String get level => _level ?? '';
  List<Districts> get districts => _districts ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_citycode != null) {
      map['citycode'] = _citycode?.map((v) => v.toJson()).toList();
    }
    map['adcode'] = _adcode;
    map['name'] = _name;
    map['center'] = _center;
    map['level'] = _level;
    map['districts'] = _districts?.map((v) => v.toJson()).toList();
    return map;
  }
}

/// citycode : "0379"
/// adcode : "410300"
/// name : "洛阳市"
/// center : "112.453895,34.619702"
/// level : "city"
/// districts : []

class Districts {
  Districts({
    String? citycode,
    String? adcode,
    String? name,
    String? center,
    String? level,
    List<dynamic>? districts = const [],
  }) {
    _citycode = citycode;
    _adcode = adcode;
    _name = name;
    _center = center;
    _level = level;
    _districts = districts;
  }

  Districts.fromJson(dynamic json) {
    _citycode = json['citycode'];
    _adcode = json['adcode'];
    _name = json['name'];
    _center = json['center'];
    _level = json['level'];
    if (json['districts'] != null) {
      _districts = [];
      json['districts'].forEach((v) {
        _districts?.add(v);
      });
    }
  }
  String? _citycode;
  String? _adcode;
  String? _name;
  String? _center;
  String? _level;
  List<dynamic>? _districts;
  Districts copyWith({
    String? citycode,
    String? adcode,
    String? name,
    String? center,
    String? level,
    List<dynamic>? districts,
  }) =>
      Districts(
        citycode: citycode ?? _citycode,
        adcode: adcode ?? _adcode,
        name: name ?? _name,
        center: center ?? _center,
        level: level ?? _level,
        districts: districts ?? _districts,
      );
  String get citycode => _citycode ?? '';
  String get adcode => _adcode ?? '';
  String get name => _name ?? '';
  String get center => _center ?? '';
  String get level => _level ?? '';
  List<dynamic> get districts => _districts ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['citycode'] = _citycode;
    map['adcode'] = _adcode;
    map['name'] = _name;
    map['center'] = _center;
    map['level'] = _level;
    map['districts'] = _districts?.map((v) => v.toJson()).toList();
    return map;
  }
}
