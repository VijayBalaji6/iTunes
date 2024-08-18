import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentTypeBanner extends StatelessWidget {
  const ContentTypeBanner({
    super.key,
    required this.mediaTypeName,
    required this.mediaItemCount,
  });

  final String mediaTypeName;
  final int mediaItemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: .02.sh),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mediaTypeName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    mediaItemCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: .02.sh),
      ],
    );
  }
}
