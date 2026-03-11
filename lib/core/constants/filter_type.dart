/// Todoリストのフィルタ状態
enum FilterType {
  all('すべて'),
  incomplete('未完了'),
  completed('完了');

  const FilterType(this.label);

  final String label;
}
