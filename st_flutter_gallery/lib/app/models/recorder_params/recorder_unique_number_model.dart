import 'package:st/utils/bcd_data/bcd_data_util.dart';

import '../../../utils/reg_exps/reg_exps.dart';

class RecorderUniqueNumberModel {
  RecorderUniqueNumberModel({
    required this.recorderUniqueNumberBytes,
  });

  final List<int> recorderUniqueNumberBytes;

  String get authCode {
    final data = recorderUniqueNumberBytes.sublist(0, 0 + 7);
    final result = String.fromCharCodes(data);
    return result.replaceAll(regExp_Null, '');
  }

  String get authModelNumber {
    final data = recorderUniqueNumberBytes.sublist(7, 7 + 16);
    final result = String.fromCharCodes(data);
    return result.replaceAll(regExp_Null, '');
  }

  String get year {
    final data = recorderUniqueNumberBytes.sublist(23, 23 + 1);
    final result = BcdDataUtil.convertBCDToString(data);
    return result.replaceAll(regExp_Null, '');
  }

  String get month {
    final data = recorderUniqueNumberBytes.sublist(24, 24 + 1);
    final result = BcdDataUtil.convertBCDToString(data);
    return result.replaceAll(regExp_Null, '');
  }

  String get day {
    final data = recorderUniqueNumberBytes.sublist(25, 25 + 1);
    final result = BcdDataUtil.convertBCDToString(data);
    return result.replaceAll(regExp_Null, '');
  }

  String get lineNumber {
    final data = recorderUniqueNumberBytes.sublist(26, 26 + 4);
    final result = BcdDataUtil.convertBCDToString(data);
    return result.replaceAll(regExp_Null, '');
  }

  String get manufacturerName {
    final data = recorderUniqueNumberBytes.sublist(30, 30 + 2);
    final result = String.fromCharCodes(data);
    return result.replaceAll(regExp_Null, '');
  }

  String get productNumber {
    final data = recorderUniqueNumberBytes.sublist(32, 32 + 3);
    final result = String.fromCharCodes(data);

    return result.replaceAll(regExp_Null, '');
  }
}
