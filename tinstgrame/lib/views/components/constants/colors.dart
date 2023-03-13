import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Colors, Color;
import 'package:tinstgrame/extensions/string/string_to_color.dart';

@immutable
class AppColors {
  static final Color loginButtonColor = '#cfc9c2'.stringToColor();
  static const Color loginButtonTextColor = Colors.black;
  static final Color googleColor = '#4285F4'.stringToColor();
  static final Color facebookColor = '#3b5998'.stringToColor();
  const AppColors._();
}
