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
}
