class UserInfo {
  UserInfo({
    this.id,
    this.name = '',
    this.code = '',
    this.deptName = '',
    this.gradeName = '',
    this.avatar = '',
  });
  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        code: json["code"] ?? '',
        deptName: json["deptName"] ?? '',
        gradeName: json["gradeName"] ?? '暂无',
        avatar: json["avatar"] ?? '',
      );

  String? id;
  String name;
  String code;
  String deptName;
  String gradeName;
  String avatar;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "deptName": deptName,
        "gradeName": gradeName,
        "avatar": avatar,
      };
}
