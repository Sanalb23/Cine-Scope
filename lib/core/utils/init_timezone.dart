import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> initTimeZone() async {
  tz.initializeTimeZones();

  final localZone = await FlutterTimezone.getLocalTimezone();

  tz.setLocalLocation(tz.getLocation(localZone.identifier));
}
