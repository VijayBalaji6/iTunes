import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itunes_media/modules/splash/view_model/security_check_provider.dart';

class FailedSecurityMessagePopUp {
  static void showSecurityWarning(
      {required BuildContext context, required SecurityCheckStatus status}) {
    String message;
    if (status == SecurityCheckStatus.failedRoot) {
      message =
          'This device is rooted/jailbroken. For security reasons, this app will not run on compromised devices.';
    } else if (status == SecurityCheckStatus.failedSSL) {
      message =
          'SSL certificate validation failed. Please ensure you have a secure connection.';
    } else {
      message =
          'This device did not pass security checks. For security reasons, this app will not run.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Security Warning'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 200), () {
                  SystemNavigator.pop();
                });
              },
            ),
          ],
        );
      },
      barrierDismissible: false,
    );
  }
}
