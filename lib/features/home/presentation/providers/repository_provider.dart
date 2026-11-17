import 'package:flutter/material.dart';

import '../../domain/repositories/task_repository.dart';

class RepositoryScope extends InheritedWidget {
  final TaskRepository taskRepository;

  const RepositoryScope({
    super.key,
    required this.taskRepository,
    required super.child,
  });

  static TaskRepository of(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<RepositoryScope>();
    assert(scope != null, "No RepositoryScope found in context");
    return scope!.taskRepository;
  }

  @override
  bool updateShouldNotify(RepositoryScope oldScope) {
    return taskRepository != oldScope.taskRepository;
  }
}
