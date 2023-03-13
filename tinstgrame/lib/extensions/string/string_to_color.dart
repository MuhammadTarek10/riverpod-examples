import 'package:flutter/material.dart';
import 'package:tinstgrame/extensions/string/remove_all.dart';

extension StringToColor on String {
  Color stringToColor() => Color(
        int.parse(
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix: 16,
        ),
      );
}
