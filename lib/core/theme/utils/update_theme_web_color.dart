import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

void updateWebThemeColor(ThemeMode theme) {
  if (!kIsWeb) return;

  final hexColor = theme == ThemeMode.dark ? "#0A192F" : "#FFFFFF";

  final metas = web.document.getElementsByTagName('meta');

  for (int i = 0; i < metas.length; i++) {
    final meta = metas.item(i) as web.HTMLMetaElement;

    if (meta.name == 'theme-color') {
      meta.content = hexColor;
      return;
    }
  }

  final newMeta = web.document.createElement('meta') as web.HTMLMetaElement;
  newMeta.name = 'theme-color';
  newMeta.content = hexColor;
  web.document.head?.appendChild(newMeta);
}
