class ShiftModel {
  ShiftModel({
    this.code,
    this.message,
  });

  ShiftModel.fromJson(Map<String, dynamic> json) {
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
