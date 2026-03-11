import 'package:flutter/material.dart';

/// アプリのテーマ設定
abstract final class AppTheme {
  static const _fontFamily = 'NotoSansJP';

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        fontFamily: _fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      );
}
