import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/add_todo_usecase.dart';

/// Todo作成画面
///
/// - タイトル入力フィールド（必須）
/// - メモ入力フィールド（任意・複数行）
/// - 「保存」ボタンでDBへInsertし、一覧画面に戻る
/// - バリデーション：タイトル未入力時はエラーメッセージ表示
class CreateTodoPage extends ConsumerStatefulWidget {
  const CreateTodoPage({super.key});

  @override
  ConsumerState<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends ConsumerState<CreateTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSaving = true);
    try {
      await ref.read(addTodoUseCaseProvider).call(
            title: _titleController.text.trim(),
            memo: _memoController.text.trim().isEmpty
                ? null
                : _memoController.text.trim(),
          );
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存に失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo作成')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ─── タイトル ───────────────────────────────────────────
            TextFormField(
              controller: _titleController,
              autofocus: true,
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
            // ─── メモ ───────────────────────────────────────────────
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
            // ─── 保存ボタン ──────────────────────────────────────────
            FilledButton(
              onPressed: _isSaving ? null : _save,
              child: _isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
