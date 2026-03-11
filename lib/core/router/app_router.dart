import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/core/constants/app_font_size.dart';
import 'package:todo_riverpod_mvvm/features/todo/pages/create_todo_page.dart';
import 'package:todo_riverpod_mvvm/features/todo/pages/stats_page.dart';
import 'package:todo_riverpod_mvvm/features/todo/pages/todo_detail_page.dart';
import 'package:todo_riverpod_mvvm/features/todo/pages/todo_list_page.dart';

part 'app_router.g.dart';

// ─── ルート定義 ─────────────────────────────────────────────

@TypedStatefulShellRoute<MainShellRouteData>(
  branches: [
    TypedStatefulShellBranch<TodoBranchData>(
      routes: [
        TypedGoRoute<TodoListRoute>(
          path: '/todos',
          routes: [
            TypedGoRoute<CreateTodoRoute>(path: 'create'),
            TypedGoRoute<TodoDetailRoute>(path: ':id'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<StatsBranchData>(
      routes: [
        TypedGoRoute<StatsRoute>(path: '/stats'),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return _ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}

// ─── BottomNavigationBar を持つシェル ─────────────────────────

class _ScaffoldWithNavBar extends StatelessWidget {
  const _ScaffoldWithNavBar({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        // 選択中・未選択でフォントサイズが変わらないよう固定する
        selectedFontSize: AppFontSize.sm,
        unselectedFontSize: AppFontSize.sm,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            // activeIcon: Icon(Icons.check_circle),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            // activeIcon: Icon(Icons.bar_chart),
            label: '統計',
          ),
        ],
      ),
    );
  }
}

// ─── Branch ───────────────────────────────────────────────────

class TodoBranchData extends StatefulShellBranchData {
  const TodoBranchData();
}

class StatsBranchData extends StatefulShellBranchData {
  const StatsBranchData();
}

// ─── GoRouteData ──────────────────────────────────────────────

class TodoListRoute extends GoRouteData with $TodoListRoute {
  const TodoListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TodoListPage();
}

class CreateTodoRoute extends GoRouteData with $CreateTodoRoute {
  const CreateTodoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreateTodoPage();
}

class TodoDetailRoute extends GoRouteData with $TodoDetailRoute {
  const TodoDetailRoute({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TodoDetailPage(id: id);
}

class StatsRoute extends GoRouteData with $StatsRoute {
  const StatsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const StatsPage();
}

// ─── GoRouter Provider ────────────────────────────────────────

@riverpod
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: '/todos',
    routes: $appRoutes,
  );
  ref.onDispose(router.dispose);
  return router;
}
