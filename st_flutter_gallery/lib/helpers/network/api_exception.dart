import 'package:dio/dio.dart';
import 'package:st/app/models/api_response/api_response_model.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class ApiException implements Exception {
  ApiException([this.code, this.message]);

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.badCertificate:
        return BadRequestException(-1, "请求证书错误");
      case DioExceptionType.connectionError:
        return BadRequestException(-1, "连接错误");
      case DioExceptionType.unknown:
        return ApiException(-1, error.message);
      case DioExceptionType.cancel:
        return BadRequestException(-1, "请求取消");
      case DioExceptionType.connectionTimeout:
        return BadRequestException(-1, "连接超时");
      case DioExceptionType.sendTimeout:
        return BadRequestException(-1, "请求超时");
      case DioExceptionType.receiveTimeout:
        return BadRequestException(-1, "响应超时");
      case DioExceptionType.badResponse:
        try {
          /// http错误码带业务错误信息
          final apiResponse = ApiResponseModel.fromJson(error.response?.data);
          if (apiResponse.errorCode != null) {
            return ApiException(
                apiResponse.errorCode, apiResponse.errorMessage);
          }

          final errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(errCode, "请求语法错误");
            case 401:
              return UnauthorisedException(errCode!, "没有权限");
            case 403:
              return UnauthorisedException(errCode!, "服务器拒绝执行");
            case 404:
              return UnauthorisedException(errCode!, "无法连接服务器");
            case 405:
              return UnauthorisedException(errCode!, "请求方法被禁止");
            case 500:
              return UnauthorisedException(errCode!, "服务器内部错误");
            case 502:
              return UnauthorisedException(errCode!, "无效的请求");
            case 503:
              return UnauthorisedException(errCode!, "服务器异常");
            case 505:
              return UnauthorisedException(errCode!, "不支持HTTP协议请求");
            default:
              return ApiException(
                errCode,
                error.response?.statusMessage ?? '未知错误',
              );
          }
        } on Exception catch (e) {
          logger.severe(e);
          return ApiException(-1, unknownException);
        }
    }
  }

  factory ApiException.from(exception) {
    if (exception is DioException) {
      return ApiException.fromDioError(exception);
    }
    if (exception is ApiException) {
      return exception;
    } else {
      final apiException = ApiException(-1, unknownException)
        ..stackInfo = exception?.toString();
      return apiException;
    }
  }
  static const unknownException = "未知错误";
  final String? message;
  final int? code;
  String? stackInfo;

  @override
  String toString() {
    return {'code': code, 'message': message}.toString();
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException([super.code, super.message]);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException([int super.code = -1, String super.message = '']);
}
