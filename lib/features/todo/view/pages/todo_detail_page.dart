import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/notifier/todo_notifier.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/delete_todo_usecase.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/update_todo_usecase.dart';

/// Todo詳細・編集画面
///
/// - 一覧から選択したTodoの内容を表示・編集
/// - タイトル・メモの編集が可能
/// - 「更新」ボタンでDBへUpdateし、一覧画面に戻る
/// - 「削除」ボタンでDBからDeleteし、一覧画面に戻る
/// - 完了状態のトグルも可能
class TodoDetailPage extends ConsumerStatefulWidget {
  const TodoDetailPage({super.key, required this.id});

  final int id;

  @override
  ConsumerState<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends ConsumerState<TodoDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
  bool _isCompleted = false;
  bool _initialized = false;
  bool _isSaving = false;
  bool _isDeleting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _initControllers(Todo todo) {
    if (_initialized) return;
    _titleController.text = todo.title;
    _memoController.text = todo.memo ?? '';
    _isCompleted = todo.isCompleted;
    _initialized = true;
  }

  Future<void> _update(Todo original) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSaving = true);
    try {
      final updated = original.copyWith(
        title: _titleController.text.trim(),
        memo: _memoController.text.trim().isEmpty
            ? null
            : _memoController.text.trim(),
        isCompleted: _isCompleted,
      );
      await ref.read(updateTodoUseCaseProvider).call(todo: updated);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('更新に失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('削除の確認'),
        content: const Text('このTodoを削除してもよいですか？'),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => ctx.pop(true),
            child: const Text('削除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isDeleting = true);
    try {
      await ref.read(deleteTodoUseCaseProvider).call(id: widget.id);
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('削除に失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncTodo = ref.watch(todoByIdProvider(widget.id));

    return asyncTodo.when(
      data: (todo) {
        if (todo == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Todo詳細')),
            body: const Center(child: Text('Todoが見つかりませんでした')),
          );
        }
        _initControllers(todo);
        return _buildForm(context, todo);
      },
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Todo詳細')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Todo詳細')),
        body: Center(child: Text('エラー: $e')),
      ),
    );
  }

  Widget _buildForm(BuildContext context, Todo todo) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo詳細・編集'),
        actions: [
          IconButton(
            icon: _isDeleting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete_outline),
            tooltip: '削除',
            onPressed: (_isSaving || _isDeleting) ? null : _delete,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ─── 完了トグル ─────────────────────────────────────────
            SwitchListTile(
              title: const Text('完了'),
              value: _isCompleted,
              onChanged: (val) => setState(() => _isCompleted = val),
            ),
            const SizedBox(height: 8),
            // ─── タイトル ────────────────────────────────────────────
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'タイトル *',
                border: OutlineInputBorder(),
              ),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'タイトルを入力してください'
                  : null,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            // ─── メモ ────────────────────────────────────────────────
            TextFormField(
              controller: _memoController,
              decoration: const InputDecoration(
                labelText: 'メモ（任意）',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 24),
            // ─── 更新ボタン ──────────────────────────────────────────
            FilledButton(
              onPressed:
                  (_isSaving || _isDeleting) ? null : () => _update(todo),
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('更新'),
            ),
          ],
        ),
      ),
    );
  }
}
