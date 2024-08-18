import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itunes_media/common/common_widgets/custom_network_image.dart';
import 'package:itunes_media/common/helper/helper.dart';
import 'package:itunes_media/modules/itunes_search/model/itunes_model.dart';

class ContentDetailScreen extends StatelessWidget {
  const ContentDetailScreen({super.key, required this.contentItem});
  final Results contentItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Description',
            style: TextStyle(color: Color.fromARGB(255, 137, 93, 93))),
        centerTitle: true,
      ),
      body: SizedBox(
        width: 100.sw,
        height: 100.sh,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CustomNetworkImage(
                        imageUrl: contentItem.artworkUrl100,
                        width: 0.30.sw,
                        height: 0.30.sw,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: .03.sw),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contentItem.artistName ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            contentItem.trackName ?? "",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: .008.sh),
                          Text(
                            contentItem.primaryGenreName ?? "",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 16.sp,
                            ),
                          ),
                          IconButton(
                            onPressed: () => HelperFunction.launchURL(
                                context: context,
                                url: contentItem.collectionArtistViewUrl),
                            icon: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.movie,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Preview',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: .01.sh),
                Text(
                  'Preview',
                  style: TextStyle(color: Colors.white70, fontSize: 18.sp),
                ),
                SizedBox(height: .01.sh),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CustomNetworkImage(
                    imageUrl: contentItem.artworkUrl100,
                    width: double.infinity,
                    height: 0.30.sh,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Description',
                  style: TextStyle(color: Colors.white70, fontSize: 18.sp),
                ),
                SizedBox(height: .01.sh),
                Text(
                  contentItem.longDescription ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
