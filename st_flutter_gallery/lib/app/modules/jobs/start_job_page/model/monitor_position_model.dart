class MonitorPositionModel {
  MonitorPositionModel({
    this.code,
    this.message,
  });

  MonitorPositionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
  int? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    return map;
  }
}
