import 'dart:isolate';

import 'package:flutter/material.dart';

import '../../domain/repositories/task_repository.dart';
import '../../domain/services/a_star_path_finder.dart';
import '../../domain/entities/pathfind_result.dart';
import '../providers/repository_provider.dart';

class CalculatingData extends StatefulWidget {
  final ValueChanged<List<PathfindResult>> onCalculatingDone;
  const CalculatingData({required this.onCalculatingDone, super.key});

  @override
  State<StatefulWidget> createState() => _CalculatingDataState();
}

class _CalculatingDataState extends State<CalculatingData> {
  late final Stream<double?> _taskResultsStream;

  Stream<double?> _loadData(TaskRepository repo) async* {
    final tasks = await repo.getTasks();
    final processedTask = <PathfindResult>[];
    yield null;

    for (final (i, task) in tasks.indexed) {
      final path = await Isolate.run(
        () => AStarPathFinder.findShortestPath(
          stringField: task.field,
          start: task.start,
          end: task.end,
        ),
      );

      processedTask.add(PathfindResult(task: task, path: path));
      yield (i + 1) * 100 / tasks.length;
    }
    widget.onCalculatingDone(processedTask);
    yield 1.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _taskResultsStream = _loadData(RepositoryScope.of(context));
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: _taskResultsStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == .waiting) {
        return body("Fetching data...", 0);
      }
      if (snapshot.hasError) {
        //TODO: handle error
        return Text("ERROR: ${snapshot.error}");
      }
      final state = snapshot.data;
      if (state != null && state != 1.0) {
        return body("Calculating...", state.round());
      }

      return body(
        "All calculations has finished, you can send your results to server",
        100,
      );
    },
  );

  Widget body(String text, int percent) {
    return Column(
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(text, textAlign: .center),
        ),
        Text("$percent%"),
      ],
    );
  }
}
