import 'package:flutter/material.dart';

import '../widgets/calculating_data.dart';
import '../../../results/presentation/screens/result_list_screen.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Process Screen")),
    body: Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        mainAxisSize: .max,
        mainAxisAlignment: .end,
        children: [
          const Spacer(),
          CalculatingData(),
          const Divider(),
          progressCircle(),
          const Spacer(),
          ElevatedButton(
            onPressed: () => goNextPage(context),
            child: const Text("Send results to server"),
          ),
        ],
      ),
    ),
  );

  Widget progressCircle() => SizedBox(
    width: 100,
    height: 100,
    child: CircularProgressIndicator(strokeWidth: 3),
  );

  void goNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ResultListScreen()),
    );
  }
}
