import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';

class SecureApiClient {
  late Dio _dio;

  SecureApiClient() {
    _dio = Dio();

    _initializeDio();
  }

  void _initializeDio() async {
    try {
      final sslCert =
          await rootBundle.load('assets/certificates/itunes_certificate.pem');
      SecurityContext context = SecurityContext(withTrustedRoots: false);

      context.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

      final httpClient = HttpClient(context: context);
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;

      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        return httpClient;
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> makeSecureRequest() async {
    try {
      final response = await _dio.get('https://itunes.apple.com');
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}
