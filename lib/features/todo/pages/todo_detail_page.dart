import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_riverpod_mvvm/core/constants/app_spacing.dart';
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
  ProviderSubscription<AsyncValue<Todo?>>? _todoSubscription;

  @override
  void initState() {
    super.initState();
    _todoSubscription = ref.listenManual(
      todoByIdProvider(widget.id),
      (_, next) {
        if (_initialized) return;
        final todo = next.asData?.value;
        if (todo == null) return;
        setState(() {
          _titleController.text = todo.title;
          _memoController.text = todo.memo ?? '';
          _isCompleted = todo.isCompleted;
          _initialized = true;
        });
      },
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    _todoSubscription?.close();
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
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
    final todo = asyncTodo.asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo詳細'),
        actions: [
          if (todo != null)
            IconButton(
              icon: _isDeleting
                  ? const SizedBox(
                      height: AppSpacing.xl,
                      width: AppSpacing.xl,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
              tooltip: '削除',
              onPressed: (_isSaving || _isDeleting) ? null : _delete,
            ),
        ],
      ),
      body: asyncTodo.when(
        data: (todo) {
          if (todo == null) {
            return const Center(child: Text('Todoが見つかりませんでした'));
          }
          return _FormBody(
            todo: todo,
            formKey: _formKey,
            titleController: _titleController,
            memoController: _memoController,
            isCompleted: _isCompleted,
            isSaving: _isSaving,
            isDeleting: _isDeleting,
            onCompletedChanged: (val) => setState(() => _isCompleted = val),
            onUpdate: () => _update(todo),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody({
    required this.todo,
    required this.formKey,
    required this.titleController,
    required this.memoController,
    required this.isCompleted,
    required this.isSaving,
    required this.isDeleting,
    required this.onCompletedChanged,
    required this.onUpdate,
  });

  final Todo todo;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController memoController;
  final bool isCompleted;
  final bool isSaving;
  final bool isDeleting;
  final ValueChanged<bool> onCompletedChanged;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // ─── 完了トグル ─────────────────────────────────────────
          SwitchListTile(
            title: const Text('完了'),
            value: isCompleted,
            onChanged: onCompletedChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
          // ─── タイトル ────────────────────────────────────────────
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'タイトル *',
              border: OutlineInputBorder(),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'タイトルを入力してください'
                : null,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.lg),
          // ─── メモ ────────────────────────────────────────────────
          TextFormField(
            controller: memoController,
            decoration: const InputDecoration(
              labelText: 'メモ（任意）',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 4,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: AppSpacing.xl2),
          // ─── 更新ボタン ──────────────────────────────────────────
          FilledButton(
            onPressed: (isSaving || isDeleting) ? null : onUpdate,
            child: isSaving
                ? const SizedBox(
                    height: AppSpacing.xl,
                    width: AppSpacing.xl,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('更新'),
          ),
        ],
      ),
    );
  }
}
