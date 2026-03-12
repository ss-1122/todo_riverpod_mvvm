# Project Details

## Directory Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_font_size.dart
│   │   ├── app_spacing.dart
│   │   └── filter_type.dart
│   ├── database/
│   │   ├── app_database.dart                    ← @DriftDatabase
│   │   ├── app_database.g.dart                  ← 自動生成
│   │   └── tables/
│   │       └── todo_table.dart                  ← Driftテーブル定義
│   ├── router/
│   │   ├── app_router.dart                      ← @TypedStatefulShellRoute
│   │   └── app_router.g.dart                    ← 自動生成
│   └── theme/
│       └── app_theme.dart
└── features/
    └── todo/
        ├── pages/
        │   ├── todo_list_page.dart              ← ConsumerWidget
        │   ├── create_todo_page.dart
        │   ├── todo_detail_page.dart
        │   └── stats_page.dart
        ├── notifier/                            ← ViewModel層
        │   ├── todo_notifier.dart               ← @riverpod + AsyncNotifier<List<Todo>>
        │   ├── todo_notifier.g.dart             ← 自動生成
        │   ├── stats_notifier.dart              ← @riverpod + StreamNotifier<TodoStats>
        │   └── stats_notifier.g.dart            ← 自動生成
        ├── usecase/
        │   ├── get_todos_usecase.dart
        │   ├── get_todos_usecase.g.dart         ← @riverpod Provider
        │   ├── get_todo_by_id_usecase.dart
        │   ├── get_todo_by_id_usecase.g.dart
        │   ├── get_stats_usecase.dart
        │   ├── get_stats_usecase.g.dart
        │   ├── add_todo_usecase.dart
        │   ├── add_todo_usecase.g.dart
        │   ├── update_todo_usecase.dart
        │   ├── update_todo_usecase.g.dart
        │   ├── delete_todo_usecase.dart
        │   └── delete_todo_usecase.g.dart
        ├── repository/
        │   ├── todo_local_source.dart           ← @DriftAccessor
        │   ├── todo_local_source.g.dart         ← 自動生成
        │   ├── todo_repository_impl.dart
        │   ├── todo_repository_provider.dart    ← @riverpod Provider
        │   └── todo_repository_provider.g.dart  ← 自動生成
        └── domain/
            ├── entity/
            │   ├── todo.dart                    ← @freezed
            │   ├── todo.freezed.dart            ← 自動生成
            │   ├── todo_stats.dart              ← @freezed
            │   └── todo_stats.freezed.dart      ← 自動生成
            └── repository/
                └── todo_repository.dart         ← abstract interface
```

## Architecture Pattern

本プロジェクトは、**Riverpod + MVVM** アーキテクチャで構築されています。

### 層の責務分離

| 層             | 責務                         | ファイル例                                                              |
| -------------- | ---------------------------- | ----------------------------------------------------------------------- |
| **View**       | UI描画・ユーザー操作受け取り | `todo_list_page.dart` (`ConsumerWidget`)                                |
| **ViewModel**  | 状態管理・ビジネスロジック   | `todo_notifier.dart` (`AsyncNotifier`)                                  |
| **UseCase**    | ビジネス手順の組み立て       | `add_todo_usecase.dart`                                                 |
| **Repository** | データアクセス定義と実装     | `todo_repository.dart` (interface) / `todo_repository_impl.dart` (実装) |
| **Domain**     | エンティティ・純粋Dart       | `todo.dart` (`@freezed`)                                                |

### キーポイント

- **Riverpod による DI**: `ref.watch()` でProvider間の依存を解決
- **AsyncNotifier**: フィルタ状態を保持し、DB変更をリアルタイム監視
- **Drift**: SQLiteアクセス + Stream監視で自動更新
- **コード生成**: `freezed`, `drift_dev`, `riverpod_generator`, `go_router_builder` で自動生成

## Used Libraries & Versions

### 共通ライブラリ

- **flutter**: SDK (`>=3.10.3 <4.0.0`)
- **go_router**: `^17.1.0` - ナビゲーション
- **freezed_annotation**: `^3.1.0` - モデル定義用アノテーション
- **drift**: `^2.23.1` - SQLite ORM
- **sqlite3_flutter_libs**: `^0.5.42` - SQLite 実装
- **path_provider**: `^2.1.5` - ファイルパス取得
- **path**: `^1.9.0` - パスユーティリティ

### 状態管理（Riverpod固有）

- **flutter_riverpod**: `^3.2.1` - 状態管理フレームワーク
- **riverpod_annotation**: `^4.0.2` - `@riverpod` アノテーション

### 開発ツール（コード生成）

- **build_runner**: `^2.12.2` - コード生成エンジン
- **freezed**: `^3.2.5` - エンティティ生成
- **json_serializable**: `^6.8.0` - JSON シリアライゼーション
- **drift_dev**: `^2.23.1` - Drift コード生成
- **go_router_builder**: `^4.2.0` - 型安全ナビゲーション
- **riverpod_generator**: `^4.0.3` - Riverpod Provider 自動生成
- **riverpod_lint**: `^3.1.3` - Riverpod Lint ルール

## Project Features

### 1. **Riverpod × MVVM 構成**

- ViewModelは `AsyncNotifier<T>` で定義
- View（`ConsumerWidget`）は `ref.watch()` でViewModelを購読
- 状態変化が自動的にUI再構築をトリガー

### 2. **フィルタリング実装**

- ViewModelで `_filter` と `_allTodos` をフィールド保持
- DB には全件取得（`watchAll()`）のみ実行
- メモリ上のList操作でフィルタ適用（シンプル・効率的）

### 3. **Stream監視パターン**

- `TodoNotifier`: `AsyncNotifier` - 追加のフィールド必要（フィルタ state）
- `StatsNotifier`: `StreamNotifier` - Stream をそのまま返す（追加フィールド不要）

### 4. **型安全ナビゲーション**

- `go_router_builder` で `@TypedGoRoute` 定義
- BottomNavigationBar + StatefulShellRoute で Tab 管理
- 遷移時の型チェックが実行時に確保される

### 5. **自動コード生成活用**

- **Freezed**: `==`, `hashCode`, `copyWith` 自動生成
- **Drift**: テーブルクエリ・DAO 自動生成
- **Riverpod Generator**: Provider 定義の簡潔化
- **Go Router Builder**: ルート定義の型安全化

### 6. **データベース設計**

- **Todos テーブル**: `id`, `title`, `memo`, `is_completed` (snake_case → camelCase 変換)
- **Drift DAO**: `watchAll()` (Stream) + `findById()` (Future)
- **Repository**: LocalSource経由でDrift操作を抽象化

---

このプロジェクトは、**Riverpod + MVVM + Drift を組み合わせた実践的な Flutterアプリケーション アーキテクチャ** の学習教材です。
