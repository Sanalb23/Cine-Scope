import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefsInstanceProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Prefs instance not initialized');
});
