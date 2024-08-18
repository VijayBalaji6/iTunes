import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchDataViewModel extends StateNotifier<bool> {
  SearchDataViewModel() : super(true);

  void toggleView() {
    state = !state;
  }
}

final searchDataViewModelProvider =
    StateNotifierProvider<SearchDataViewModel, bool>(
        (ref) => SearchDataViewModel());
