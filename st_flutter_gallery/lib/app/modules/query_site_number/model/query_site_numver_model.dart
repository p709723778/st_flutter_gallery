class QuerySiteNumberModel {
  QuerySiteNumberModel({
    this.key = '',
    this.value = '',
  });

  factory QuerySiteNumberModel.fromJson(Map<String, dynamic> json) =>
      QuerySiteNumberModel(
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
