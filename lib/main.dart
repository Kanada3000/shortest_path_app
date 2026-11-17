import 'package:flutter/material.dart';

import 'features/home/data/datasources/task_remote_datasource.dart';
import 'features/home/data/repositories/task_repository_impl.dart';
import 'features/home/presentation/providers/repository_provider.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() {
  final remoteDataSource = TaskRemoteDataSourceImpl();
  final taskRepository = TaskRepositoryImpl(remoteDataSource);

  runApp(
    RepositoryScope(taskRepository: taskRepository, child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
