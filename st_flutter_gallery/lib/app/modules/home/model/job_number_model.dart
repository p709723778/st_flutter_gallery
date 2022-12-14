class JobNumberModel {
  JobNumberModel({
    this.overCount = 0,
    this.conducting = 0,
    this.repairCount = 0,
  });

  factory JobNumberModel.fromJson(Map<String, dynamic> json) => JobNumberModel(
        overCount: json["overCount"] ?? 0,
        conducting: json["conducting"] ?? 0,
        repairCount: json["repairCount"] ?? 0,
      );

  int? overCount;
  int? conducting;
  int? repairCount;

  Map<String, dynamic> toJson() => {
        "overCount": overCount ?? 0,
        "conducting": conducting ?? 0,
        "repairCount": repairCount ?? 0,
      };
}
