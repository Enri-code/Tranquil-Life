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

abstract class CardNumberFormatter {
  static String formatNumber(String number, {String? obscureChar}) {
    return _spaceChars(_hideChars(number, obscureChar));
  }

  static String _hideChars(String value, String? obscureChar) {
    if (value.length < 8) return value;
    const startIndex = 4;
    final endIndex = value.length - 4;
    final hiddenChars = value
        .substring(startIndex, endIndex)
        .replaceAll(RegExp('[0-9]'), obscureChar ?? '_');
    return '${value.substring(0, startIndex)}$hiddenChars${value.substring(endIndex)}';
  }

  static String _spaceChars(String value) {
    final result = RegExp('.{1,4}').allMatches(value).map((e) => e[0]);
    return result.join(' ');
  }
}
