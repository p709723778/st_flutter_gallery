import 'package:sm_crypto/sm_crypto.dart';
import 'package:st/helpers/logger/logger_helper.dart';

const String keyRoot = '9876ABCD5432DCBA4321ACBD22335588';

class Sm4EBC {
  static String encrypt(String data) {
    final ebcEncryptData = SM4.encrypt(
      data: data,
      key: keyRoot,
      padding: SM4PaddingMode.NONE,
      isUTF8: false,
    );
    logger.info('🔒 EBC Encrypt Data:\n $ebcEncryptData');
    return ebcEncryptData;
  }

  static String decrypt(String data) {
    final ebcEncryptData = SM4.decrypt(
      data: data,
      key: keyRoot,
      padding: SM4PaddingMode.NONE,
      isUTF8: false,
    );
    logger.info('🔒 EBC Decrypt Data:\n $ebcEncryptData');
    return ebcEncryptData;
  }

  static List<int> encryptOutArray(String data) {
    final ebcEncryptData = SM4.encryptOutArray(
      data: data,
      key: keyRoot,
      padding: SM4PaddingMode.NONE,
      isUTF8: false,
    );
    logger.info('🔒 EBC encryptOutArray Data:\n $ebcEncryptData');
    return ebcEncryptData;
  }

  static List<int> decryptOutArray(String data) {
    final ebcEncryptData = SM4.decryptOutArray(
      data: data,
      key: keyRoot,
      padding: SM4PaddingMode.NONE,
      isUTF8: false,
    );
    logger.info('🔒 EBC decryptOutArray Data:\n $ebcEncryptData');
    return ebcEncryptData;
  }
}
