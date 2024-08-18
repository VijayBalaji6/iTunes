import 'package:dio/dio.dart';
import 'package:itunes_media/common/api_handler/api_exception_handler.dart';

class ApiService {
  static final Dio _dio = Dio();

  ApiService() {
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  static Future<Response> get(String url,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(url, queryParameters: params);
      return _handleResponse(response);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  static Future<Response> post(String url, {dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return _handleResponse(response);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  static Future<Response> put(String url, {dynamic data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return _handleResponse(response);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  static Future<Response> delete(String url, {dynamic data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return _handleResponse(response);
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  static Response _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.data);
      case 401:
        throw UnAuthorizedException(response.data);
      case 403:
        throw AuthenticationException(message: response.data);
      case 404:
        throw NotFoundException(response.data);
      case 409:
        throw ConflictException(message: response.data);
      case 422:
        throw UnprocessableEntityException(message: response.data);
      case 500:
        throw FetchDataException("Internal Server Error");
      case 503:
        throw ServiceUnavailableException("Service Unavailable");
      default:
        throw DefaultException("Unexpected Error: ${response.statusCode}");
    }
  }

  static void _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          throw TimeoutException("Request timed out");
        case DioExceptionType.cancel:
          throw RequestCanceledException("Request was cancelled");
        case DioExceptionType.unknown:
          if (error.message != null &&
              error.message!.contains("SocketException")) {
            throw NoInternetException("No Internet Connection");
          }
          throw DefaultException(error.message);
        case DioExceptionType.sendTimeout:
          throw DefaultException("Request was cancelled");
        case DioExceptionType.badCertificate:
          throw DefaultException("Request was cancelled");
        case DioExceptionType.badResponse:
          throw DefaultException("Request was cancelled");
        case DioExceptionType.connectionError:
          throw DefaultException("Request was cancelled");
      }
    } else {
      throw DefaultException(error.toString());
    }
  }
}
