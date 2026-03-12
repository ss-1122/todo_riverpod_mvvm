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

```
test/
├── widget_test.dart                             ← スモークテスト（プレースホルダ）
├── helpers/
│   ├── fake_todo_repository.dart               ← FakeTodoRepository（手動スタブ）
│   └── fake_todo_local_source.dart             ← FakeTodoLocalSource（手動スタブ）
└── features/
    └── todo/
        ├── notifier/                            ← ViewModelレイヤーのユニットテスト
        │   ├── todo_notifier_test.dart
        │   └── stats_notifier_test.dart
        ├── repository/                          ← データ層のユニットテスト
        │   └── todo_repository_impl_test.dart
        ├── usecase/                             ← ドメイン層のユニットテスト
        │   ├── add_todo_usecase_test.dart
        │   ├── delete_todo_usecase_test.dart
        │   ├── get_stats_usecase_test.dart
        │   ├── get_todo_by_id_usecase_test.dart
        │   ├── get_todos_usecase_test.dart
        │   └── update_todo_usecase_test.dart
        └── view/                                ← Viewレイヤーのウィジェットテスト
            └── create_todo_page_test.dart
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

## Testing

### テスト方針

外部モックライブラリ（mockito 等）を使わず、`flutter_test` のみで完結する **手動スタブ方式** を採用している。
実DBや実ネットワークへの依存を排除し、高速・安定したテストを実現する。

### テストヘルパー

| ファイル                              | 役割                                                                                                           |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `helpers/fake_todo_repository.dart`   | `TodoRepository` インタフェースの手動スタブ。内部に `List<Todo>` を保持し、`StreamController` で変更を通知する |
| `helpers/fake_todo_local_source.dart` | Drift DAO（`TodoLocalSource`）の手動スタブ。DB接続なしでマッピングロジックを検証するために使用                 |

### テストの種類と対象レイヤー

| ディレクトリ  | 種類               | 対象レイヤー | 内容                                                                                                                           |
| ------------- | ------------------ | ------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| `notifier/`   | ユニットテスト     | ViewModel    | `ProviderContainer` を使い、フィルタ切替・完了トグル・統計集計のロジックを検証。実DBなしで `FakeTodoRepository` を DI Override |
| `repository/` | ユニットテスト     | データ       | `TodoData`（DB型）⇔ `Todo`（ドメイン型）のマッピング変換が正しいことを検証                                                     |
| `usecase/`    | ユニットテスト     | ドメイン     | 各UseCaseが `FakeTodoRepository` に対して正しくCRUD操作を行うかを検証                                                          |
| `view/`       | ウィジェットテスト | View         | `WidgetTester` で画面を描画し、UI表示・バリデーション・ユーザー操作の結果を検証                                                |

### 各テストファイルの内容

#### notifier/

- **`todo_notifier_test.dart`**: 初期Todoリスト取得、フィルタ変更（completed / incomplete）、`toggleCompleted` によるDB更新通知の反映
- **`stats_notifier_test.dart`**: 初期統計値（total / completed / incomplete）の算出、Todo追加後の統計リアルタイム更新

#### repository/

- **`todo_repository_impl_test.dart`**: `TodoData → Todo`（toDomain）および `Todo → TodoData`（toData）のフィールドマッピング検証。`memo` が null の場合も正しく扱えることを確認

#### usecase/

- **`add_todo_usecase_test.dart`**: タイトルのみ、タイトル＋メモ、複数追加のケースを検証
- **`delete_todo_usecase_test.dart`**: 指定IDのTodoが削除されることを検証
- **`update_todo_usecase_test.dart`**: 既存Todoのタイトル・完了状態更新を検証
- **`get_todos_usecase_test.dart`**: 全Todo取得のStreamが正しく流れることを検証
- **`get_todo_by_id_usecase_test.dart`**: 存在するID・存在しないIDで `findById` の結果を検証
- **`get_stats_usecase_test.dart`**: 全件・完了・未完了の件数が正しく算出されることを検証

#### view/

- **`create_todo_page_test.dart`**: `CreateTodoPage` のウィジェットテスト。`ProviderScope` + `MaterialApp` でページをポンプして以下を検証
  - 表示：AppBarタイトル、入力フィールド、保存ボタンの存在
  - バリデーション：タイトル未入力・空白のみでエラーメッセージ表示
  - 保存：タイトルのみ / タイトル＋メモ / メモ空白→null の各パターン

### テスト実行コマンド

```bash
# 全テストを実行
flutter test

# 特定ファイルのみ実行
flutter test test/features/todo/view/create_todo_page_test.dart
```

---

このプロジェクトは、**Riverpod + MVVM + Drift を組み合わせた実践的な Flutterアプリケーション アーキテクチャ** の学習教材です。
