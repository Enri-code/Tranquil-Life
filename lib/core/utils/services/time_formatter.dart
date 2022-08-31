abstract class TimeFormatter {
  static String toTimerString(int milliseconds) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '';
    final mins = twoDigits(duration.inMinutes.remainder(60));
    final secs = twoDigits(duration.inSeconds.remainder(60));
    return "$hours$mins:$secs";
  }

  static String toReadableString(int milliseconds) {
    final difference = Duration(milliseconds: milliseconds);
    if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes';
    } else if (difference.inMinutes >= 1) {
      return '1 minute';
    } else if (difference.inSeconds != 1) {
      return '${difference.inSeconds} seconds';
    } else {
      return '1 second';
    }
  }
}
