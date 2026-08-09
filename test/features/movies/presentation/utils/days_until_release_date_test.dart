import 'package:cine_scope/core/extensions/datetime_extensions.dart';
import 'package:cine_scope/features/movies/presentation/utils/days_until_release_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return number of days until release date', () {
    final releaseDate = DateTime.now().add(const Duration(days: 3));
    expect(daysUntilReleaseDate(releaseDate), 3);
  });

  test('should return null when release date is in the past', () {
    final releaseDate = DateTime.now().normalize.subtract(
      const Duration(minutes: 1),
    );
    expect(daysUntilReleaseDate(releaseDate), null);
  });

  test('should return 0 when release date is today', () {
    final releaseDate = DateTime.now();

    expect(daysUntilReleaseDate(releaseDate), 0);
  });

  test('should return 0 when release date is today 12 hours left', () {
    final releaseDate = DateTime.now().normalize.add(const Duration(hours: 12));

    expect(daysUntilReleaseDate(releaseDate), 0);
  });
}
