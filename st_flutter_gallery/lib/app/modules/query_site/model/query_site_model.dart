class QuerySiteModel {
  QuerySiteModel({
    this.key = '',
    this.value = '',
  });

  factory QuerySiteModel.fromJson(Map<String, dynamic> json) => QuerySiteModel(
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
