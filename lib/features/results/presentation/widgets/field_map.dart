import 'package:flutter/material.dart';

import '../../../home/domain/entities/pathfind_result.dart';

class FieldMap extends StatelessWidget {
  final PathfindResult result;
  const FieldMap({super.key, required this.result});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    children: [
      for (final (i, row) in result.fieldWithPath.indexed)
        Row(
          mainAxisSize: .max,
          children: [
            for (final (j, item) in row.indexed) tile(i, j, item),
          ],
        ),
    ],
  );

  Widget tile(int i, int j, String symbol) => Expanded(
    child: AspectRatio(
      aspectRatio: 1 / 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: symbolToColor(symbol),
          border: BoxBorder.all(),
        ),
        child: Center(
          child: Text(
            "($j,$i)",
            style: TextStyle(color: symbol == 'X' ? Colors.white : null),
          ),
        ),
      ),
    ),
  );

  Color symbolToColor(String symbol) => switch (symbol) {
    'X' => Color(0xFF000000),
    'S' => Color(0xFF64FFDA),
    'E' => Color(0xFF009688),
    'O' => Color(0xFF4CAF50),
    _ => Color(0xFFFFFFFF),
  };
}
