class WorkFaceModel {
  WorkFaceModel({
    this.key = '',
    this.value = '',
  });

  factory WorkFaceModel.fromJson(Map<String, dynamic> json) => WorkFaceModel(
        key: json["key"] ?? 0,
        value: json["value"] ?? 0,
      );

  String? key;
  String? value;

  Map<String, dynamic> toJson() => {
        "key": key ?? 0,
        "value": value ?? 0,
      };
}
