import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_scope/core/config/environment.dart';

final apiKeyProvider = Provider<String>((ref) {
  return Environment.apiKey;
});
