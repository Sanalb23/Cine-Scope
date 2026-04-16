extension DurationExtensions on Duration {
  String get hoursAndMinutesString {
    final hours = inMinutes ~/ 60;
    final minutes = inMinutes % 60;

    if (hours == 0) {
      return '$minutes min';
    }

    if (minutes == 0) {
      return '$hours h';
    }

    return '$hours h $minutes min';
  }
}
