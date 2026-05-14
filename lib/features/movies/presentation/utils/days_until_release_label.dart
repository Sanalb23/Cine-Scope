String? daysUntilReleaseLabel(DateTime releaseDate) {
  final days = releaseDate.difference(DateTime.now()).inDays;
  return switch (days) {
    > 1 => '$days days',
    1 => 'Tomorrow',
    0 => 'Today',
    _ => null,
  };
}
