import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_media/modules/media_content/model/audio_player_state.dart';
import 'package:just_audio/just_audio.dart';


class AudioPlayerViewModel extends StateNotifier<AudioPlayerState> {
  final AudioPlayer _audioPlayer;

  AudioPlayerViewModel(this._audioPlayer) : super(AudioPlayerState());

  Future<void> loadAudio(String url) async {
    if (!state.isLoading) return;
    try {
      await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
      state = state.copyWith(isLoading: false);
      _audioPlayer.durationStream.listen((duration) {
        state = state.copyWith(duration: duration ?? Duration.zero);
      });
      _audioPlayer.positionStream.listen((position) {
        state = state.copyWith(position: position);
      });
      _audioPlayer.playerStateStream.listen((playerState) {
        state = state.copyWith(isPlaying: playerState.playing);
      });
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void playPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void stop() {
    _audioPlayer.stop();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerViewModel, AudioPlayerState>((ref) {
  return AudioPlayerViewModel(AudioPlayer());
});
