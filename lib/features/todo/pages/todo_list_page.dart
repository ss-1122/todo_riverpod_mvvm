import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_mvvm/core/constants/app_spacing.dart';
import 'package:todo_riverpod_mvvm/core/constants/filter_type.dart';
import 'package:todo_riverpod_mvvm/core/router/app_router.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/notifier/todo_notifier.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/delete_todo_usecase.dart';

/// Todo一覧画面（Tab 1 のルート画面）
///
/// - フィルタチップで全て / 未完了 / 完了 の絞り込みができる
/// - 各アイテムにチェックボックスを設け、タップで完了/未完了をトグル
/// - スワイプ（Dismissible）で削除
/// - FAB タップで Todo作成画面へ遷移（push）
/// - リストアイテムタップで Todo詳細・編集画面へ遷移（push）
class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(todoProvider);
    final currentFilter = ref.watch(
      todoProvider.notifier.select((n) => n.currentFilter),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Todo一覧')),
      body: Column(
        children: [
          // ─── フィルタチップ ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: FilterType.values
                  .map(
                    (filter) => Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: FilterChip(
                        label: Text(filter.label),
                        selected: currentFilter == filter,
                        showCheckmark: false,
                        onSelected: (_) =>
                            ref.read(todoProvider.notifier).setFilter(filter),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          // ─── Todoリスト ───────────────────────────────────────────
          Expanded(
            child: asyncTodos.when(
              data: (todos) => todos.isEmpty
                  ? const Center(child: Text('Todoがありません'))
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return _TodoListItem(
                          todo: todo,
                          onToggle: () => ref
                              .read(todoProvider.notifier)
                              .toggleCompleted(todo),
                          onDelete: () => ref
                              .read(deleteTodoUseCaseProvider)
                              .call(id: todo.id),
                          onTap: () =>
                              TodoDetailRoute(id: todo.id).push<void>(context),
                          scaffoldMessenger: ScaffoldMessenger.of(context),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('エラー: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => const CreateTodoRoute().push<void>(context),
        tooltip: 'Todo を追加',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ─── 各リストアイテム Widget ─────────────────────────────────────────────

class _TodoListItem extends StatelessWidget {
  const _TodoListItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onTap,
    required this.scaffoldMessenger,
  });

  final Todo todo;
  final Future<void> Function() onToggle;
  final Future<void> Function() onDelete;
  final VoidCallback onTap;
  final ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        try {
          await onDelete();
          return true;
        } catch (e) {
          scaffoldMessenger.showSnackBar(
            SnackBar(content: Text('削除に失敗しました: $e')),
          );
          return false;
        }
      },
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) async {
            try {
              await onToggle();
            } catch (e) {
              scaffoldMessenger.showSnackBar(
                SnackBar(content: Text('更新に失敗しました: $e')),
              );
            }
          },
        ),
        title: Text(
          todo.title,
          style: todo.isCompleted
              ? const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                )
              : null,
        ),
        subtitle: todo.memo != null && todo.memo!.isNotEmpty
            ? Text(todo.memo!, maxLines: 1, overflow: TextOverflow.ellipsis)
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
