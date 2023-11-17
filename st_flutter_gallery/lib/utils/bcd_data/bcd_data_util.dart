class BcdDataUtil {
  /// bcd byte 转换为 string
  static String convertBCDToString(List<int> bcdBytes) {
    final buffer = StringBuffer();
    for (var i = 0; i < bcdBytes.length; i++) {
      final digit1 = bcdBytes[i] & 0x0F;
      final digit2 = (bcdBytes[i] >> 4) & 0x0F;
      buffer.write(digit2.toString() + digit1.toString());
    }
    return buffer.toString();
  }

  /// string 转换微 bcd byte
  static List<int> convertStringToBCD(String text) {
    final bcdBytes = <int>[];
    for (var i = 0; i < text.length; i += 2) {
      final digit1 = int.parse(text[i]);
      final digit2 = (i + 1 < text.length) ? int.parse(text[i + 1]) : 0;
      final bcd = (digit1 << 4) | digit2;
      bcdBytes.add(bcd);
    }
    return bcdBytes;
  }

  /// string 转换微 bcd byte
  static List<int> convertStringToBCD2(
    String text, {
    int dataLength = 10,
    int sumLength = 20,
  }) {
    final phoneBcd = List<int>.filled(dataLength, 0);
    final temp = List<int>.filled(sumLength, 0);
    int i;
    final start = sumLength - text.length;

    for (i = 0; i < start; i++) {
      temp[i] = '0'.codeUnitAt(0); // 电话号码前补0
    }

    temp.setRange(start, start + text.length, text.codeUnits);

    for (i = 0; i < dataLength; i++) {
      phoneBcd[i] = (temp[2 * i] - '0'.codeUnitAt(0)) << 4;
      phoneBcd[i] += temp[2 * i + 1] - '0'.codeUnitAt(0);
    }
    return phoneBcd;
  }

  /// bcd byte 转换为指定长度 bytes, 长度不够补0
  static List<int> convertBCDToBytes(List<int> bcdBytes, int desiredLength) {
    if (bcdBytes.length >= desiredLength) {
      return bcdBytes.sublist(0, desiredLength);
    } else {
      final paddedBytes = List<int>.filled(desiredLength, 0)
        ..setRange(
          desiredLength - bcdBytes.length,
          desiredLength,
          bcdBytes,
        );
      return paddedBytes;
    }
  }

  static List<int> getDeviceDateTimeBcdBytes({DateTime? dateTime}) {
    final date = dateTime ?? DateTime.now();
    final dateString =
        '${(date.year % 100).toString().padLeft(2, '0')}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}';
    final deviceDate = BcdDataUtil.convertStringToBCD2(
      dateString,
      dataLength: 6,
      sumLength: 12,
    );
    return deviceDate;
  }
}
