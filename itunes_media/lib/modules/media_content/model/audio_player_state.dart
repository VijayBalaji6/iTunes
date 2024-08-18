class AudioPlayerState {
  final bool isPlaying;
  final Duration duration;
  final Duration position;
  final String? error;
  final bool isLoading;

  AudioPlayerState({
    this.isPlaying = false,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.error,
    this.isLoading = true,
  });

  AudioPlayerState copyWith({
    bool? isPlaying,
    Duration? duration,
    Duration? position,
    String? error,
    bool? isLoading,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
