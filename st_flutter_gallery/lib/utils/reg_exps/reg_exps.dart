// ignore_for_file: unnecessary_string_escapes

/// ip和端口号的正则表达式
const String regExp_Ipv4Port = r'^(\d{1,3}\.){3}\d{1,3}$';

/// ip地址
const String regExp_IpAddress = '[0-9.]';

/// 匹配空字符串(过滤特殊字符NUL（null字符）)
const String regExp_Null = '\u0000';

/// 比如 baidu.com, 不需要验证http头
const String regExp_SimpleDoMain = r'^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
