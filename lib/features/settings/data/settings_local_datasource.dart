import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDatasource {
  final SharedPreferences _prefs;

  SettingsLocalDatasource({required SharedPreferences prefs}) : _prefs = prefs;

  String? getTheme() {
    return _prefs.getString('theme');
  }

  Future<void> setTheme(String theme) async {
    await _prefs.setString('theme', theme);
  }

  bool hasSeenWatchlistTooltip() {
    return _prefs.getBool('has_seen_watchlist_tooltip') ?? false;
  }

  Future<void> setHasSeenWatchlistTooltip(bool seen) async {
    await _prefs.setBool('has_seen_watchlist_tooltip', seen);
  }

  bool hasSeenMobileNotificationDialog() {
    return _prefs.getBool('has_seen_mobile_notification_dialog') ?? false;
  }

  Future<void> setHasSeenMobileNotificationDialog(bool seen) async {
    await _prefs.setBool('has_seen_mobile_notification_dialog', seen);
  }
}
