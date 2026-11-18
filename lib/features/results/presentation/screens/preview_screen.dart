import 'package:flutter/material.dart';

import '../../../home/domain/entities/pathfind_result.dart';
import '../widgets/field_map.dart';

class PreviewScreen extends StatelessWidget {
  final PathfindResult result;
  const PreviewScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Preview Screen")),
    body: Column(
      children: [
        Flexible(child: FieldMap(result: result)),
        Text(result.pathToString),
      ],
    ),
  );
}
