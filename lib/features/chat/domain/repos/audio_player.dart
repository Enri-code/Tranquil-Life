abstract class AudioPlayer {
  const AudioPlayer();

  Stream<double> get onDurationPercent;
  Stream<String> get onDurationText;

  Future init(String path);
  Future play();
  Future pause();
  Future seekTo(int milliseconds);
  Future seekToPercent(double percent);
  void dispose();
}
