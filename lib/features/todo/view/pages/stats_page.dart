import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo_stats.dart';
import 'package:todo_riverpod_mvvm/features/todo/notifier/stats_notifier.dart';

/// 統計画面（Tab 2 のルート画面）
///
/// - 全件数・完了数・未完了数をテキストベースで表示
/// - Drift の Stream を StatsNotifier 経由でリアルタイム監視する
class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(statsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('統計')),
      body: asyncStats.when(
        data: (stats) => _StatsContent(stats: stats),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
      ),
    );
  }
}

class _StatsContent extends StatelessWidget {
  const _StatsContent({required this.stats});

  final TodoStats stats;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Todo 統計', style: textTheme.headlineMedium),
            const SizedBox(height: 32),
            _StatCard(
              icon: Icons.list_alt,
              label: '総Todo数',
              value: stats.total,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            _StatCard(
              icon: Icons.check_circle,
              label: '完了',
              value: stats.completed,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            _StatCard(
              icon: Icons.radio_button_unchecked,
              label: '未完了',
              value: stats.incompleted,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label, style: textTheme.titleLarge),
            ),
            Text(
              '$value 件',
              style: textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
