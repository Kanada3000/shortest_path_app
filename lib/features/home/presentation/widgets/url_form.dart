import 'package:flutter/material.dart';
import 'package:shortest_path_app/core/utils/url_validator.dart';

import '../providers/repository_scope.dart';
import '../screens/process_screen.dart';

class UrlForm extends StatefulWidget {
  const UrlForm({super.key});

  @override
  State<UrlForm> createState() => _UrlFormState();
}

class _UrlFormState extends State<UrlForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController(
    text: "https://flutter.webspark.dev/flutter/api",
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      mainAxisSize: .min,
      children: [
        Row(
          children: [
            const Icon(Icons.compare_arrows_sharp),
            const SizedBox(width: 32),
            Expanded(
              child: TextFormField(
                controller: _controller,
                keyboardType: .url,
                validator: UrlValidator.validate,
              ),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => _onPress(context),
          child: const Text("Start counting process"),
        ),
      ],
    ),
  );

  void _onPress(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      RepositoryScope.of(context).setUrl(_controller.text.trim());
      _goNextPage(context);
    }
  }

  void _goNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProcessScreen()),
    );
  }
}
