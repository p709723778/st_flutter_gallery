import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RSAEncrypt {
  /// 公钥
  static String pubKey = '''
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCvczQiXLXRq8P85OicSOUD6BCQ
i0Orgt_mYVgQ4xQRWNTynsHEz-rRA49mGGiVzdspn0-uQWsmmNJIcwLPi4qjF-Hb
lFIUwN_Fm3nA5sYopHeyqvFK2ALQTzYfk7IQt8EpT6PmOvQkvO0nhq5l0HjHYiAS
KL5Xtayvzdvh3TjhgQIDAQAB''';

  static String privateKey = '''
MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKE5W1wCHeOmZve4
nQGqsfBulViqBfTFCUxJkgfpVrNAxhCWLIiy5TR7d/BlzuiKVU+Hntmh93oPSFbi
SGZS05NJbeUFPQmBUaPC3j8F9h49FwQYDktENnhfveRMm7GoRYc5Kmmpa4QaixMc
Qg6D5tGtj+hRiLkmxuoH9+To18lDAgMBAAECgYAGfzo4RfmQX/dMSktBcvCCwOIR
1aAx0fLi+SACY5vT02tn5bVbuOHVsJgPvvqMkm6Hqu5y1L0VVSJUJgBG51WRTId/
I5AiJA3QHa2AMsEuuXi0IeL4E+BGC8qq3Q2MEVcm55L8Z+kbVMOX76zGWR15UCT8
+WgM07HG/pn6EMSTkQJBAMs/TLYyIhVHCt5nzOB0XDWNdbnmIm7n1bH2ziWdt2XD
9WP1PpsLXzDL/fB6quok9JQJFw8g4bAdWpJFVP/2SKkCQQDLEdaIsPqYu2LzO9A+
Ybk9+N+jKc+Srh87Ow1C90cKpsSm+zRGWmbXC7BVrpJuDsl1lXFau8NTg5fCX9BM
RZoLAkBTG4kUnx9MsAYDt1IRHcNuqm9PGolN7EJ3SMI2o20QkbZPr0JwR5Ae9era
YG5u27meprDlIL7oMriMQwlkuKIxAkBefLhT9fVEZ7yM7MHipNnqqgh1BRleaMKD
buCmziQyIpLSF4SlT58WZIvx8j6UEzFOEvEhhMhH7a0JdkeXlbMtAkB4SwOH7HVc
SJL+5I8jmyimmAUEvukcn++jT651LE4bCK0jL7DIORyUw4TkZyVbqX0C5vYAnegz
sgad3iIyMFUY''';

  ///  加密
  static String encryption(String content) {
    final parser = RSAKeyParser();

    final publicKeyString = '''
-----BEGIN PUBLIC KEY-----
$pubKey
-----END PUBLIC KEY-----''';

    final key = parser.parse(publicKeyString) as RSAPublicKey;
    final encrypt = Encrypter(RSA(publicKey: key));
    final base64Encrypt = encrypt.encrypt(content).base64;
    return base64Encrypt;
  }

  /// 解密
  static String decrypt(String decoded) {
    final privateKeyString = '''
-----BEGIN PRIVATE KEY-----
$privateKey
-----END PRIVATE KEY-----
''';

    final parser = RSAKeyParser();
    final key = parser.parse(privateKeyString) as RSAPrivateKey;
    final encrypt = Encrypter(RSA(privateKey: key));
    final base64Decrypt = encrypt.decrypt(Encrypted.fromBase64(decoded));
    return base64Decrypt;
  }
}
