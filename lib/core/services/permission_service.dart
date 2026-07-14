import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> checkAndRequestNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isGranted) return true;

    final result = await Permission.notification.request();
    return result.isGranted;
  }

  Future<bool> checkAndRequestBatteryOptimization() async {
    if (!Platform.isAndroid) return true;

    final isIgnoring = await Permission.ignoreBatteryOptimizations.isGranted;
    if (isIgnoring) return true;

    final result = await Permission.ignoreBatteryOptimizations.request();
    return result.isGranted;
  }
}
