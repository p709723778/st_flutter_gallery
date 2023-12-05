import 'dart:typed_data';

import 'package:fast_gbk/fast_gbk.dart';
import 'package:intl/intl.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';
import 'package:st/utils/list/list_util.dart';
import 'package:st/utils/reg_exps/reg_exps.dart';

class DriverIcDataModel {
  DriverIcDataModel({
    required this.dataBytes,
  }) {
    var driveDataBytes = dataBytes.sublist(1, 8);
    icNo = String.fromCharCodes(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(8, 28);
    certificateCode = gbk.decode(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(32, 50);
    driverNo = String.fromCharCodes(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(50, 82);
    driverName = gbk.decode(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(82, 102);
    organizationName = gbk.decode(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(102, 106);
    final cerValidDateString = BcdDataUtil.convertBCDToString(driveDataBytes)
        .replaceAll(regExp_Null, '');

    /// 年份为空或者大于等于2050年的,时间都默认为空
    if (cerValidDateString == '00000000' ||
        int.parse(cerValidDateString) > 20500101 ||
        int.parse(cerValidDateString) < 20200101) {
      cerValidDate = null;
    } else {
      cerValidDate = DateTime.parse(
        cerValidDateString.replaceAllMapped(RegExp(r"(\d{4})(\d{2})(\d{2})"),
            (match) {
          return "${match[1]}-${match[2]}-${match[3]}";
        }),
      );
    }

    driveDataBytes = dataBytes.sublist(106, 126);
    idCardNo = gbk.decode(driveDataBytes).replaceAll(regExp_Null, '');
  }

  DriverIcDataModel.fromJson({
    String? icNo,
    String? certificateCode,
    required String driverName,
    required String driverNo,
    String? organizationName,
    DateTime? cerValidDate,
    String? idCardNo,
  }) {
    final icNoCodeUnits = icNo?.codeUnits ?? [];
    final icNoAscIIBytes = ListUtil.fixedLenList(icNoCodeUnits, length: 8 - 1);

    final icNoLen = ByteData(1)..setUint8(0, icNoCodeUnits.length);

    final certificateCodeBytes = ListUtil.fixedLenList(
      gbk.encode(certificateCode ?? ''),
      length: 28 - 8,
    );

    // 预留
    final reservedField1 = List.filled(32 - 30, 0);

    /// 驾驶证编号
    final driverNoAscIIBytes =
        ListUtil.fixedLenList(driverNo.codeUnits, length: 50 - 32);

    /// 姓名
    final gbkBytesDriverNameEncode = gbk.encode(driverName);
    final gbkBytesDriverName =
        ListUtil.fixedLenList(gbkBytesDriverNameEncode, length: 82 - 50);

    /// 发证机构
    final organizationNameEncode = gbk.encode(organizationName ?? '');
    final gbkBytesOrganizationName = ListUtil.fixedLenList(
      organizationNameEncode,
      length: 102 - 82,
    );

    /// 驾驶人姓名长度
    final driverNameLen = ByteData(29 - 28)
      ..setUint8(0, gbkBytesDriverNameEncode.length);

    /// 发证机构名称长度
    final organizationNameLen = ByteData(30 - 29)
      ..setUint8(0, organizationNameEncode.length);

    /// 证件有效期
    List<int> cerValidDateBCD;
    if (cerValidDate != null) {
      final cerValidDateStr = DateFormat('yyyyMMdd').format(
        DateTime.fromMillisecondsSinceEpoch(
          cerValidDate.millisecondsSinceEpoch,
        ),
      );

      cerValidDateBCD = BcdDataUtil.convertStringToBCD2(
        cerValidDateStr,
        dataLength: 106 - 102,
        sumLength: 8,
      );
    } else {
      cerValidDateBCD = List<int>.filled(4, 0);
    }

    /// 证件编号
    final gbkBytesIdCardNo =
        ListUtil.fixedLenList(gbk.encode(idCardNo ?? ''), length: 126 - 106);

    /// 标准扩展预留
    final extensionField1 = ByteData(127 - 126)..setUint8(0, 0);

    final extensionField1Bytes = extensionField1.buffer.asUint8List();
    final data = [
      ...icNoLen.buffer.asUint8List(),
      ...icNoAscIIBytes,
      ...certificateCodeBytes,
      ...driverNameLen.buffer.asUint8List(),
      ...organizationNameLen.buffer.asUint8List(),
      ...reservedField1,
      ...driverNoAscIIBytes,
      ...gbkBytesDriverName,
      ...gbkBytesOrganizationName,
      ...cerValidDateBCD,
      ...gbkBytesIdCardNo,
      ...extensionField1Bytes,
    ];

    var xorResult = 0;
    for (var i = 0; i < data.length; i++) {
      xorResult ^= data[i];
    }
    final verifyFields = xorResult;
    data.add(verifyFields);

    dataBytes = data;

    var driveDataBytes = dataBytes.sublist(1, 8);
    this.icNo =
        String.fromCharCodes(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(8, 28);
    this.certificateCode =
        gbk.decode(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(32, 50);
    this.driverNo =
        String.fromCharCodes(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(50, 82);
    this.driverName = gbk.decode(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(82, 102);
    this.organizationName =
        gbk.decode(driveDataBytes).replaceAll(regExp_Null, '');

    driveDataBytes = dataBytes.sublist(102, 106);
    final cerValidDateString = BcdDataUtil.convertBCDToString(driveDataBytes)
        .replaceAll(regExp_Null, '');
    if (cerValidDateString == '00000000') {
      this.cerValidDate = null;
    } else {
      this.cerValidDate = DateTime.parse(
        cerValidDateString.replaceAllMapped(RegExp(r"(\d{4})(\d{2})(\d{2})"),
            (match) {
          return "${match[1]}-${match[2]}-${match[3]}";
        }),
      );
    }

    driveDataBytes = dataBytes.sublist(106, 126);
    idCardNo = gbk.decode(driveDataBytes).replaceAll(regExp_Null, '');
  }

  late final List<int> dataBytes;
  String? icNo;
  String? certificateCode;
  String? driverName;
  String? driverNo;
  String? organizationName;
  String? idCardNo;
  DateTime? cerValidDate;
}
