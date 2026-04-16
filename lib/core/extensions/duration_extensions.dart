extension DurationExtensions on Duration {
  String get hoursAndMinutesString {
    final hours = inMinutes ~/ 60;
    final minutes = inMinutes % 60;
    return '$hours h $minutes min';
  }
}
