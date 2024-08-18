import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.loadingMessage});
  final String? loadingMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.orange,
          ),
          SizedBox(
            height: 0.05.sh,
          ),
          Text(
            loadingMessage ?? "Loading....",
            style: TextStyle(color: Colors.orange, fontSize: 16.sp),
          )
        ],
      ),
    );
  }
}
