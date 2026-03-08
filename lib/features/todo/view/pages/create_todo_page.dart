import 'package:flutter/material.dart';

class CreateTodoPage extends StatelessWidget {
  const CreateTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo作成')),
      body: const Center(child: Text('Todo作成画面')),
    );
  }
}
