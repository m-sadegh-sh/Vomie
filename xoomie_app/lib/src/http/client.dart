import 'package:dio/dio.dart';
import 'package:xoomie/src/base/widgets/localized_text.dart';

Dio createClient(
  String baseUrl, {
  String? authorization,
  Duration timeout = const Duration(minutes: 1),
}) {
  final choices = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: timeout.inMilliseconds,
    receiveTimeout: timeout.inMilliseconds,
    sendTimeout: timeout.inMilliseconds,
    headers: {
      'Authorization': authorization,
    },
  );

  return Dio(choices);
}

GenerateLocalizedString? unwrapError(Object error) {
  if (error is! DioError) {
    return null;
  }

  switch (error.type) {
    case DioErrorType.connectTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return (x) => x.httpErrorNoConnection;
    case DioErrorType.response:
      return (x) => error.response?.data?.toString() ?? x.httpErrorServer;
    case DioErrorType.cancel:
      return (x) => x.httpErrorCancel;
    case DioErrorType.other:
      return error.error == null ? null : (x) => error.error.toString();
  }
}
