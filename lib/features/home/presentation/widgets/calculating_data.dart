import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';
import '../providers/repository_provider.dart';

class CalculatingData extends StatefulWidget {
  const CalculatingData({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatingDataState();
}

class _CalculatingDataState extends State<CalculatingData> {
  late final Future<List<Task>> _tasksFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tasksFuture = RepositoryScope.of(context).getTasks();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _tasksFuture,
    builder: (context, asyncSnapshot) {
      if (asyncSnapshot.connectionState == .waiting) {
        return Column(
          mainAxisSize: .min,
          spacing: 8,
          children: [Text("Calculating..."), Text("90%")],
        );
      }
      if (asyncSnapshot.hasError) {
        return Text("ERROR: ${asyncSnapshot.error}");
      }

      return Text("done: ${asyncSnapshot.data}");
    },
  );
}
