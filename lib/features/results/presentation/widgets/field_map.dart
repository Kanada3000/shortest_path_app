import 'package:flutter/material.dart';

class FieldMap extends StatelessWidget {
  final List<String> field;
  const FieldMap({super.key, required this.field});

  // static const field = ["XXXE", "X.OX", "XO.X", "SXXX"];

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    children: field.indexed
        .map(
          ((int, String) rowEntry) => Row(
            mainAxisSize: .max,
            children: rowEntry.$2
                .split("")
                .indexed
                .map(
                  ((int, String) itemEntry) =>
                      tile(rowEntry.$1, itemEntry.$1, itemEntry.$2),
                )
                .toList(),
          ),
        )
        .toList(),
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
            "($i,$j)",
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
