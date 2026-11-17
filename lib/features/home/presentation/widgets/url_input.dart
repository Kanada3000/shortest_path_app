import 'package:flutter/material.dart';

class UrlInput extends StatefulWidget {
  const UrlInput({super.key});

  @override
  State<UrlInput> createState() => _UrlInputState();
}

class _UrlInputState extends State<UrlInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.compare_arrows_sharp),
      const SizedBox(width: 32),
      Expanded(child: TextField(controller: _controller)),
    ],
  );
}
