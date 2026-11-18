import 'package:flutter/material.dart';

import 'process_screen.dart';
import '../widgets/url_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Home Screen")),
    body: const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text("Set valid API base in order to continue"),
          SizedBox(height: 16),
          Flexible(child: UrlForm()),
        ],
      ),
    ),
  );

  void goNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProcessScreen()),
    );
  }
}
