import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_media/common/api_handler/secure_api_client.dart';

final sslCheckProvider = FutureProvider<bool>((ref) async {
  try {
    final apiClient = SecureApiClient();
    return await apiClient.makeSecureRequest();
  } catch (e) {
    return false;
  }
});
