class Apis {
  /// 用户登录
  static const login = "/gateway/security/login";

  /// 获取用户信息
  static const getUserInfo = "/gateway/cloud-system-manage/api/ou/user/session";

  /// 用户退出
  static const logout = "/gateway/security/logout";

  /// 首页数据
  static const jobHome =
      "/gateway/drg-video-manage-system/api/taskAccount/jobHome";

  /// 工作面查询
  static const workFaces =
      "/gateway/drg-video-manage-system/api/taskAccount/workFaces";

  /// 钻场查询
  static const drillSites =
      "/gateway/drg-video-manage-system/api/taskAccount/drillSites";

  /// 钻孔编号查询
  static const drillNumbers =
      "/gateway/drg-video-manage-system/api/taskAccount/drillNumbers";

  /// 查询钻孔信息
  static const drillTaskBy =
      "/gateway/drg-video-manage-system/api/taskAccount/drillTaskBy";

  /// APP-结束作业
  static const endJob =
      "/gateway/drg-video-manage-system/api/instructAccount/endJob";

  /// APP-开始作业
  static const startJob =
      "/gateway/drg-video-manage-system/api/instructAccount/startJob";

  /// APP-指令信息补录
  static const instructAddRecord =
      "/gateway/drg-video-manage-system/api/instructAccount/instructAddRecord";

  /// APP-指令类型下拉框
  static const instructions =
      "/gateway/drg-video-manage-system/api/instructAccount/instructions";

  /// APP-作业指令记录查询
  static const instructRecords =
      "/gateway/drg-video-manage-system/api/instructAccount/instructRecords";

  /// APP-进行中作业列表
  static const afootJobs =
      "/gateway/drg-video-manage-system/api/taskAccount/afootJobs";

  /// APP-已完成作业查询-自动记录
  static const autoRecords =
      "/gateway/drg-video-manage-system/api/taskAccount/autoRecords";

  /// APP-施工日期
  static const constructDate =
      "/gateway/drg-video-manage-system/api/taskAccount/constructDate";

  /// APP-作业基础信息查询
  static const jobBasicInfo =
      "/gateway/drg-video-manage-system/api/taskAccount/jobBasicInfo";

  /// APP-监控是否开启下拉框
  static const monitorOns =
      "/gateway/drg-video-manage-system/api/taskAccount/monitorOns";

  /// APP-下一步
  static const nextStep =
      "/gateway/drg-video-manage-system/api/taskAccount/nextStep";

  /// APP-监控位置确认下拉框
  static const monitorPosition =
      "/gateway/drg-video-manage-system/api/taskAccount/monitorPosition";

  ///  APP-施工班次枚举列表
  static const shifts =
      "/gateway/drg-video-manage-system/api/taskAccount/shifts";

  /// APP-补录人、时间
  static const repairPeople =
      "/gateway/drg-video-manage-system/api/taskAccount/repairPeople";

  /// APP-已完成作业查询-补录记录
  static const repairRecords =
      "/gateway/drg-video-manage-system/api/taskAccount/repairRecords";

  /// APP-进行中作业-作业指令发送是否展示指令按钮
  static const showButton =
      "/gateway/drg-video-manage-system/api/taskAccount/showButton";

  static const project_settings =
      "https://gitee.com/p709723778/project_settings/raw/master/config.json";
}
