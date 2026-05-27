// convenience extension on duration
// used throughout the recording and meeting UIs

extension DurationExtension on Duration {
  // returns "mm:ss" for durations under an hour, "h:mm:ss" otherwise
  // examples: 3:07 | 1:02:45
  String toTimerString() {
    final h = inHours;
    final m = inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  // returns a compact human label
  String toHumanLabel() {
    if (inSeconds < 60) return '${inSeconds}s';
    if (inMinutes < 60) return '${inMinutes}m';
    final h = inHours;
    final m = inMinutes.remainder(60);
    return m > 0 ? '${h}h ${m}m' : '${h}h';
  }

  // true when the duration is zero or negative
  bool get isZeroOrNegative => inSeconds <= 0;
}
