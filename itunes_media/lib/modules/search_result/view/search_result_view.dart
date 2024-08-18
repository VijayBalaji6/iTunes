import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itunes_media/modules/itunes_search/model/itunes_model.dart';
import 'package:itunes_media/modules/itunes_search/view_model/itunes_search_view_model.dart';
import 'package:itunes_media/modules/search_result/model/media_type_model.dart';
import 'package:itunes_media/modules/search_result/view/search_result_grid_view.dart';
import 'package:itunes_media/modules/search_result/view/search_result_list_view.dart';
import 'package:itunes_media/modules/search_result/view_model/seacrch_result_view_model.dart';

class SearchDataView extends StatelessWidget {
  const SearchDataView({super.key, required this.searchDataResult});
  final Map<MediaType, List<Results>> searchDataResult;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final isListView = ref.watch(searchDataViewModelProvider);
        final String searchedContent = ref.read(searchInputProvider);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: .8.sw,
                        child: Text(
                          "Search result : $searchedContent",
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                          onPressed: () => ref
                              .read(searchDataViewModelProvider.notifier)
                              .toggleView(),
                          icon: Icon(isListView
                              ? Icons.list_rounded
                              : Icons.grid_view)),
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                      child: isListView
                          ? SearchResultListView(
                              searchResult: searchDataResult,
                            )
                          : SearchResultGridView(
                              searchResult: searchDataResult,
                            ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
