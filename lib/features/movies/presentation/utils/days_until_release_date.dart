int? daysUntilReleaseDate(DateTime releaseDate) {
  final days = releaseDate.difference(DateTime.now()).inDays;
  return days < 0 ? null : days;
}
