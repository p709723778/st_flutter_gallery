class DrillInfoModel {
  DrillInfoModel({
    this.version,
    this.createUserId,
    this.updateUserId,
    this.createTime,
    this.updateTime,
    this.createUserName,
    this.updateUserName,
    this.id,
    this.workFace,
    this.drillSite,
    this.drillNumber,
    this.drillGap,
    this.baseline,
    this.miningLine,
    this.holeHeight,
    this.designLine,
    this.azimuth,
    this.holeDepth,
    this.dip,
    this.openHoleDepth,
    this.worked,
    this.algorithmStatus,
    this.constructStartTime,
    this.constructEndTime,
    this.workedName,
    this.algorithmStatusName,
  });

  DrillInfoModel.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    createUserId = json['createUserId'];
    updateUserId = json['updateUserId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createUserName = json['createUserName'];
    updateUserName = json['updateUserName'];
    id = json['id'];
    workFace = json['workFace'];
    drillSite = json['drillSite'];
    drillNumber = json['drillNumber'];
    drillGap = json['drillGap'];
    baseline = json['baseline'];
    miningLine = json['miningLine'];
    holeHeight = json['holeHeight'];
    designLine = json['designLine'];
    azimuth = json['azimuth'];
    holeDepth = json['holeDepth'];
    dip = json['dip'];
    openHoleDepth = json['openHoleDepth'];
    worked = json['worked'];
    algorithmStatus = json['algorithmStatus'];
    constructStartTime = json['constructStartTime'];
    constructEndTime = json['constructEndTime'];
    workedName = json['workedName'];
    algorithmStatusName = json['algorithmStatusName'];
  }
  int? version;
  String? createUserId;
  String? updateUserId;
  int? createTime;
  int? updateTime;
  String? createUserName;
  String? updateUserName;
  String? id;
  String? workFace;
  String? drillSite;
  String? drillNumber;
  int? drillGap;
  int? baseline;
  int? miningLine;
  double? holeHeight;
  double? designLine;
  int? azimuth;
  double? holeDepth;
  int? dip;
  double? openHoleDepth;
  int? worked;
  int? algorithmStatus;
  int? constructStartTime;
  int? constructEndTime;
  String? workedName;
  String? algorithmStatusName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['createUserId'] = createUserId;
    map['updateUserId'] = updateUserId;
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;
    map['createUserName'] = createUserName;
    map['updateUserName'] = updateUserName;
    map['id'] = id;
    map['workFace'] = workFace;
    map['drillSite'] = drillSite;
    map['drillNumber'] = drillNumber;
    map['drillGap'] = drillGap;
    map['baseline'] = baseline;
    map['miningLine'] = miningLine;
    map['holeHeight'] = holeHeight;
    map['designLine'] = designLine;
    map['azimuth'] = azimuth;
    map['holeDepth'] = holeDepth;
    map['dip'] = dip;
    map['openHoleDepth'] = openHoleDepth;
    map['worked'] = worked;
    map['algorithmStatus'] = algorithmStatus;
    map['constructStartTime'] = constructStartTime;
    map['constructEndTime'] = constructEndTime;
    map['workedName'] = workedName;
    map['algorithmStatusName'] = algorithmStatusName;
    return map;
  }
}
