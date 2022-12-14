enum JobActionType {
  none,

  /// 开始
  start,

  /// 补录
  replenishment,

  /// 完成
  completed,

  /// 进行中
  underway,
}

enum CommandType {
  /// 打钻
  da,

  /// 退杆
  tui,

  /// 扩孔
  kuo,

  /// 封孔
  feng,

  /// 注浆
  zhu,
}

enum CommandStateType {
  /// 初始
  none,

  /// 开始
  start,

  /// 结束
  end,
}
