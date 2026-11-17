import 'package:flutter/material.dart';

import '../../../results/presentation/screens/result_list_screen.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Process Screen")),
    floatingActionButton: ElevatedButton(
      onPressed: () => goNextPage(context),
      child: const Text("Send results to server"),
    ),
    floatingActionButtonLocation: .centerFloat,
    body: const Center(
      child: Column(
        mainAxisSize: .min,
        children: [
          Text("Calculating..."),
          SizedBox(height: 8),
          Text("90%"),
          Divider(),
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator.adaptive(
              value: 0.9,
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    ),
  );

  void goNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ResultListScreen()),
    );
  }
}
