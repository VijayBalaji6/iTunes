import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_media/modules/itunes_search/model/search_input_model.dart';

class SearchInputNotifier extends StateNotifier<SearchInputModel> {
  SearchInputNotifier()
      : super(SearchInputModel(searchTerm: '', mediaType: ''));

  void updateSearchTerm(String searchTerm) {
    state = state.copyWith(searchTerm: searchTerm);
  }

  void updateSelectedMediaType(String selectedMediaType) {
    state = state.copyWith(mediaTypes: selectedMediaType);
  }

  void removeSelectedMediaType(String selectedMediaType) {
    state = state.copyWith(mediaTypes: '');
  }
}

final searchInputProvider =
    StateNotifierProvider<SearchInputNotifier, SearchInputModel>((ref) {
  return SearchInputNotifier();
});
