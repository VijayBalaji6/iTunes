class SearchInputModel {
  String searchTerm;
  String mediaType;
  SearchInputModel({
    required this.searchTerm,
    required this.mediaType,
  });

  SearchInputModel copyWith({
    String? searchTerm,
    String? mediaTypes,
  }) {
    return SearchInputModel(
      searchTerm: searchTerm ?? this.searchTerm,
      mediaType: mediaTypes ?? this.mediaType,
    );
  }
}
