import 'package:flutter/material.dart';

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo詳細')),
      body: Center(child: Text('Todo詳細画面 (id: $id)')),
    );
  }
}
