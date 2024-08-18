import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_media/modules/splash/view_model/root_detection_provider.dart';
import 'package:itunes_media/modules/splash/view_model/ssl_checker_provider.dart';

enum SecurityCheckStatus { passed, failedRoot, failedSSL }

final securityCheckProvider = FutureProvider<SecurityCheckStatus>((ref) async {
  final isRooted = await ref.watch(rootDetectionProvider.future);
  final sslCheckPassed = await ref.watch(sslCheckProvider.future);

  if (isRooted) {
    return SecurityCheckStatus.failedRoot;
  } else if (!sslCheckPassed) {
    return SecurityCheckStatus.failedSSL;
  } else {
    return SecurityCheckStatus.passed;
  }
});
