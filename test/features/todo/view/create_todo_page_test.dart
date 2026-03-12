import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/features/todo/pages/create_todo_page.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/add_todo_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository fakeRepository;

  setUp(() {
    fakeRepository = FakeTodoRepository();
  });

  tearDown(() {
    fakeRepository.dispose();
  });

  /// CreateTodoPage を ProviderScope + MaterialApp で包んでポンプするヘルパー。
  /// go_router の context.pop() をテストで安全に呼ぶため、
  /// Navigator 付きの MaterialApp でラップしている。
  Future<void> pumpCreateTodoPage(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          addTodoUseCaseProvider.overrideWithValue(
            AddTodoUseCase(fakeRepository),
          ),
        ],
        child: MaterialApp(home: const CreateTodoPage()),
      ),
    );
  }

  group('CreateTodoPage 表示テスト', () {
    testWidgets('AppBarに「Todo作成」タイトルが表示される', (tester) async {
      await pumpCreateTodoPage(tester);

      expect(find.text('Todo作成'), findsOneWidget);
    });

    testWidgets('タイトルとメモの入力フィールドが存在する', (tester) async {
      await pumpCreateTodoPage(tester);

      expect(find.text('タイトル *'), findsOneWidget);
      expect(find.text('メモ（任意）'), findsOneWidget);
    });

    testWidgets('保存ボタンが表示される', (tester) async {
      await pumpCreateTodoPage(tester);

      expect(find.text('保存'), findsOneWidget);
    });
  });

  group('CreateTodoPage バリデーションテスト', () {
    testWidgets('タイトル未入力で保存するとエラーメッセージが表示される', (tester) async {
      await pumpCreateTodoPage(tester);

      // タイトル空のまま保存ボタンをタップ
      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(find.text('タイトルを入力してください'), findsOneWidget);
      // Repository にはまだ何も追加されていない
      expect(fakeRepository.todos, isEmpty);
    });

    testWidgets('空白のみのタイトルでもバリデーションエラーになる', (tester) async {
      await pumpCreateTodoPage(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'タイトル *'),
        '   ',
      );
      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(find.text('タイトルを入力してください'), findsOneWidget);
      expect(fakeRepository.todos, isEmpty);
    });
  });

  group('CreateTodoPage 保存テスト', () {
    testWidgets('タイトルのみ入力して保存 → Repositoryに追加される', (tester) async {
      await pumpCreateTodoPage(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'タイトル *'),
        '買い物に行く',
      );
      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(fakeRepository.todos, hasLength(1));
      expect(fakeRepository.todos.first.title, '買い物に行く');
      expect(fakeRepository.todos.first.memo, isNull);
      expect(fakeRepository.todos.first.isCompleted, false);
    });

    testWidgets('タイトルとメモを入力して保存 → 両方Repositoryに反映される', (tester) async {
      await pumpCreateTodoPage(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'タイトル *'),
        '牛乳を買う',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'メモ（任意）'),
        '低脂肪乳がいい',
      );
      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(fakeRepository.todos, hasLength(1));
      expect(fakeRepository.todos.first.title, '牛乳を買う');
      expect(fakeRepository.todos.first.memo, '低脂肪乳がいい');
    });

    testWidgets('メモが空白のみの場合はnullとして保存される', (tester) async {
      await pumpCreateTodoPage(tester);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'タイトル *'),
        'テスト',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'メモ（任意）'),
        '   ',
      );
      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(fakeRepository.todos, hasLength(1));
      expect(fakeRepository.todos.first.memo, isNull);
    });
  });
}
