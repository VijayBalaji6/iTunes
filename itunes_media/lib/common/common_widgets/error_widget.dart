import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ErrorViewWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorViewWidget(
      {super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/error.svg',
            height: 0.5.sw,
            width: 0.5.sw,
            allowDrawingOutsideViewBox: true,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.red, fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}
