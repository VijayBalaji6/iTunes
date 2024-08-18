import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperFunction {
  static Future<void> launchURL(
      {required BuildContext context, required String? url}) async {
    if (url != null) {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
        );
      } else {
        await errorLoadingUrlPreview();
      }
    } else {
      await errorLoadingUrlPreview();
    }
  }

  static Future<void> errorLoadingUrlPreview() async {
    await Fluttertoast.showToast(
        msg: 'Error loading preview',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
