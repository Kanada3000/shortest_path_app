import 'package:flutter/material.dart';

import 'preview_screen.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Result List Screen")),
    body: ListView.separated(
      itemCount: 3,
      itemBuilder: (listContext, i) => button(listContext, i),
      separatorBuilder: (_, _) => const Divider(),
    ),
  );

  Widget button(BuildContext context, int i) =>
      InkWell(onTap: () => goNextPage(context), child: item(i));

  Widget item(int i) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: Text("item: $i")),
  );

  void goNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PreviewScreen()),
    );
  }
}
