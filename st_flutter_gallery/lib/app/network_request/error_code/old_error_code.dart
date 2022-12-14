final Map oldErrorCodes = {
  "nouser": "用户名或密码错误!",
  "passerror": "用户名或密码错误!",
  "not_allow_to_login": "当前用户禁止从此界面登录！",
  "login_error": "账号或密码错误！",
  "user_invalid": "用户已失效！请联系管理员",
  "code_validate_fail": "验证码错误！",
  "locked": "账户被锁定！",
  "diasbled": "用户已停用,或用户所在部门机构已停用！",
  "disabled": "用户已停用,或用户所在部门机构已停用！",
  "iperror": "用户禁止在此IP或MAC地址计算机登录！",
  "error": "登录失败，请重试！",
  "passexpire": "密码已过期,请重新设置密码！",
  "overflow": "登录用户数超过系统授权人数！",
  "tenancy_overflow": "当前租户用户数超过租户授权人数！",
  "auth_error": "授权码过期或授权码非法，授权失败！",
  "three_member_close": "当前用户禁止登录！",
  "tenancy_three_member_close": "多租户模式下，三员管理用户禁止登录！",
  "secret_code_low": "此平台包含绝密/机密/秘密信息，您⽆权限登录！",
  "ip_check_failure": "ip地址校验失败！",
  "mac_check_failure": "mac地址校验失败！",
};

String errorCodeString(String key) {
  return oldErrorCodes[key] ?? '未知错误';
}
