enum MediaType {
  book,
  album,
  coachedAudio,
  featureMovie,
  interactiveBooklet,
  musicVideo,
  pdf,
  podcast,
  podcastEpisode,
  softwarePackage,
  song,
  tvEpisode,
  artist,
}

extension MediaTypeExtension on MediaType {
  String get displayName {
    switch (this) {
      case MediaType.book:
        return 'Book';
      case MediaType.album:
        return 'Album';
      case MediaType.coachedAudio:
        return 'Coached Audio';
      case MediaType.featureMovie:
        return 'Feature Movie';
      case MediaType.interactiveBooklet:
        return 'Interactive Booklet';
      case MediaType.musicVideo:
        return 'Music Video';
      case MediaType.pdf:
        return 'PDF';
      case MediaType.podcast:
        return 'Podcast';
      case MediaType.podcastEpisode:
        return 'Podcast Episode';
      case MediaType.softwarePackage:
        return 'Software Package';
      case MediaType.song:
        return 'Song';
      case MediaType.tvEpisode:
        return 'TV Episode';
      case MediaType.artist:
        return 'Artist';
    }
  }
}

MediaType? mapKindToMediaType(String? kind) {
  switch (kind) {
    case 'book':
      return MediaType.book;
    case 'album':
      return MediaType.album;
    case 'coached-audio':
      return MediaType.coachedAudio;
    case 'feature-movie':
      return MediaType.featureMovie;
    case 'interactive-booklet':
      return MediaType.interactiveBooklet;
    case 'music-video':
      return MediaType.musicVideo;
    case 'pdf':
      return MediaType.pdf;
    case 'podcast':
      return MediaType.podcast;
    case 'podcast-episode':
      return MediaType.podcastEpisode;
    case 'software-package':
      return MediaType.softwarePackage;
    case 'song':
      return MediaType.song;
    case 'tv-episode':
      return MediaType.tvEpisode;
    case 'artist':
      return MediaType.artist;
    default:
      return null;
  }
}
