import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_media/common/api_handler/api_response_state.dart';
import 'package:itunes_media/modules/itunes_search/model/itunes_model.dart';
import 'package:itunes_media/modules/itunes_search/model/search_input_model.dart';
import 'package:itunes_media/modules/itunes_search/repository/itunes_repo.dart';

final iTunesSearchViewProvider =
    StateNotifierProvider<ITunesSearchViewModel, ApiResponseState<ItunesModel>>(
        (ref) {
  return ITunesSearchViewModel(itunesRepo: ref.read(itunesRepositoryProvider));
});

class ITunesSearchViewModel
    extends StateNotifier<ApiResponseState<ItunesModel>> {
  ITunesSearchViewModel({required this.itunesRepo})
      : super(ApiResponseState.initial());
  final ItunesRepository itunesRepo;
  Future<void> fetchItems(
    SearchInputModel searchInputModel,
  ) async {
    state = ApiResponseState.loading("Loading");
    try {
      ItunesModel itunesApiResponse =
          await itunesRepo.fetchItunesData(contentToSearch: searchInputModel);
      state = ApiResponseState.completed(itunesApiResponse);
    } catch (e) {
      state = ApiResponseState.error(e.toString());
    }
  }
}
