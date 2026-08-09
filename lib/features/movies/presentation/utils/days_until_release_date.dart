import 'package:cine_scope/core/extensions/datetime_extensions.dart';

int? daysUntilReleaseDate(DateTime releaseDate) {
  final normaliseToday = DateTime.now().normalize;
  final normaliseReleaseDate = releaseDate.normalize;

  final days = normaliseReleaseDate.difference(normaliseToday).inDays;
  return days < 0 ? null : days;
}
