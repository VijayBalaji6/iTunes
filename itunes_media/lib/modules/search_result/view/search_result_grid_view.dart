import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itunes_media/common/common_widgets/custom_network_image.dart';
import 'package:itunes_media/modules/itunes_search/model/itunes_model.dart';
import 'package:itunes_media/modules/media_content/view/content_details/content_details_screen.dart';
import 'package:itunes_media/modules/media_content/view/music_podcasr_content/music_podcast_content_screen.dart';
import 'package:itunes_media/modules/search_result/model/media_type_model.dart';
import 'package:itunes_media/modules/search_result/view/widgets/media_banner.dart';

class SearchResultGridView extends StatelessWidget {
  const SearchResultGridView({super.key, required this.searchResult});

  final Map<MediaType, List<Results>> searchResult;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        final mediaType = searchResult.keys.elementAt(index);
        final items = searchResult[mediaType]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentTypeBanner(
                mediaTypeName: mediaType.name, mediaItemCount: items.length),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => (mediaType == MediaType.song)
                          ? MusicPodcastContentScreen(
                              contentItem: item,
                            )
                          : ContentDetailScreen(
                              contentItem: item,
                            ))),
                  child: GridTile(
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomNetworkImage(
                            imageUrl: item.artworkUrl100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: .010.sh),
                        Text(
                          item.trackName ?? 'Unknown Title',
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
