import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> initTimeZone() async {
  tz.initializeTimeZones();

  try {
    final localZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localZone.identifier));
  } catch (e) {
    tz.setLocalLocation(tz.getLocation('Etc/UTC'));
  }
}
