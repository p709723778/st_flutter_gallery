import 'package:fast_gbk/fast_gbk.dart';

class ByteStringUtil {
  static List<int> convertFixedLenBytes(String character, {int length = 16}) {
    final byteList = gbk.encode(character);

    // final byteList = utf8.encode(character);
    final paddedByteList = List<int>.filled(length, 0);

    for (var i = 0; i < byteList.length && i < paddedByteList.length; i++) {
      paddedByteList[i] = byteList[i];
    }
    return paddedByteList;
  }
}
