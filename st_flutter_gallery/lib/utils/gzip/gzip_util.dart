import 'dart:convert';
import 'dart:io';

class GzipUtil {
  ///GZIP 压缩
  static String? gzipEncode(String? str) {
    if (str == null) return str;
    //先来转换一下
    final stringBytes = utf8.encode(str);
    //然后使用 gzip 压缩
    final gzipBytes = GZipCodec().encode(stringBytes);
    //然后再编码一下进行网络传输
    final compressedString = base64UrlEncode(gzipBytes);
    return compressedString;
  }

  ///GZIP 解压缩
  static String? gzipDecode(String? str) {
    if (str == null) return str;
    //先来解码一下
    final List<int> stringBytes = base64Url.decode(str);
    //然后使用 gzip 压缩
    final gzipBytes = GZipCodec().decode(stringBytes);
    //然后再编码一下
    final compressedString = utf8.decode(gzipBytes);
    return compressedString;
  }
}
