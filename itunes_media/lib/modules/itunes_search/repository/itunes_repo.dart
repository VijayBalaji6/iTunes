import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_media/common/api_handler/api_service.dart';
import 'package:itunes_media/modules/itunes_search/model/itunes_model.dart';
import 'package:itunes_media/modules/itunes_search/model/search_input_model.dart';

final itunesRepositoryProvider =
    Provider<ItunesRepository>((ref) => ItunesRepositoryImpl());

abstract class ItunesRepository {
  Future<ItunesModel> fetchItunesData(
      {required SearchInputModel contentToSearch});
}

class ItunesRepositoryImpl extends ItunesRepository {
  @override
  Future<ItunesModel> fetchItunesData(
      {required SearchInputModel contentToSearch}) async {
    try {
      final query = {'term': contentToSearch.searchTerm};
      if (contentToSearch.mediaType != "") {
        query['media'] = contentToSearch.mediaType;
      }
      final response = await ApiService.get('https://itunes.apple.com/search',
          params: query);

      final ItunesModel itunesData =
          ItunesModel.fromJson(jsonDecode(response.data));
      return itunesData;
    } catch (e) {
      rethrow;
    }
  }
}
