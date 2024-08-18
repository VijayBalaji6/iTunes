import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_media/common/api_handler/api_response_state.dart';
import 'package:itunes_media/common/common_widgets/error_widget.dart';
import 'package:itunes_media/common/common_widgets/loading_widget.dart';
import 'package:itunes_media/modules/itunes_search/model/itunes_model.dart';
import 'package:itunes_media/modules/itunes_search/view_model/itunes_search_view_model.dart';
import 'package:itunes_media/modules/search_result/model/media_type_model.dart';
import 'package:itunes_media/modules/search_result/view/search_result_view.dart';

class SearchResultScreen extends ConsumerWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(iTunesSearchViewProvider);
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            switch (state.status) {
              case Status.loading:
                return const LoadingWidget();
              case Status.completed:
                final Map<MediaType, List<Results>> groupedResults = {};

                for (var item in state.data?.results ?? []) {
                  final kind = mapKindToMediaType(item.kind);
                  if (kind != null) {
                    groupedResults.putIfAbsent(kind, () => []).add(item);
                  }
                }
                return SearchDataView(searchDataResult: groupedResults);
              case Status.error:
                return ErrorViewWidget(
                  message: state.message ?? "Error",
                  onRetry: () {
                    ref.read(iTunesSearchViewProvider.notifier).fetchItems(
                        ref.watch(searchInputProvider.notifier).state);
                  },
                );
              default:
                return const Center(
                  child: Text(
                    'Enter a search term to begin',
                    style: TextStyle(color: Colors.white70),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
