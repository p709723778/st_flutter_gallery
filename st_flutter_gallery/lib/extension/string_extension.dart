import 'package:characters/characters.dart';

const String nullChar = '\u{200B}';

extension StringExtension on String {
  String get breakWord {
    return characters.map((e) => "$e$nullChar").join();
  }
}
