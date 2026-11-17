import 'package:flutter/material.dart';

import '../widgets/field_map.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Preview Screen")),
    body: const Column(
      children: [
        Flexible(child: FieldMap()),
        Text("(1,2)->(2,1)"),
      ],
    ),
  );
}
