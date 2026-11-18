import 'package:flutter/material.dart';

import '../../../home/domain/entities/pathfind_result.dart';
import 'preview_screen.dart';

class ResultListScreen extends StatelessWidget {
  final List<PathfindResult> results;
  const ResultListScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Result List Screen")),
    body: ListView.separated(
      itemCount: results.length,
      itemBuilder: (listContext, i) => button(listContext, i),
      separatorBuilder: (_, _) => const Divider(),
    ),
  );

  Widget button(BuildContext context, int i) =>
      InkWell(onTap: () => goNextPage(context), child: item(i));

  Widget item(int i) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: Text(results[i].pathToString)),
  );

  void goNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PreviewScreen()),
    );
  }
}
