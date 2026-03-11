// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_local_source.dart';

// ignore_for_file: type=lint
mixin _$TodoLocalSourceMixin on DatabaseAccessor<AppDatabase> {
  $TodosTable get todos => attachedDatabase.todos;
  TodoLocalSourceManager get managers => TodoLocalSourceManager(this);
}

class TodoLocalSourceManager {
  final _$TodoLocalSourceMixin _db;
  TodoLocalSourceManager(this._db);
  $$TodosTableTableManager get todos =>
      $$TodosTableTableManager(_db.attachedDatabase, _db.todos);
}
