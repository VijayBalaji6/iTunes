import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_media/common/common_widgets/error_widget.dart';
import 'package:itunes_media/common/common_widgets/loading_widget.dart';
import 'package:itunes_media/modules/itunes_search/view/search_view/search_media_screen.dart';
import 'package:itunes_media/modules/splash/view_model/security_check_provider.dart';
import 'package:itunes_media/modules/splash/widget/failed_security_message_popup.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final securityCheckAsyncValue = ref.watch(securityCheckProvider);

    return Scaffold(
      body: securityCheckAsyncValue.when(
        data: (securityStatus) {
          if (securityStatus == SecurityCheckStatus.passed) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SearchMediaScreen()));
            });
            return const Center(
              child: Text(
                'Device passed security checks.',
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              FailedSecurityMessagePopUp.showSecurityWarning(
                  context: context, status: securityStatus);
            });
            return const Center(
              child: Text(
                'Device failed security checks.',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          }
        },
        loading: () => const LoadingWidget(
          loadingMessage: "Checking application security",
        ),
        error: (err, stack) => ErrorViewWidget(
          message: 'Error: $err',
          onRetry: null,
        ),
      ),
    );
  }
}
