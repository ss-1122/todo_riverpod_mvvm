/// アプリ全体で使用するフォントサイズ定数
///
/// 用途に依存しない抽象的なサイズ名（xs〜xxxl）で定義し、
/// 4px 単位の規則的なスケールを採用する。
/// ページやウィジェットから直接参照して `TextStyle(fontSize: AppFontSize.md)` のように使用する。
abstract final class AppFontSize {
  /// xs: 8.0
  static const double xs = 8.0;

  /// sm: 12.0
  static const double sm = 12.0;

  /// md: 16.0
  static const double md = 16.0;

  /// lg: 20.0
  static const double lg = 20.0;

  /// xl: 24.0
  static const double xl = 24.0;

  /// xl2: 28.0
  static const double xl2 = 28.0;

  /// xl3: 32.0
  static const double xl3 = 32.0;

  /// xl4: 36.0
  static const double xl4 = 36.0;
}
