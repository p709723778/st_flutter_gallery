import 'dart:convert';
import 'dart:typed_data';

import 'package:fast_gbk/fast_gbk.dart';
import 'package:st/utils/reg_exps/reg_exps.dart';

class BytesDataUtil {
  /// 把int转换为一个byte的U8 List
  static List<int> intToU8Bytes({
    required int num,
    int byteOffset = 0,
    int byteSize = 1,
  }) {
    final numByteData = ByteData(byteSize)..setUint8(byteOffset, num);
    final numU8List = numByteData.buffer.asUint8List();
    return numU8List;
  }

  /// 把U8 List的byte转换为int
  static int parseU8BytesToInt({
    required List<int> bytes,
    int byteOffset = 0,
  }) {
    final byteDate = Uint8List.fromList(bytes).buffer.asByteData();
    final result = byteDate.getUint8(byteOffset);
    return result;
  }

  /// 把int转换为一个byte的Int8 List
  static List<int> intToInt8Bytes({
    required int num,
    int byteOffset = 0,
    int byteSize = 1,
  }) {
    final numByteData = ByteData(byteSize)..setInt8(byteOffset, num);
    final numInt8List = numByteData.buffer.asInt8List();
    return numInt8List;
  }

  /// 把Int8 List的byte转换为Int8
  static int parseInt8BytesToInt({
    required List<int> bytes,
    int byteOffset = 0,
  }) {
    final byteDate = Uint8List.fromList(bytes).buffer.asByteData();
    final result = byteDate.getInt8(byteOffset);
    return result;
  }

  /// 把int转换为两个个byte的U16 List
  static List<int> intToU16Bytes({
    required int num,
    int byteOffset = 0,
    int byteSize = 2,
    Endian endian = Endian.big,
  }) {
    final numByteData = ByteData(byteSize)..setUint16(byteOffset, num, endian);
    final numU16List = numByteData.buffer.asUint8List();
    return numU16List;
  }

  /// 把U16 List的byte转换为int
  static int parseU16BytesToInt({
    required List<int> bytes,
    int byteOffset = 0,
    Endian endian = Endian.big,
  }) {
    final byteDate = Uint8List.fromList(bytes).buffer.asByteData();
    final result = byteDate.getUint16(byteOffset, endian);
    return result;
  }

  /// 把String转换为bytes (utf8转换中文为3个字节)
  static List<int> stringToUTF8Bytes({
    required String str,
    int? fixedBytesLen,
  }) {
    List<int> dataBytes = utf8.encode(str);
    if (fixedBytesLen != null) {
      dataBytes = convertFixedLenBytes(dataBytes, length: fixedBytesLen);
    }
    return dataBytes;
  }

  /// 把 utf8 bytes转换为String
  static String parseUTF8BytesToString({
    required List<int> bytes,
  }) {
    final string = utf8.decode(bytes, allowMalformed: true);
    return string.replaceAll(regExp_Null, '');
  }

  /// 把String转换为bytes (gbk转换中文为2个字节)
  static List<int> stringToGBKBytes({
    required String str,
    int? fixedBytesLen,
  }) {
    var dataBytes = gbk.encode(str);
    if (fixedBytesLen != null) {
      dataBytes = convertFixedLenBytes(dataBytes, length: fixedBytesLen);
    }
    return dataBytes;
  }

  /// 把gbk bytes转换为String
  static String parseGBKBytesToString({
    required List<int> bytes,
  }) {
    final dataU16Bytes = Uint16List.fromList(bytes);
    final string = gbk.decode(dataU16Bytes, allowMalformed: true);
    return string.replaceAll(regExp_Null, '');
  }

  /// 把String转换为ASCII码 bytes (UTF-16)
  static List<int> stringToASCIIBytes({
    required String str,
    int? fixedBytesLen,
  }) {
    var dataBytes = str.codeUnits;
    if (fixedBytesLen != null) {
      dataBytes = convertFixedLenBytes(dataBytes, length: fixedBytesLen);
    }
    return dataBytes;
  }

  /// 把 ASCII码 bytes转换为String (UTF-16)
  static String parseASCIIBytesToString({
    required List<int> bytes,
  }) {
    final string = String.fromCharCodes(bytes);
    return string.replaceAll(regExp_Null, '');
  }

  /// 将bytes转换为固定长度的bytes, 多余的补0(以0来填充)
  static List<int> convertFixedLenBytes(List<int> bytes, {int length = 20}) {
    final paddedBytes = List<int>.filled(length, 0);
    for (var i = 0; i < bytes.length && i < paddedBytes.length; i++) {
      paddedBytes[i] = bytes[i];
    }
    return paddedBytes;
  }
}
