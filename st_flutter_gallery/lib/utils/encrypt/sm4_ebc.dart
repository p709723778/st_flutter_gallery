import 'package:sm_crypto/sm_crypto.dart';
import 'package:st/helpers/logger/logger_helper.dart';

const String keyRoot = '9876ABCD5432DCBA4321ACBD22335588';

class Sm4EBC {
  static String encrypt(String data) {
    logger.info('👇 ECB Encrypt Mode:');
    final ebcEncryptData = SM4.encrypt(data: data, key: keyRoot);
    logger.info('🔒 EBC EncryptptData:\n $ebcEncryptData');
    return ebcEncryptData;
  }
}
