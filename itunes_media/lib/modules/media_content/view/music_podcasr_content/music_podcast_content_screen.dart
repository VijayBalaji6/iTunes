import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itunes_media/common/common_widgets/custom_network_image.dart';
import 'package:itunes_media/modules/itunes_search/model/itunes_model.dart';
import 'package:itunes_media/modules/media_content/view_model/auido_player_view_model.dart';

class MusicPodcastContentScreen extends ConsumerWidget {
  const MusicPodcastContentScreen({super.key, required this.contentItem});
  final Results contentItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayerState = ref.watch(audioPlayerProvider);
    final audioPlayerViewModel = ref.read(audioPlayerProvider.notifier);

    if (audioPlayerState.isLoading) {
      audioPlayerViewModel.loadAudio(contentItem.previewUrl ?? "");
    }

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CustomNetworkImage(
                    imageUrl: contentItem.artworkUrl100,
                    width: 0.40.sw,
                    height: 0.40.sw,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: .02.sh),
                Text(
                  contentItem.artistName ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: .01.sh),
                Text(
                  contentItem.trackName ?? "",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: .01.sh),
                Text(
                  contentItem.primaryGenreName ?? "",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: .01.sh),
                if (audioPlayerState.isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                else if (audioPlayerState.error != null)
                  Center(
                    child: Text(
                      'Error loading audio: ${audioPlayerState.error}',
                      style: TextStyle(color: Colors.red, fontSize: 18.sp),
                    ),
                  )
                else
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${audioPlayerState.position.inSeconds} Secs'),
                          Expanded(
                            child: Slider(
                              value: audioPlayerState.position.inSeconds
                                  .toDouble(),
                              min: 0,
                              max: audioPlayerState.duration.inSeconds
                                  .toDouble(),
                              onChanged: (value) {
                                audioPlayerViewModel
                                    .seek(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                          Text("${audioPlayerState.duration.inSeconds} Secs"),
                        ],
                      ),
                      SizedBox(height: .01.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 20.sp,
                            child: IconButton(
                              icon: Icon(
                                size: 25.sp,
                                audioPlayerState.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                audioPlayerViewModel.playPause();
                              },
                            ),
                          ),
                          SizedBox(width: .03.sw),
                          CircleAvatar(
                            radius: 20.sp,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: Icon(Icons.stop,
                                  size: 25.sp, color: Colors.black),
                              onPressed: () {
                                audioPlayerViewModel.stop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
